## Context

Atualmente, o aplicativo permite que cada despesa da casa seja atrelada a um morador específico através do campo `responsavel`. Na prática, isso cria confusão e múltiplos fluxos de pagamento (múltiplas transferências via PIX entre todos os moradores). O mundo real da casa caminha para um modelo onde o Luan atua como tesoureiro, pagando todas as contas e centralizando os recebimentos da Giovanna e Luciana.

## Goals / Non-Goals

**Goals:**
- Simplificar o modelo de dados `Despesa` removendo a obrigatoriedade de ter um responsável individual.
- Consolidar a dívida de cada morador em um único montante a ser transferido (PIX) diretamente para o Luan.
- Centralizar o UI/UX da aba Resumo para exibir claramente o valor total que cada membro deve enviar ao tesoureiro.

**Non-Goals:**
- Implementação de integração bancária ou leitura de extratos/PIX. O aplicativo continuará funcionando à base de confiança (toggles manuais).
- Refatoração do aplicativo para suportar múltiplos lares ou customização da divisão (continuará sendo sempre igualitária em 3 partes).

## Decisions

**Decisão 1: Remoção do campo `responsavel`**
- **O que muda:** O modelo `Despesa` na `main.dart` perderá o campo `responsavel`.
- **Por que:** Como o Luan será o pagador oficial de todas as contas, esse dado passa a ser inútil no aplicativo, se tornando apenas um ruído visual. O preenchimento simplifica.

**Decisão 2: Atualização da Lógica de `pendente`**
- **O que muda:** 
  - Para a Luciana e Giovanna: o cálculo de pendências totais do mês consolida automaticamente a parte não paga das despesas conjuntas somada aos gastos delas no cartão do Luan. As dívidas fluem unidirecionalmente para o Luan.
  - Para o Luan: não há exibições de "dívida", e sim de recebimentos.

**Decisão 3: Manutenção do Tracking por Despesa**
- **O que muda:** Ainda será possível "dar check" individualmente em uma despesa.
- **Por que:** Assim, a Luciana e Giovanna têm flexibilidade de ir depositando aos poucos (e justificando: "paguei a minha parte da Energia"). A interface manterá a matriz `[chave]-[id]-[pessoa] = boolean` de pagamentos, significando unicamente que o morador pagou "a sua fatia" daquela despesa ao tesoureiro.

## Risks / Trade-offs

- **[Risco] Omissão de titularidade original dos boletos:** Se alguém precisar ligar para a companha de energia, o app não diz mais no nome de quem a conta está. 
  - **Mitigação:** Sendo uma casa onde as contas são contínuas, essa informação rapidamente vira conhecimento óbvio dos moradores e raramente muda, portanto não afeta as operações do dia a dia no app.
- **[Risco] Complexidade ao lidar com saldos e créditos do próprio tesoureiro:** O Luan não deve nada a ninguém. 
  - **Mitigação:** Tratamento especial de UI nos layouts dos Person Cards quando o usuário renderizado é "Luan", para mostrar o termo "O seu saldo não é transferível a terceiros" ou omitir a tag de dívida para ele e substituí-la por "Total a Receber".
