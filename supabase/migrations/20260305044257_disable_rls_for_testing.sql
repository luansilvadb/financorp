-- Migration: Liberar acesso para o App (RLS Policies)

-- Desabilitar RLS ou adicionar políticas permissivas para a role 'anon'
-- Como o app usa a chave anon e é para uso interno, vamos permitir tudo por enquanto.

-- Tabela: despesas
ALTER TABLE despesas ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all for anonymous on despesas" ON despesas FOR ALL TO anon USING (true) WITH CHECK (true);

-- Tabela: compras_cartao
ALTER TABLE compras_cartao ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all for anonymous on compras_cartao" ON compras_cartao FOR ALL TO anon USING (true) WITH CHECK (true);

-- Tabela: pagamentos
ALTER TABLE pagamentos ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all for anonymous on pagamentos" ON pagamentos FOR ALL TO anon USING (true) WITH CHECK (true);
