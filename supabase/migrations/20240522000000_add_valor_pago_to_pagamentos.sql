-- Migration: Add valor_pago to pagamentos table
ALTER TABLE pagamentos ADD COLUMN IF NOT EXISTS valor_pago NUMERIC NOT NULL DEFAULT 0;
