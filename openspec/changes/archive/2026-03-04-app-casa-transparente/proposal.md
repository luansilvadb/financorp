# Proposal: App Casa Transparente

## Objective
Criar um aplicativo em Flutter focado no gerenciamento e divisão transparente de despesas fixas (água, energia, aluguel) e variáveis (mercado) de uma residência compartilhada entre 3 pessoas.

## Motivation
Atualmente, o processo de divisão de contas e repasses não funciona bem. O controle descentralizado e a rotina manual geram:
- Atraso de contas críticas por conta do descumprimento de prazos e repasses dos moradores.
- Uso de cartões de crédito pessoais como forma de adiar e mascarar débitos, causando confusão na hora da fatura.
- Atritos familiares constantes devidos a falta de clareza e transparência.
- O morador focal (Luan) não quer ter controle financeiro em processos manuais de checar as faturas e correr atrás das dívidas.

A casa precisa de uma mudança nas regras: transparência em tempo real para inibir comportamento inadimplente, isolar gastos dinâmicos do mercado sem afetar contas de crédito e garantir a saúde financeira e paz de todos. 

## Proposed Solution
Desenvolver um app simples com os seguintes módulos baseados em Flutter + Firebase ou Supabase (backend e gerência de dados centralizada sem depender de WhatsApp ou apps genéricos que falham na adoção):
1. **Painel Transparente (Dashboard)**: Exibe a pendência atual da pessoa e as contas prioritárias (Aluguel, Luz, etc). Com indicador visual (barrinha) de quem pagou a cota e quem está faltando para viabilizar.
2. **Registro de Contas Rápidas e Dinâmicas**: Para inserir luz e água, fracionando de modo automático.
3. **Módulo de Mercado**: Gastos com comida sendo abatidos de um orçamento fechado. Upload de notas fiscais pelo app na hora da compra.
4. **Acertos/Extrato do Mês**: Fechamento do quanto a pessoa "A" deve para "B".

## Scope
- Front-end em Flutter (cross-platform, será usado no Android/iOS).
- UI Clean, simples até para pessoas que não tenham proficiência digital (como Luciana e Giovanna usarão também, precisa ter atrito mínimo).
- Back-end como serviço (BaaS) - Firebase Firestore ou Supabase para tempo real e storage das fotos do mercado. Suporte básico de permissões.
- Login fixo/simples.

## In Scope
- Autenticação e gestão básica de status de três usuários.
- Cadastro e liquidação de dívidas internas.
- Upload de imagens.
- Dashboard consolidado.

## Out of Scope
- Integrações complexas com bancos PIX. (O app só marca a dívida, o PIX ocorre por fora e o app só confia no input humano de "Pagou").
- Investimentos ou orçamentos complexos. Foco 100% no gerenciamento mensal de subsistência e caixa da casa.
