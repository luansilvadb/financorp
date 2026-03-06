import 'package:freezed_annotation/freezed_annotation.dart';

part 'compra_cartao.freezed.dart';
part 'compra_cartao.g.dart';

@freezed
class CompraCartao with _$CompraCartao {
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
