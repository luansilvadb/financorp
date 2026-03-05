# Proposal: Refactor Modular com Supabase & Riverpod

## Goal
Transformar o MVP de arquivo único em uma arquitetura modular, escalável e persistente, utilizando **Riverpod** para gerenciamento de estado e **Supabase** para persistência de dados em nuvem.

## Problem
Atualmente, o aplicativo `Casa Transparente` possui dois grandes gargalos:
1. **Arquitetura Frágil**: Todo o código (~1600 lines) reside em um único arquivo (`main.dart`), dificultando a manutenção e a adição de novas funcionalidades.
2. **Falta de Persistência**: Todos os dados são armazenados em memória. Ao fechar o app, as despesas e pagamentos são perdidos, o que inviabiliza o uso real por Luciana, Giovanna e Luan.

## Solution
Implementar uma arquitetura **Feature-First** (por funcionalidade) que isola as regras de negócio da UI.
- **Riverpod**: Substituirá o `setState` global por providers especializados e reativos, permitindo que as abas (Despesas, Cartão, Resumo) sincronizem dados de forma eficiente.
- **Supabase**: Atuará como o backend real, fornecendo banco de dados PostgreSQL, autenticação e sincronização em tempo real (Realtime).
- **Modularização**: Quebrar o `main.dart` em módulos: `core`, `features/despesas`, `features/cartao`, `features/resumo` e `shared`.

## Impact
- **Persistência Geográfica**: Os dados estarão seguros na nuvem do Supabase.
- **Colaboração em Tempo Real**: Mudanças feitas por um usuário serão refletidas instantaneamente nos outros dispositivos.
- **Facilidade de Evolução**: Novas funcionalidades (como upload de recibos ou login) serão adicionadas em módulos isolados sem risco de quebrar o app inteiro.
- **Complexidade Inicial**: Exige a configuração do projeto no Supabase e a migração da lógica de cálculo para o Riverpod.
