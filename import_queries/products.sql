DROP TABLE IF EXISTS products;

CREATE TABLE IF NOT EXISTS public.products
(
    "SKU" character varying COLLATE pg_catalog."default",
    "name" character varying COLLATE pg_catalog."default",
    "orderedQuantity" integer,
    "stockLevel" integer,
    "restockingLeadTime" integer,
    "sentimentScore" double precision,
    "sentimentMagnitude" double precision
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;