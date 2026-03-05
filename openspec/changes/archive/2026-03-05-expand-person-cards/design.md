## Context

Atualmente, na aba de Despesas (página principal), os cartões com o resumo e status do usuário ("Luan", "Luciana", "Giovanna") são renderizados utilizando um `ListView.separated` horizontal, com uma largura estática definida (`width: 160`). Consequentemente, eles se alinham à esquerda e sobra espaço vazio na lateral direita da tela, não otimizando o display, especialmente em telas um pouco maiores.

## Goals / Non-Goals

**Goals:**
- Ajustar os cartões de resumo dos usuários para ocuparem horizontalmente toda a largura disponível no container do aplicativo de forma proporcional (igual) para os 3 usuários.

**Non-Goals:**
- Alterar cores, dados, lógicas de pagamento ou o conteúdo apresentado dentro dos cartões.

## Decisions

- **Substituir `ListView.separated` por `Row` + `Expanded`**
  - **Rationale:** O `Row` combinado com `Expanded` garante que o framework do Flutter automaticamente distribua o espaço total igualmente entre seus filhos (os 3 cartões). Essa é a abordagem mais natural em Flutter para resolver o problema de distribuição horizontal flexível.
  - **Alternativa Considerada:** Usar o Widget `Wrap` flexível, porém não seria adequado porque não garantiria pesos iguais preenchendo 100% da tela numa mesma linha se o espaço ficasse reduzido. O `Row` previne quebra de linha.

## Risks / Trade-offs

- **[Risco] Ocorrência de Overflow em Tela Muito Pequenas** -> *Mitigação*: Os textos internos têm flexibilidade e o Flutter fará quebra de linha ou o container deverá ser ajustado no padding interno, caso a tela seja minúscula (ex: <= 320px width). No entanto, sendo apenas três cartões, a largura de um dispositivo comum comporta bem.

## Migration Plan

- Substituir o trecho correspondente no método `_buildDespesasTab()` no `main.dart`. Não há persistência de dados afetada.

## Open Questions

- Os textos podem quebrar em telas antigas estreitas (ex: iPhone SE), mas para a resolução atual da família é adequado.
