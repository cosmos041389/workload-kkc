CREATE TABLE P1 (
  ID INTEGER NOT NULL,
  TINY TINYINT,
  SMALL SMALLINT,
  BIG BIGINT,
  PRIMARY KEY (ID)
);
PARTITION TABLE P1 ON COLUMN ID;

CREATE TABLE P2 (
  ID INTEGER NOT NULL,
  TINY TINYINT,
  SMALL SMALLINT,
  BIG BIGINT,
  PRIMARY KEY (ID)
);
PARTITION TABLE P2 ON COLUMN ID;

CREATE TABLE P3 (
  ID INTEGER NOT NULL,
  TINY TINYINT,
  SMALL SMALLINT,
  BIG BIGINT,
  PRIMARY KEY (ID)
);
PARTITION TABLE P3 ON COLUMN ID;

CREATE TABLE R1 (
  ID INTEGER NOT NULL,
  TINY TINYINT,
  SMALL SMALLINT,
  BIG BIGINT,
  PRIMARY KEY (ID)
);

CREATE TABLE R2 (
  ID INTEGER NOT NULL,
  TINY TINYINT,
  SMALL SMALLINT,
  BIG BIGINT,
  PRIMARY KEY (ID)
);

CREATE TABLE R3 (
  ID INTEGER NOT NULL,
  TINY TINYINT,
  SMALL SMALLINT,
  BIG BIGINT,
  PRIMARY KEY (ID)
);


-- Define some Materialized Views using Joins; note that we mostly use the same
-- column names used above in the table definitions, since those are the only
-- column names that will be used explicitly in SELECT statements generated from
-- query templates (though SELECT * is also sometimes used, so all columns will
-- be tested, to some extent)

-- Minimal Materialized Views using Joins with 1 column: COUNT(*) only
CREATE VIEW V0 (ID) AS
  SELECT COUNT(*) FROM P1 T1 JOIN P2 T2 ON T1.ID = T2.ID;

CREATE VIEW V1 (ID) AS
  SELECT COUNT(*) FROM P1 T1 JOIN R1 T2 ON T1.ID = T2.SMALL;

CREATE VIEW V2 (ID) AS
  SELECT COUNT(*) FROM R1 T1 JOIN R2 T2 ON T1.SMALL = T2.SMALL;


-- "Simple" Materialized Views using Joins with 2 columns: 1 COUNT(*), 1 Aggregate Function
CREATE VIEW V3 (ID, BIG) AS
  SELECT COUNT(*),   MIN(T2.BIG)   FROM P1 T1 JOIN P2 T2 USING(ID);

CREATE VIEW V4 (ID, TINY) AS
  SELECT COUNT(*),   MAX(T2.TINY)  FROM P1 T1 JOIN R1 T2 ON T1.SMALL = T2.ID;

CREATE VIEW V5 (BIG, ID) AS
  SELECT COUNT(*),   SUM(T1.ID)    FROM R2 T1 JOIN P2 T2 USING(SMALL);

CREATE VIEW V6 (ID, SMALL) AS
  SELECT COUNT(*), COUNT(T1.SMALL) FROM R1 T1 JOIN R2 T2 ON T1.ID = T2.ID;


-- "Simple" Materialized Views using Joins with 2 columns: 1 GROUP BY, 1 COUNT(*)
CREATE VIEW V7 (BIG, ID) AS
  SELECT   T1.BIG,   COUNT(*) FROM P1 T1 JOIN P2 T2 ON T1.ID = T2.ID
  GROUP BY T1.BIG;

CREATE VIEW V8 (SMALL, ID) AS
  SELECT   T1.SMALL, COUNT(*) FROM P1 T1 JOIN R1 T2 ON T1.ID = T2.ID
  GROUP BY T1.SMALL;

CREATE VIEW V9 (TINY, ID) AS
  SELECT   T1.TINY,  COUNT(*) FROM R2 T1 JOIN P2 T2 ON T1.SMALL = T2.ID
  GROUP BY T1.TINY;

CREATE VIEW V10 (ID, SMALL) AS
  SELECT   T1.ID,    COUNT(*) FROM R1 T1 JOIN R2 T2 USING(SMALL)
  GROUP BY T1.ID;


