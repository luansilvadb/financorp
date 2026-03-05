class Despesa {
  final String? id; // Opcional para deixarmos o Supabase gerar
  final String nome;
  final int diaVencimento;
  final double valor;

  Despesa({
    this.id,
    required this.nome,
    required this.diaVencimento,
    required this.valor,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'nome': nome,
      'dia_vencimento': diaVencimento,
      'valor': valor,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Despesa.fromMap(Map<String, dynamic> map) {
    return Despesa(
      id: map['id']?.toString(),
      nome: map['nome'] ?? '',
      diaVencimento: (map['dia_vencimento'] as num?)?.toInt() ?? 0,
      valor: (map['valor'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
