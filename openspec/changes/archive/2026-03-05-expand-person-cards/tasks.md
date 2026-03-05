## 1. Ajuste de Layout na Aba Principal

- [x] 1.1 Localizar o método `_buildDespesasTab()` no arquivo `lib/main.dart`
- [x] 1.2 Substituir o `ListView.separated` horizontal, que renderiza os cartões de usuário, por um Widget `Row`
- [x] 1.3 Envolver cada cartão de usuário gerado num Widget `Expanded` para distribuir a largura igualmente entre os 3 cartões
- [x] 1.4 Remover a propriedade de largura fixa (`width: 160`) do `Container` de cada cartão e ajustar espaçamentos (`SizedBox` ou margens) adequadamente entre os `Expanded`
- [x] 1.5 Validar visualmente executando o aplicativo (`flutter run`) para assegurar que não haja overlfow ou quebras incorretas do texto nos cartões expandidos
