SELECT
  user_id,

  -- Clean event types
  CASE
    WHEN LOWER(event_type) IN ('clck', 'click') THEN 'click'
    WHEN LOWER(event_type) IN ('srch', 'search') THEN 'search'
    ELSE event_type
  END AS event_type_cleaned,

  event_timestamp,

  -- Extract from nested JSON
  device_info:os::STRING         AS os,
  device_info:version::STRING    AS os_version,
  location:country::STRING       AS country,
  location:city::STRING          AS city,
  event_props:product_id::STRING AS product_id,
  event_props:page_url::STRING   AS page_url,
  event_props:search_term::STRING AS search_term

FROM {{ source('RAW', 'event_logs_raw') }}
