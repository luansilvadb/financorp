# Project Brief: App Casa Transparente

## Overview
A Flutter mobile application for transparent financial management and expense splitting in a shared household of 3 people (Luan, Luciana, Giovanna).

## Core Requirements
1. **Fixed Expense Management** — Track shared household bills (Aluguel, Energia, Água, Internet) with automatic 3-way splitting and per-person payment status tracking.
2. **Credit Card Tracking (Cartão)** — Log purchases made on Luan's credit card by Luciana/Giovanna, tracking who owes what to Luan and their current payment status.
3. **Monthly Summary (Resumo)** — Dashboard showing each person's total obligations, what's paid, what's pending, and credit card debts.
4. **Data Persistence** — Cloud storage via Supabase to ensure data is shared across devices and survives app restarts.

## Goals
- Eliminate manual tracking and WhatsApp-based coordination that causes missed payments and family friction.
- Provide real-time transparency so everyone sees their obligations clearly.
- Keep the UI simple and accessible for non-tech-savvy users (Luciana and Giovanna).
- Inhibit late/missing payments through visibility and accountability.

## Tech Stack (v2.0)
- **Framework**: Flutter (Dart SDK ^3.11.0)
- **Backend**: Supabase (PostgreSQL + Auth + Storage)
- **State Management**: Riverpod (^3.2.1)
- **Env Management**: flutter_dotenv (^5.1.0)
- **Methodology**: Feature-First Modular Architecture
- **Change Management**: OpenSpec workflow

## Users
| User      | Role                                            |
|-----------|-------------------------------------------------|
| Luan      | Primary admin, credit card holder, main payer   |
| Luciana   | Household member, uses Luan's card for purchases|
| Giovanna  | Household member, uses Luan's card for purchases|

## Out of Scope
- Bank/PIX integrations (payments happen externally; app tracks trust-based status).
- Complex budgeting or investment tracking.
- Universal user onboarding (fixed to 3 specific members).
