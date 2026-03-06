// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'despesa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DespesaImpl _$$DespesaImplFromJson(Map<String, dynamic> json) =>
    _$DespesaImpl(
      id: json['id'] as String?,
      nome: json['nome'] as String,
      diaVencimento: (json['dia_vencimento'] as num).toInt(),
      valor: (json['valor'] as num).toDouble(),
    );

Map<String, dynamic> _$$DespesaImplToJson(_$DespesaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'dia_vencimento': instance.diaVencimento,
      'valor': instance.valor,
    };
