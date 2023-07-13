DROP TABLE IF EXISTS analytics;

CREATE TABLE IF NOT EXISTS public.analytics
(
    "visitNumber" integer,
    "visitId" bigint,
    "visitStartTime" bigint,
    "date" date,
    "fullVisitorId" character varying COLLATE pg_catalog."default",
    "userId" character varying COLLATE pg_catalog."default",
    "channelGrouping" character varying COLLATE pg_catalog."default",
    "socialEngagementType" character varying COLLATE pg_catalog."default",
    "units_sold" integer,
    "pageViews" integer,
    "timeOnSite" integer,
    "bounces" integer,
    "revenue" bigint,
    "unit_price" bigint
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.analytics
    OWNER to postgres;