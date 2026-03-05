class Pagamento {
  final String id;
  final String despesaId;
  final String pessoa;
  final int mes;
  final int ano;
  final bool pago;

  Pagamento({
    required this.id,
    required this.despesaId,
    required this.pessoa,
    required this.mes,
    required this.ano,
    required this.pago,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'despesa_id': despesaId,
      'pessoa': pessoa,
      'mes': mes,
      'ano': ano,
      'pago': pago,
    };
  }

  factory Pagamento.fromMap(Map<String, dynamic> map) {
    return Pagamento(
      id: map['id'] ?? '',
      despesaId: map['despesa_id'] ?? '',
      pessoa: map['pessoa'] ?? '',
      mes: (map['mes'] as num?)?.toInt() ?? 0,
      ano: (map['ano'] as num?)?.toInt() ?? 0,
      pago: map['pago'] ?? false,
    );
  }
}
