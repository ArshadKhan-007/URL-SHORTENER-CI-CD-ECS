import io
from datetime import datetime, timezone

import qrcode
from fastapi import FastAPI, Depends, HTTPException
from fastapi.responses import RedirectResponse, StreamingResponse
from sqlalchemy.orm import Session

from app.database import get_db
from app.config import settings
from app.schemas import (
    ShortenRequest,
    ShortenResponse,
    BulkShortenRequest,
    BulkShortenResponse,
    StatsResponse,
    HealthResponse,
)
from app.crud import (
    create_short_url,
    get_url_by_code,
    increment_click,
    check_db_connection,
)

app = FastAPI(
    title="URL Shortener",
    description="Minimal URL shortener — the real objective is the CI/CD pipeline.",
    version="1.0.0",
)


# ---------- POST /shorten ----------

@app.post("/shorten", response_model=ShortenResponse, status_code=201)
def shorten_url(request: ShortenRequest, db: Session = Depends(get_db)):
    """Shorten a single URL. Optionally provide a custom alias and/or expiry."""

    # Check for alias collision
    if request.custom_alias:
        existing = get_url_by_code(db, request.custom_alias)
        if existing:
            raise HTTPException(
                status_code=409,
                detail=f"Alias '{request.custom_alias}' is already taken.",
            )

    url_record = create_short_url(
        db=db,
        original_url=str(request.url),
        custom_alias=request.custom_alias,
        expires_at=request.expires_at,
    )

    return ShortenResponse(
        short_code=url_record.short_code,
        short_url=f"{settings.BASE_URL}/{url_record.short_code}",
        original_url=url_record.original_url,
    )


# ---------- POST /shorten/bulk ----------

@app.post("/shorten/bulk", response_model=BulkShortenResponse, status_code=201)
def shorten_bulk(request: BulkShortenRequest, db: Session = Depends(get_db)):
    """Bulk shorten — loops single-shorten logic, no new code path."""
    results = []
    for item in request.urls:
        if item.custom_alias:
            existing = get_url_by_code(db, item.custom_alias)
            if existing:
                raise HTTPException(
                    status_code=409,
                    detail=f"Alias '{item.custom_alias}' is already taken.",
                )

        url_record = create_short_url(
            db=db,
            original_url=str(item.url),
            custom_alias=item.custom_alias,
            expires_at=item.expires_at,
        )
        results.append(
            ShortenResponse(
                short_code=url_record.short_code,
                short_url=f"{settings.BASE_URL}/{url_record.short_code}",
                original_url=url_record.original_url,
            )
        )

    return BulkShortenResponse(results=results)


# ---------- GET /health ----------

@app.get("/health", response_model=HealthResponse)
def health_check(db: Session = Depends(get_db)):
    """Health check — verifies DB connectivity."""
    db_ok = check_db_connection(db)
    return HealthResponse(
        status="healthy" if db_ok else "unhealthy",
        database="connected" if db_ok else "disconnected",
    )


# ---------- GET /stats/{short_code} ----------

@app.get("/stats/{short_code}", response_model=StatsResponse)
def get_stats(short_code: str, db: Session = Depends(get_db)):
    """Return click count and metadata for a short code."""
    url_record = get_url_by_code(db, short_code)
    if not url_record:
        raise HTTPException(status_code=404, detail="Short code not found.")

    return StatsResponse(
        short_code=url_record.short_code,
        original_url=url_record.original_url,
        click_count=url_record.click_count,
        created_at=url_record.created_at,
        expires_at=url_record.expires_at,
    )


# ---------- GET /qr/{short_code} ----------

@app.get("/qr/{short_code}")
def get_qr_code(short_code: str, db: Session = Depends(get_db)):
    """Generate and return a QR code PNG for the short URL."""
    url_record = get_url_by_code(db, short_code)
    if not url_record:
        raise HTTPException(status_code=404, detail="Short code not found.")

    short_url = f"{settings.BASE_URL}/{url_record.short_code}"

    qr = qrcode.QRCode(version=1, box_size=10, border=4)
    qr.add_data(short_url)
    qr.make(fit=True)
    img = qr.make_image(fill_color="black", back_color="white")

    buffer = io.BytesIO()
    img.save(buffer, format="PNG")
    buffer.seek(0)

    return StreamingResponse(buffer, media_type="image/png")


# ---------- GET /{short_code} ----------

@app.get("/{short_code}")
def redirect_to_url(short_code: str, db: Session = Depends(get_db)):
    """Redirect to original URL (302). Returns 410 if expired, 404 if not found."""
    url_record = get_url_by_code(db, short_code)
    if not url_record:
        raise HTTPException(status_code=404, detail="Short code not found.")

    # Check expiry
    if url_record.expires_at:
        if url_record.expires_at.replace(tzinfo=timezone.utc) < datetime.now(timezone.utc):
            raise HTTPException(status_code=410, detail="This short URL has expired.")

    increment_click(db, short_code)
    return RedirectResponse(url=url_record.original_url, status_code=302)
