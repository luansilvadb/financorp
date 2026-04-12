// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Despesa _$DespesaFromJson(Map<String, dynamic> json) => _Despesa(
  id: json['id'] as String?,
  nome: json['nome'] as String,
  diaVencimento: (json['dia_vencimento'] as num).toInt(),
  valor: (json['valor'] as num).toDouble(),
);

Map<String, dynamic> _$DespesaToJson(_Despesa instance) => <String, dynamic>{
  'id': ?instance.id,
  'nome': instance.nome,
  'dia_vencimento': instance.diaVencimento,
  'valor': instance.valor,
};

_CompraCartao _$CompraCartaoFromJson(Map<String, dynamic> json) =>
    _CompraCartao(
      id: json['id'] as String?,
      data: json['data'] as String,
      descricao: json['descricao'] as String,
      valor: (json['valor'] as num).toDouble(),
      pessoa: json['pessoa'] as String,
      mes: (json['mes'] as num).toInt(),
      ano: (json['ano'] as num).toInt(),
      pago: json['pago'] as bool? ?? false,
    );

Map<String, dynamic> _$CompraCartaoToJson(_CompraCartao instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'data': instance.data,
      'descricao': instance.descricao,
      'valor': instance.valor,
      'pessoa': instance.pessoa,
      'mes': instance.mes,
      'ano': instance.ano,
      'pago': instance.pago,
    };

_Pagamento _$PagamentoFromJson(Map<String, dynamic> json) => _Pagamento(
  id: json['id'] as String,
  despesaId: json['despesa_id'] as String,
  pessoa: json['pessoa'] as String,
  mes: (json['mes'] as num).toInt(),
  ano: (json['ano'] as num).toInt(),
  pago: json['pago'] as bool,
);

Map<String, dynamic> _$PagamentoToJson(_Pagamento instance) =>
    <String, dynamic>{
      'id': instance.id,
      'despesa_id': instance.despesaId,
      'pessoa': instance.pessoa,
      'mes': instance.mes,
      'ano': instance.ano,
      'pago': instance.pago,
    };
