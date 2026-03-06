import 'package:freezed_annotation/freezed_annotation.dart';

part 'despesa.freezed.dart';
part 'despesa.g.dart';

@freezed
class Despesa with _$Despesa {
  const factory Despesa({
    String? id,
    required String nome,
    @JsonKey(name: 'dia_vencimento') required int diaVencimento,
    required double valor,
  }) = _Despesa;

  factory Despesa.fromJson(Map<String, dynamic> json) =>
      _$DespesaFromJson(json);
}
