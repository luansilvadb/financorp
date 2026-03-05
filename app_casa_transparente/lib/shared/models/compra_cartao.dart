class CompraCartao {
  final String? id; // Opcional para deixarmos o Supabase gerar
  final String data;
  final String descricao;
  final double valor;
  final String pessoa;
  final int mes;
  final int ano;
  final bool pago;

  CompraCartao({
    this.id,
    required this.data,
    required this.descricao,
    required this.valor,
    required this.pessoa,
    required this.mes,
    required this.ano,
    this.pago = false,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'data': data,
      'descricao': descricao,
      'valor': valor,
      'pessoa': pessoa,
      'mes': mes,
      'ano': ano,
      'pago': pago,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory CompraCartao.fromMap(Map<String, dynamic> map) {
    return CompraCartao(
      id: map['id']?.toString(),
      data: map['data'] ?? '',
      descricao: map['descricao'] ?? '',
      valor: (map['valor'] as num?)?.toDouble() ?? 0.0,
      pessoa: map['pessoa'] ?? '',
      mes: (map['mes'] as num?)?.toInt() ?? 0,
      ano: (map['ano'] as num?)?.toInt() ?? 0,
      pago: map['pago'] ?? false,
    );
  }

  CompraCartao copyWith({
    String? id,
    String? data,
    String? descricao,
    double? valor,
    String? pessoa,
    int? mes,
    int? ano,
    bool? pago,
  }) {
    return CompraCartao(
      id: id ?? this.id,
      data: data ?? this.data,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      pessoa: pessoa ?? this.pessoa,
      mes: mes ?? this.mes,
      ano: ano ?? this.ano,
      pago: pago ?? this.pago,
    );
  }
}
