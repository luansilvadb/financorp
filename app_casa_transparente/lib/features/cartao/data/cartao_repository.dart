import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../shared/models/compra_cartao.dart';

class CartaoRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<CompraCartao>> getCompras(int mes, int ano) async {
    final response = await _supabase
        .from('compras_cartao')
        .select()
        .eq('mes', mes)
        .eq('ano', ano);
    return (response as List).map((m) => CompraCartao.fromMap(m)).toList();
  }

  Future<void> saveCompra(CompraCartao compra) async {
    await _supabase.from('compras_cartao').upsert(compra.toMap());
  }

  Future<void> deleteCompra(String id) async {
    await _supabase.from('compras_cartao').delete().eq('id', id);
  }
}
