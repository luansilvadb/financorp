# Specifications: Edit Finance Records

Esta especificação define os requisitos para a edição de registros financeiros existentes (despesas fixas e compras de cartão).

## ADDED Requirements

### Requirement: Edição de Despesa Fixa
O sistema SHALL permitir que o usuário altere o nome, valor e dia de vencimento de uma despesa fixa existente.

#### Scenario: Abrir formulário de edição de despesa
- **WHEN** o usuário clica no botão "Editar" de uma despesa expandida na aba Despesas
- **THEN** o sistema exibe o bottom sheet "Editar Despesa" preenchido com os dados atuais daquela despesa

#### Scenario: Salvar alterações em despesa fixa
- **WHEN** o usuário altera o valor de uma despesa de R$ 100,00 para R$ 120,00 e clica em "Salvar"
- **THEN** o sistema atualiza o registro no banco de dados e reflete o novo valor imediatamente na lista e no resumo

### Requirement: Edição de Gasto no Cartão
O sistema SHALL permitir que o usuário altere a descrição, valor e o responsável (pessoa) de um gasto de cartão já registrado.

#### Scenario: Abrir formulário de edição de gasto de cartão
- **WHEN** o usuário clica no botão "Editar" de um gasto expandido na aba Cartão
- **THEN** o sistema exibe o bottom sheet "Editar Gasto" preenchido com os dados atuais daquela compra

#### Scenario: Alterar responsável por um gasto
- **WHEN** o usuário muda o responsável de "Luciana" para "Luan" em um gasto de cartão e salva
- **THEN** o sistema atualiza o registro e recalcula as dívidas no resumo conforme o novo responsável

### Requirement: Validação de Dados na Edição
O sistema SHALL impedir a gravação de despesas ou gastos com campos obrigatórios vazios ou valores inválidos.

#### Scenario: Tentar salvar despesa sem nome
- **WHEN** o usuário apaga o nome da despesa no formulário e tenta salvar
- **THEN** o sistema não fecha o formulário e (opcionalmente) exibe um alerta de campo obrigatório

#### Scenario: Tentar salvar com valor zero
- **WHEN** o usuário define o valor como R$ 0,00 e tenta salvar
- **THEN** o sistema impede a gravação para evitar registros inconsistentes
