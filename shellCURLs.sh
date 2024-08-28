
#!/bin/bash
pipes_response=$(curl "https://${TB_HOST}.tinybird.co/v0/pipes/edp_datadog_pipes_stats.ndjson?token=${TB_TOKEN}")
pipes_rows=$(echo "$pipes_response" | grep count | wc -l)
echo $pipes_rows
if [ "$pipes_row" != 0 ]; then
  curl "https://${TB_HOST}.tinybird.co/v0/pipes/edp_datadog_pipes_stats.ndjson?token=${TB_TOKEN}" | vector --config vector-pipes-stats.toml
fi
ops_response=$(curl "https://${TB_HOST}.tinybird.co/v0/pipes/edp_datadog_ops_log.ndjson?token=${TB_TOKEN}")
echo $ops_response
ops_rows=$(echo "$ops_response" | grep rows | wc -l)
echo $ops_rows
if [ "$ops_rows" != 0 ]; then
  curl "https://${TB_HOST}.tinybird.co/v0/pipes/edp_datadog_ops_log.ndjson?token=${TB_TOKEN}" | vector --config vector-ops-log.toml
fi