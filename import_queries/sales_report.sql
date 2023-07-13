DROP TABLE IF EXISTS sales_report;

CREATE TABLE IF NOT EXISTS public.sales_report
(
    "productSKU" character varying COLLATE pg_catalog."default",
    "total_ordered" integer,
    "name" character varying COLLATE pg_catalog."default",
    "stockLevel" integer,
    "restockingLeadTime" integer,
    "sentimentScore" double precision,
    "sentimentMagnitude" double precision,
    "ratio" double precision
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sales_report
    OWNER to postgres;