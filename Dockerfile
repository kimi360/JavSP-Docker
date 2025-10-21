FROM python:3.14-slim AS builder

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /app

RUN apt update && \
    apt install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

RUN pip install pipx && \
    pipx ensurepath && \
    pipx install poetry

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