## Context

Atualmente, a representação visual dos moradores no aplicativo é inconsistente. Alguns componentes usam `CircleAvatar` com `NetworkImage` (utilizando URLs estáticas no `constants.dart`), enquanto outros usam `Container` customizado com o primeiro caractere do nome. Essa duplicação de lógica dificulta a manutenção e a aplicação de um estilo visual coeso (branding).

## Goals / Non-Goals

**Goals:**
- Criar um componente único `DiviAvatar` em `lib/shared/widgets/divi_avatar.dart`.
- Centralizar a lógica de cores e iniciais.
- Substituir todas as ocorrências de avatares manuais pelo novo componente.
- Eliminar o uso de URLs de imagens externas para avatares de moradores.

**Non-Goals:**
- Implementar upload de fotos de perfil.
- Mudar a lógica de cores existente no `constants.dart`.
- Alterar o layout geral dos cards, apenas o componente de avatar interno.

## Decisions

### 1. Criação do Widget `DiviAvatar`
- **Decisão**: Implementar um `StatelessWidget` que recebe `pessoa` (String) e opcionalmente `size` (double).
- **Racional**: Garante que o avatar sempre use a primeira letra e a cor correta definida em `coresPessoa`. O uso de `StatelessWidget` é ideal pois o avatar não possui estado interno complexo.
- **Alternativa**: Continuar usando `CircleAvatar` diretamente. **Rejeitado** pois o `CircleAvatar` do Flutter tem limitações de customização que o design skeuomórfico do Divi exige (bordas específicas, opacidades de fundo).

### 2. Estilo Visual: Skeuomorphic-ish
- **Decisão**: O avatar terá um fundo circular com 10% de opacidade da cor do morador e o texto (inicial) com a cor sólida.
- **Racional**: Mantém a estética "warm paper" do app, onde elementos coloridos geralmente têm uma base suave.

### 3. Remoção de `avataresPessoa`
- **Decisão**: Marcar como obsoleto ou remover a constante `avataresPessoa` no `constants.dart`.
- **Racional**: Limpeza de código e remoção de dependência de URLs que não serão mais utilizadas.

## Risks / Trade-offs

- **[Risco]** Diferentes tamanhos de avatar em diferentes telas podem quebrar o alinhamento visual se o `radius` não for bem tratado. → **Mitigação**: O `DiviAvatar` aceitará um parâmetro `size` e calculará proporcionalmente o tamanho da fonte.
- **[Risco]** Nomes compostos ou caracteres especiais na inicial. → **Mitigação**: Usar `pessoa[0].toUpperCase()` para garantir consistência.
