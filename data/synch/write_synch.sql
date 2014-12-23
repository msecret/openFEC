
select format('
  UPDATE %I.%I AS p
  SET    expire_date = o.expire_date
  FROM   %I.%I AS o
  WHERE  p.%I = o.%I
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  ',
  tc.table_schema, tc.table_name,
  CASE tc.table_schema WHEN 'processed' THEN 'processed_fec' ELSE 'frn' END,
    c.table_name,
  kc.column_name, kc.column_name)
from
    information_schema.table_constraints tc,
    information_schema.key_column_usage kc,
    information_schema.columns c
where
    tc.constraint_type = 'PRIMARY KEY'
    and kc.table_name = tc.table_name and kc.table_schema = tc.table_schema
    and kc.constraint_name = tc.constraint_name
    and tc.table_schema in ('public', 'processed')
    and c.column_name = 'expire_date'
    and tc.table_catalog = c.table_catalog
    and tc.table_schema = c.table_schema
    and tc.table_name = c.table_name;



select format('
  WITH missing AS (
    SELECT %I FROM %I.%I
    EXCEPT ALL
    SELECT %I FROM %I.%I )
  INSERT INTO %I.%I
  SELECT f.*
  FROM   %I.%I f
  JOIN   missing ON (f.%I = missing.%I);
  ',
  kc.column_name,
    CASE tc.table_schema WHEN 'processed' THEN 'processed_fec' ELSE 'frn' END,
    tc.table_name,
  kc.column_name,
    tc.table_schema,
    tc.table_name,
  tc.table_schema, tc.table_name,
  CASE tc.table_schema WHEN 'processed' THEN 'processed_fec' ELSE 'frn' END,
    tc.table_name,
  kc.column_name, kc.column_name)
from
    information_schema.table_constraints tc,
    information_schema.key_column_usage kc
where
    tc.constraint_type = 'PRIMARY KEY'
    and kc.table_name = tc.table_name and kc.table_schema = tc.table_schema
    and kc.constraint_name = tc.constraint_name
    and tc.table_schema in ('public', 'processed');
