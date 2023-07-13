DROP TABLE IF EXISTS sales_by_sku;

CREATE TABLE IF NOT EXISTS public.sales_by_sku
(
    "productSKU" character varying COLLATE pg_catalog."default",
    "total_ordered" integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sales_by_sku
    OWNER to postgres;