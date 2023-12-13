-- Enable TimescaleDB extension
CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;

-- Create a table with a JSONB 'value' column
CREATE TABLE IF NOT EXISTS metrics (
   database_timestamp TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
   server_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
   datatype TEXT NOT NULL,
   topic TEXT NOT NULL,
   data JSONB NOT NULL
);

-- Convert the table into a hypertable
SELECT create_hypertable('metrics', 'created');

-- Enable compression
ALTER TABLE metrics SET (timescaledb.compress);

-- Set up a compression policy
SELECT add_compression_policy('metrics', INTERVAL '7 days');
