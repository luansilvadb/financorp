// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain.dart';

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

Map<String, dynamic> _$$DespesaImplToJson(_$DespesaImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['nome'] = instance.nome;
  val['dia_vencimento'] = instance.diaVencimento;
  val['valor'] = instance.valor;
  return val;
}

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

Map<String, dynamic> _$$CompraCartaoImplToJson(_$CompraCartaoImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['data'] = instance.data;
  val['descricao'] = instance.descricao;
  val['valor'] = instance.valor;
  val['pessoa'] = instance.pessoa;
  val['mes'] = instance.mes;
  val['ano'] = instance.ano;
  val['pago'] = instance.pago;
  return val;
}

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