-- "Normal" Materialized Views using Joins with 3 columns: 1 GROUP BY, 1 COUNT(*), 1 Aggregate Function
CREATE VIEW V11 (TINY, ID, SMALL) AS
  SELECT   T1.TINY,  COUNT(*),   MIN(T1.SMALL) FROM P1 T1 JOIN P2 T2 ON T1.ID = T2.ID
  GROUP BY T1.TINY;

CREATE VIEW V12 (SMALL, ID, BIG) AS
  SELECT   T1.SMALL, COUNT(*),   MAX(T2.BIG)   FROM P1 T1 JOIN P2 T2 USING(ID)
  GROUP BY T1.SMALL;

CREATE VIEW V13 (BIG, SMALL, ID) AS
  SELECT   T2.BIG,   COUNT(*),   SUM(T1.ID)    FROM P1 T1 JOIN R1 T2 USING(ID)
  GROUP BY T2.BIG;

CREATE VIEW V14 (ID, SMALL, TINY) AS
  SELECT   T2.ID,    COUNT(*), COUNT(T2.TINY)  FROM P1 T1 JOIN R1 T2 ON T1.ID = T2.SMALL
  GROUP BY T2.ID;

CREATE VIEW V15 (BIG, ID, TINY) AS
  SELECT   T1.BIG,   COUNT(*),   MIN(T2.TINY)  FROM R2 T1 JOIN P2 T2 ON T1.SMALL = T2.SMALL
  GROUP BY T1.BIG;

CREATE VIEW V16 (ID, BIG, SMALL) AS
  SELECT   T2.SMALL, COUNT(*),   MAX(T1.SMALL) FROM R1 T1 JOIN R2 T2 ON T1.ID = T2.ID
  GROUP BY T2.SMALL;

CREATE VIEW V17 (TINY, ID, BIG) AS
  SELECT   T1.TINY,  COUNT(*),   SUM(T2.BIG)   FROM R1 T1 JOIN R2 T2 ON T1.SMALL = T2.ID
  GROUP BY T1.TINY;

CREATE VIEW V18 (SMALL, BIG, ID) AS
  SELECT   T1.SMALL, COUNT(*), COUNT(T1.ID)    FROM R1 T1 JOIN R2 T2 USING(SMALL)
  GROUP BY T1.SMALL;


-- "Normal-plus" Materialized Views using Joins with 4 or more columns
CREATE VIEW V19 (BIG, ID, SMALL, TINY) AS
  SELECT   T1.BIG,             COUNT(*), COUNT(T2.SMALL), MAX(T2.TINY) FROM P1 T1 JOIN P2 T2 ON T1.ID = T2.ID
  GROUP BY T1.BIG;

CREATE VIEW V20 (ID, BIG, SMALL, TINY) AS
  SELECT   T1.ID,    T2.BIG,   COUNT(*),   MIN(T1.TINY)                FROM P1 T1 JOIN R1 T2 ON T1.ID  = T2.SMALL
  GROUP BY T1.ID,    T2.BIG;

CREATE VIEW V21 (SMALL, TINY, COUNT_STAR, BIG, ID) AS
  SELECT   T2.SMALL, T2.TINY,  COUNT(*),   MIN(T1.BIG), COUNT(T2.ID)   FROM R2 T1 JOIN P2 T2 ON T1.ID  = T2.SMALL
  GROUP BY T2.SMALL, T2.TINY;

CREATE VIEW V22 (TINY, SMALL, COUNT_STAR, ID, BIG) AS
  SELECT   T1.TINY,  T2.SMALL, COUNT(*),   MAX(T2.ID),    SUM(T1.BIG)  FROM R1 T1 JOIN R2 T2 ON T1.SMALL = T2.SMALL
  GROUP BY T1.TINY,  T2.SMALL;

CREATE VIEW V23 (SMALL, TINY, SMALL2, COUNT_STAR, ID, BIG, BIG2) AS
  SELECT   T1.SMALL, T1.TINY, T2.SMALL, COUNT(*), MIN(T2.ID), MAX(T1.BIG), SUM(T2.BIG) FROM P1 T1 JOIN R1 T2 ON T1.ID = T2.ID
  GROUP BY T1.SMALL, T1.TINY, T2.SMALL;


-- "Abnormal" Materialized Views using Joins that are not equi-joins (cannot use 2 partitioned tables)
CREATE VIEW V24 (SMALL, ID, SMALL2) AS
  SELECT   T1.SMALL, COUNT(*),   MIN(T2.SMALL) FROM P1 T1 JOIN R1 T2 ON T1.ID  <  T2.ID
  GROUP BY T1.SMALL;

