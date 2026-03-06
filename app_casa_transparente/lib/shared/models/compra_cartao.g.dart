// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compra_cartao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompraCartaoImpl _$$CompraCartaoImplFromJson(Map<String, dynamic> json) =>
    _$CompraCartaoImpl(
      id: json['id'] as String?,
      data: json['data'] as String,
      descricao: json['descricao'] as String,
      valor: (json['valor'] as num).toDouble(),
      pessoa: json['pessoa'] as String,
      mes: (json['mes'] as num).toInt(),
      ano: (json['ano'] as num).toInt(),
      pago: json['pago'] as bool? ?? false,
    );

Map<String, dynamic> _$$CompraCartaoImplToJson(_$CompraCartaoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'descricao': instance.descricao,
      'valor': instance.valor,
      'pessoa': instance.pessoa,
      'mes': instance.mes,
      'ano': instance.ano,
      'pago': instance.pago,
    };
