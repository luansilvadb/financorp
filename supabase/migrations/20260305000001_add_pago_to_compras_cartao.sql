-- Migration: Add 'pago' column to 'compras_cartao'
ALTER TABLE IF EXISTS compras_cartao
ADD COLUMN pago BOOLEAN NOT NULL DEFAULT FALSE;
