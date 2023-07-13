DROP TABLE IF EXISTS all_sessions;

CREATE TABLE IF NOT EXISTS public.all_sessions
(
    "fullVisitorId" character varying COLLATE pg_catalog."default",
    "channelGrouping" character varying COLLATE pg_catalog."default",
    "time" integer,
    country character varying COLLATE pg_catalog."default",
    city character varying COLLATE pg_catalog."default",
    "totalTransactionRevenue" integer,
    transactions integer,
    timeonsite integer,
    pageviews integer,
    "sessionQualityDim" integer,
    date date,
    visitid character varying COLLATE pg_catalog."default",
    type character varying COLLATE pg_catalog."default",
    "productRefundAmount" integer,
    "productQuantity" integer,
    "productPrice" integer,
    "productRevenue" integer,
    "productSKU" character varying COLLATE pg_catalog."default",
    "v2ProductName" character varying COLLATE pg_catalog."default",
    "v2ProductCategoty" character varying COLLATE pg_catalog."default",
    "productVariant" character varying COLLATE pg_catalog."default",
    "currencyCode" character varying COLLATE pg_catalog."default",
    "itemQuantity" integer,
    "itemRevenue" integer,
    "transactionRevenue" integer,
    transactionid character varying COLLATE pg_catalog."default",
    pagetitle character varying COLLATE pg_catalog."default",
    "searchKetword" character varying COLLATE pg_catalog."default",
    "pagePathLevel1" character varying COLLATE pg_catalog."default",
    "eCommerceAction_type" character varying COLLATE pg_catalog."default",
    "eCommerceAction_step" integer,
    "eCommerceAction_option" character varying COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.all_sessions
    OWNER to postgres;