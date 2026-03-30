-- Sessions: spaces in key text columns
SELECT 
  SUM(CASE WHEN utm_source != TRIM(utm_source) THEN 1 ELSE 0 END) AS utm_source_spaces,
  SUM(CASE WHEN utm_campaign != TRIM(utm_campaign) THEN 1 ELSE 0 END) AS utm_campaign_spaces,
  SUM(CASE WHEN device_type != TRIM(device_type) THEN 1 ELSE 0 END) AS device_type_spaces,
  SUM(CASE WHEN http_referer != TRIM(http_referer) THEN 1 ELSE 0 END) AS http_referer_spaces
FROM website_sessions; 

SET SQL_SAFE_UPDATES = 0;
UPDATE website_sessions 
SET http_referer = TRIM(http_referer)
WHERE http_referer != TRIM(http_referer); 
select * from website_sessions;

SELECT DISTINCT utm_source FROM website_sessions ORDER BY utm_source;
SELECT DISTINCT utm_campaign FROM website_sessions ORDER BY utm_campaign;
SELECT DISTINCT device_type FROM website_sessions ORDER BY device_type;
SELECT DISTINCT pageview_url FROM website_pageviews ORDER BY pageview_url;


-- ashan socialbook w pilot msh mawgoudin fl pdf
SELECT utm_source, utm_campaign, COUNT(*) as cnt
FROM website_sessions
WHERE utm_source = 'socialbook'
   OR utm_campaign IN ('desktop_targeted', 'pilot')
GROUP BY utm_source, utm_campaign;

-- Pageviews created BEFORE their session started
SELECT COUNT(*) as impossible_timestamps
FROM website_pageviews pv
JOIN website_sessions ws ON pv.website_session_id = ws.website_session_id
WHERE pv.created_at < ws.created_at;
-- Sessions with NULL timestamps
SELECT COUNT(*) as null_timestamps
FROM website_sessions
WHERE created_at IS NULL;
-- Orders created BEFORE their session
SELECT COUNT(*) as impossible_order_timestamps
FROM orders o
JOIN website_sessions ws ON o.website_session_id = ws.website_session_id
WHERE o.created_at < ws.created_at;

-- The 10 problematic records
SELECT 
    pv.website_pageview_id,
    pv.website_session_id,
    pv.created_at AS pageview_time,
    ws.created_at AS session_time,
    TIMESTAMPDIFF(SECOND, ws.created_at, pv.created_at) AS diff_seconds
FROM website_pageviews pv
JOIN website_sessions ws ON pv.website_session_id = ws.website_session_id
WHERE pv.created_at < ws.created_at; 

SELECT 
    SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) as null_timestamps,
    SUM(CASE WHEN website_session_id IS NULL THEN 1 ELSE 0 END) as null_session_ids,
    SUM(CASE WHEN pageview_url IS NULL THEN 1 ELSE 0 END) as null_urls
FROM website_pageviews;

SELECT 
    COUNT(*) as total_orders,
    SUM(CASE WHEN price_usd = 0 THEN 1 ELSE 0 END) as zero_price,
    SUM(CASE WHEN price_usd < 0 THEN 1 ELSE 0 END) as negative_price,
    SUM(CASE WHEN cogs_usd = 0 THEN 1 ELSE 0 END) as zero_cogs,
    SUM(CASE WHEN cogs_usd < 0 THEN 1 ELSE 0 END) as negative_cogs,
    SUM(CASE WHEN cogs_usd > price_usd THEN 1 ELSE 0 END) as cost_exceeds_price
FROM orders;
SELECT 
    order_id, 
    price_usd, 
    cogs_usd,
    'Price is zero or negative' AS issue_category
FROM orders 
WHERE price_usd <= 0

UNION ALL

SELECT 
    order_id, 
    price_usd, 
    cogs_usd,
    'COGS is negative' AS issue_category
FROM orders 
WHERE cogs_usd < 0

UNION ALL

SELECT 
    order_id, 
    price_usd, 
    cogs_usd,
    'COGS exceeds selling price' AS issue_category
FROM orders 
WHERE cogs_usd > price_usd; 

SELECT * FROM orders
WHERE price_usd <= 0 OR cogs_usd <= 0 OR cogs_usd > price_usd;  

-- FOR PRESENTATION **********
-- DATA QUALITY AUDIT REPORT

-- 1. Financial Issues in the Orders Table
SELECT 
    'Orders' AS table_name,
    'Price is Zero or Negative' AS issue_category,
    COUNT(*) AS issue_count
FROM orders 
WHERE price_usd <= 0

UNION ALL

SELECT 
    'Orders' AS table_name,
    'COGS exceeds Price (Loss)' AS issue_category,
    COUNT(*) AS issue_count
FROM orders 
WHERE cogs_usd > price_usd

UNION ALL

-- 2. Integrity Issues in the Sessions Table
SELECT 
    'Sessions' AS table_name,
    'Duplicate Sessions (Same User/Time)' AS issue_category,
    COUNT(*)
FROM (
    SELECT user_id, created_at 
    FROM website_sessions 
    GROUP BY user_id, created_at 
    HAVING COUNT(*) > 1
) AS dup_sessions

UNION ALL

-- 3. Logical Timing Issues (Pageviews before Session start)
SELECT 
    'Pageviews' AS table_name,
    'Impossible Timestamp (View before Session)' AS issue_category,
    COUNT(DISTINCT p.website_session_id)
FROM website_pageviews p
JOIN website_sessions s 
    ON p.website_session_id = s.website_session_id
WHERE p.created_at < s.created_at

UNION ALL

-- 4. No Session ID match
SELECT 
    'Orders' AS table_name,
    'No Session ID match' AS issue_category,
    COUNT(*)
FROM orders o
LEFT JOIN website_sessions s 
    ON o.website_session_id = s.website_session_id
WHERE s.website_session_id IS NULL;

/* REFUND DATA QUALITY CHECK */
SELECT 
    'Refunds' AS table_name,
    'Refund > Item Price' AS issue_category,
    COUNT(*) AS issue_count
FROM order_item_refunds r
JOIN order_items i ON r.order_item_id = i.order_item_id
WHERE r.refund_amount_usd > i.price_usd

UNION ALL

SELECT 
    'Refunds',
    'Refund before Order Date',
    COUNT(*)
FROM order_item_refunds r
JOIN order_items i ON r.order_item_id = i.order_item_id
WHERE r.created_at < i.created_at

UNION ALL

SELECT 
    'Refunds',
    'Order ID Mismatch between Items & Refunds',
    COUNT(*)
FROM order_item_refunds r
JOIN order_items i ON r.order_item_id = i.order_item_id
WHERE r.order_id <> i.order_id;



