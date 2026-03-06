import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagamento.freezed.dart';
part 'pagamento.g.dart';

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
