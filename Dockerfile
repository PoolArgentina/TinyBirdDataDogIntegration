FROM timberio/vector:latest-alpine

ARG A_DATADOG_API_KEY
ARG A_DATADOG_SITE
ARG A_TB_HOST
ARG A_TB_TOKEN

ENV PYTHONPATH="/working_area"
ENV DATADOG_API_KEY=$A_DATADOG_API_KEY
ENV DATADOG_SITE=$A_DATADOG_SITE
ENV TB_HOST=$A_TB_HOST
ENV TB_TOKEN=$A_TB_TOKEN

WORKDIR /working_area

# Copio el archivo de configuración de Vector
COPY vector-pipes-stats.toml .
COPY vector-ops-log.toml .


# Instalo vector
RUN apk add --no-cache curl bash && \ 
    curl --proto '=https' --tlsv1.2 -sSfL https://sh.vector.dev | bash -s -- -y --prefix /usr/local

# Ejecuto el CURL que envia la info a DataDog
RUN curl "https://${TB_HOST}.tinybird.co/v0/pipes/ep_datadog_pipes_stats.ndjson?token=${TB_TOKEN}" | vector --config vector-pipes-stats.toml
RUN curl "https://${TB_HOST}.tinybird.co/v0/pipes/ep_datadog_ops_log.ndjson?token=${TB_TOKEN}" | vector --config vector-ops-log.toml
