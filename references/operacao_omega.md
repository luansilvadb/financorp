## 1. Análise de Contexto (Boot Inteligente)

Em cada inicialização, a Mente Brilhante Ω deve classificar o estado do projeto:

### 🟢 Cenário A: Greenfield (Projeto Novo)
*   **Identificação**: Diretório `.agile/` ausente ou vazio.
*   **Ação**: Iniciar **Elicitação Avançada de Brainstorm**.
    *   O agente deve propor uma visão inicial baseada nos requisitos mínimos.
    *   Realizar perguntas de múltipla escolha ou cenários comparativos para reduzir a carga mental do Tech Lead.
    *   Gerar o `ROADMAP.md` v1.0.0 e a primeira `CURRENT_SPRINT.md`.

### 🟤 Cenário B: Brownfield (Projeto Existente)
*   **Identificação**: Diretório `.agile/` populado.
*   **Ação**: Auditoria de Roadmap.
    *   Se `ROADMAP.md` tiver tarefas pendentes: Prosseguir com o Ciclo de Execução normal.
    *   **Se `ROADMAP.md` estiver 100% concluído**: Gatilho de **Recursividade de Brainstorm**.
        - Iniciar Elicitação Avançada para planejar a "Nova Era" do produto.
        - Realizar o Bump de versão MAJOR.

## 2. Elicitação Avançada (Redução de Carga Mental)

O papel do agente é **propor e validar**, não apenas perguntar.
1.  **Sondagem Ativa**: Analisar o código atual (se houver) para deduzir tecnologias e padrões.
2.  **Síntese de Opções**: Apresentar 3 caminhos arquiteturais possíveis com Prós/Contras.
3.  **Definição Autônoma**: O Tech Lead apenas aprova ou ajusta a rota proposta.

## 3. O Loop de Execução Rekursiva (Loop Ω)

Em cada interação, siga rigorosamente as travas de qualidade:

### Fase A: Sincronização e Auditoria
- Validar se as tarefas concluídas em `CURRENT_SPRINT.md` satisfazem o **Definition of Done (DoD)** detalhado em `runtime/DOR_DOD.md`.
- Se o DoD falhar, o item não pode ser marcado como `[x]`.

### Fase B: Preparação da Próxima Sprint
- Antes de mover qualquer História de Usuário (US) do Backlog para a Sprint:
    - Verifique se ela atende ao **Definition of Ready (DoR)**.
    - Se a US não tiver critérios de aceite BDD ou valor claro, ela deve permanecer no Backlog para refinamento.

### Fase C: Arquivamento e Release
- Ao concluir uma Sprint:
    - Gerar as **Release Notes** em `history/RELEASES/`.
    - Realizar o arquivamento via `archive_manager.py`.
    - Incrementar a versão em `assets/VERSION.md` seguindo SemVer.

## 4. Gestão de Bloqueios e ADRs (Architectural Decision Records)

A Mente Brilhante Ω não "trava" diante de incertezas arquiteturais.
1.  **Identificação**: Ao encontrar um impedimento técnico ou decisão de design complexa, o agente deve pausar a execução tática.
2.  **Documentação**: Criar um arquivo em `.agile/planning/ADR_[ID]_[TITULO].md` utilizando o `assets/ADR_TEMPLATE.md`.
3.  **Resolução**: Propor a solução mais alinhada com os princípios do projeto e aguardar o selo de [APROVADO] do Tech Lead.

## 5. Recursividade de Brainstorm (A Nova Era)

Quando o progresso do `ROADMAP.md` atinge **100%**, o ciclo operacional Ω entra em modo "Estratégico High-Level":
- **Auditoria de Valor**: O agente faz uma retrospectiva dos épicos entregues.
- **Elicitação de Expansão**: O agente analisa tendências do mercado ou lacunas no código e propõe o Roadmap para a próxima **Era** (ex: Era de Escala, Era de Integração Planetária, etc.).
- **Reset Tático**: A `CURRENT_SPRINT.md` é limpa e o ciclo recomeça com o bump de versão MAJOR.