CREATE VIEW V25 (BIG, ID, TINY) AS
  SELECT   T1.BIG,   COUNT(*),   MAX(T2.TINY)  FROM R2 T1 JOIN P2 T2 ON T1.ID  >  T2.SMALL
  GROUP BY T1.BIG;

CREATE VIEW V26 (ID, SMALL, BIG) AS
  SELECT   T1.ID,    COUNT(*),   SUM(T2.BIG)   FROM R1 T1 JOIN R2 T2 ON T1.SMALL <= T2.SMALL
  GROUP BY T1.ID;

CREATE VIEW V27 (TINY, ID, SMALL) AS
  SELECT   T1.TINY,  COUNT(*), COUNT(T2.SMALL) FROM R1 T1 JOIN R2 T2 ON T1.ID  >= T2.SMALL
  GROUP BY T1.TINY;


-- Cross-joins (cannot cross-join 2 partitioned tables)
CREATE VIEW V28 (SMALL, ID, TINY) AS
  SELECT   T1.SMALL, COUNT(*),   MIN(T2.TINY)  FROM P1 T1 CROSS JOIN R1 T2
  GROUP BY T1.SMALL;

CREATE VIEW V29 (TINY, ID, BIG) AS
  SELECT   T1.TINY,  COUNT(*),   MAX(T2.BIG)   FROM R2 T1 CROSS JOIN P2 T2
  GROUP BY T1.TINY;

CREATE VIEW V30 (BIG, ID, SMALL) AS
  SELECT   T1.BIG,   COUNT(*), COUNT(T2.SMALL) FROM R1 T1 CROSS JOIN R2 T2
  GROUP BY T1.BIG;


-- "Complex" Materialized Views using Joins on 3 tables
CREATE VIEW V31 (TINY, BIG, SMALL, ID) AS
  SELECT   T1.TINY,  COUNT(*),   MIN(T2.SMALL), COUNT(T3.BIG)   FROM P1 T1 JOIN P2 T2 ON T1.ID = T2.ID JOIN P3 T3 ON T2.ID = T3.ID
  GROUP BY T1.TINY;

CREATE VIEW V32 (SMALL, ID, BIG, TINY) AS
  SELECT   T1.SMALL, COUNT(*),   MAX(T2.BIG),     MIN(T3.TINY)  FROM P1 T1 JOIN P2 T2 ON T1.ID = T2.ID JOIN R1 T3 ON T2.ID = T3.ID
  GROUP BY T1.SMALL;

CREATE VIEW V33 (BIG, ID, TINY, SMALL) AS
  SELECT   T1.BIG,   COUNT(*), COUNT(T2.TINY),    SUM(T3.SMALL) FROM P1 T1 JOIN R1 T2 ON T1.ID = T2.ID JOIN R2 T3 ON T2.ID = T3.ID
  GROUP BY T1.BIG;

CREATE VIEW V34 (BIG, ID, SMALL, TINY) AS
  SELECT   T1.BIG,   COUNT(*),   SUM(T2.SMALL),   MAX(T3.TINY)  FROM R1 T1 JOIN R2 T2 ON T1.ID = T2.ID JOIN R3 T3 ON T2.ID = T3.ID
  GROUP BY T1.BIG;


-- Joins on 4 tables!
CREATE VIEW V35 (TINY, SMALL, COUNT_STAR, BIG, ID) AS
  SELECT   T1.TINY,  T2.SMALL, COUNT(*), MIN(T3.BIG), COUNT(T4.TINY) FROM P1 T1 JOIN P2 T2 ON T1.ID = T2.ID JOIN R1 T3 ON T2.ID = T3.ID JOIN R2 T4 ON T2.ID = T4.ID
  GROUP BY T1.TINY,  T2.SMALL;

CREATE VIEW V36 (SMALL, BIG,   COUNT_STAR, TINY, ID) AS
  SELECT   T1.SMALL, T2.BIG,   COUNT(*), MAX(T3.TINY),  SUM(T4.ID)   FROM P1 T1 JOIN P2 T2 ON T1.ID = T2.ID JOIN R1 T3 ON T2.ID = T3.ID JOIN R2 T4 ON T3.ID = T4.ID
  GROUP BY T1.SMALL, T2.BIG;
