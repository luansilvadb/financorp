import 'package:freezed_annotation/freezed_annotation.dart';

part 'domain.freezed.dart';
part 'domain.g.dart';

@freezed
class Despesa with _$Despesa {
  @JsonSerializable(includeIfNull: false)
  const factory Despesa({
    String? id,
    required String nome,
    @JsonKey(name: 'dia_vencimento') required int diaVencimento,
    required double valor,
  }) = _Despesa;

  factory Despesa.fromJson(Map<String, dynamic> json) =>
      _$DespesaFromJson(json);
}

@freezed
class CompraCartao with _$CompraCartao {
  @JsonSerializable(includeIfNull: false)
  const factory CompraCartao({
    String? id,
    required String data,
    required String descricao,
    required double valor,
    required String pessoa,
    required int mes,
    required int ano,
    @Default(false) bool pago,
  }) = _CompraCartao;

  factory CompraCartao.fromJson(Map<String, dynamic> json) =>
      _$CompraCartaoFromJson(json);
}

@freezed
class Pagamento with _$Pagamento {
  const factory Pagamento({
    required String id,
    @JsonKey(name: 'despesa_id') required String despesaId,
    required String pessoa,
    required int mes,
    required int ano,
    required bool pago,
  }) = _Pagamento;

  factory Pagamento.fromJson(Map<String, dynamic> json) =>
      _$PagamentoFromJson(json);
}
