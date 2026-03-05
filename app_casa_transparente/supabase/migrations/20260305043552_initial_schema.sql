-- Migration: Initial Schema for Casa Transparente App

-- 1. Tabela de Despesas Fixas
CREATE TABLE IF NOT EXISTS despesas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nome TEXT NOT NULL,
    dia_vencimento INTEGER NOT NULL,
    valor NUMERIC NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Tabela de Compras no Cartão (Luan)
CREATE TABLE IF NOT EXISTS compras_cartao (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    data DATE NOT NULL DEFAULT CURRENT_DATE,
    descricao TEXT NOT NULL,
    valor NUMERIC NOT NULL,
    pessoa TEXT NOT NULL, -- 'Luciana' ou 'Giovanna'
    mes INTEGER NOT NULL, -- 0-11
    ano INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Tabela de Status de Pagamento (Mensal)
CREATE TABLE IF NOT EXISTS pagamentos (
    id TEXT PRIMARY KEY, -- Formato: despesaId-pessoa-mes-ano
    despesa_id UUID REFERENCES despesas(id) ON DELETE CASCADE,
    pessoa TEXT NOT NULL,
    mes INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    pago BOOLEAN NOT NULL DEFAULT FALSE,
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
