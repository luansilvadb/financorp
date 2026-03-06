// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagamento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PagamentoImpl _$$PagamentoImplFromJson(Map<String, dynamic> json) =>
    _$PagamentoImpl(
      id: json['id'] as String,
      despesaId: json['despesa_id'] as String,
      pessoa: json['pessoa'] as String,
      mes: (json['mes'] as num).toInt(),
      ano: (json['ano'] as num).toInt(),
      pago: json['pago'] as bool,
    );

Map<String, dynamic> _$$PagamentoImplToJson(_$PagamentoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'despesa_id': instance.despesaId,
      'pessoa': instance.pessoa,
      'mes': instance.mes,
      'ano': instance.ano,
      'pago': instance.pago,
    };
