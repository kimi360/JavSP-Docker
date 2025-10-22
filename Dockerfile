FROM python:3.12-slim AS builder

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends git=1:2.47.3-0+deb13u1 && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir pipx==1.8.0 && \
    pipx ensurepath && \
    pipx install poetry==2.2.1

RUN git clone https://github.com/Yuukiy/JavSP.git /app && \
    sed -i 's|https://pypi\.tuna\.tsinghua\.edu\.cn/simple|https://pypi.org/simple|g' poetry.lock

RUN poetry self add poetry-dynamic-versioning && \
    poetry config virtualenvs.in-project true && \
    poetry install --no-interaction --no-ansi

RUN poetry run python setup.py build_exe -b dist

FROM debian:bookworm-slim AS runner

WORKDIR /app

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONIOENCODING=utf-8

COPY --from=builder /app/dist /app/

ENTRYPOINT ["/app/JavSP"]