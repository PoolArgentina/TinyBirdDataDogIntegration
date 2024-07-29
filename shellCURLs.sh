#!/bin/bash

curl "https://${TB_HOST}.tinybird.co/v0/pipes/edp_datadog_pipes_stats.ndjson?token=${TB_TOKEN}" | vector --config vector-pipes-stats-errors.toml
curl "https://${TB_HOST}.tinybird.co/v0/pipes/edp_datadog_ops_log.ndjson?token=${TB_TOKEN}" | vector --config vector-ops-log.toml