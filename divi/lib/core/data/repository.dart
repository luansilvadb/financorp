import 'package:supabase_flutter/supabase_flutter.dart';
import '../../shared/models/domain.dart';

class AppRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Despesas Fixas
  Future<List<Despesa>> getDespesas() async {
    final response = await _supabase.from('despesas').select();
    return (response as List).map((m) => Despesa.fromJson(m)).toList();
  }

  Future<void> saveDespesa(Despesa despesa) async {
    await _supabase.from('despesas').upsert(despesa.toJson());
  }

  Future<void> deleteDespesa(String id) async {
    await _supabase.from('despesas').delete().eq('id', id);
  }

  // Pagamentos de Despesas Fixas
  Future<List<Pagamento>> getPagamentos(int mes, int ano) async {
    final response = await _supabase
        .from('pagamentos')
        .select()
        .eq('mes', mes)
        .eq('ano', ano);
    return (response as List).map((m) => Pagamento.fromJson(m)).toList();
  }

  Future<void> upsertPagamento(Pagamento pagamento) async {
    await _supabase.from('pagamentos').upsert(pagamento.toJson());
  }

  Future<void> upsertPagamentos(List<Pagamento> pagamentos) async {
    final list = pagamentos.map((p) => p.toJson()).toList();
    await _supabase.from('pagamentos').upsert(list);
  }

  // Compras de Cartão
  Future<List<CompraCartao>> getCompras(int mes, int ano) async {
    final response = await _supabase
        .from('compras_cartao')
        .select()
        .eq('mes', mes)
        .eq('ano', ano);
    return (response as List).map((m) => CompraCartao.fromJson(m)).toList();
  }

  Future<void> saveCompra(CompraCartao compra) async {
    await _supabase.from('compras_cartao').upsert(compra.toJson());
  }

  Future<void> saveCompras(List<CompraCartao> compras) async {
    final list = compras.map((c) => c.toJson()).toList();
    await _supabase.from('compras_cartao').upsert(list);
  }

  Future<void> deleteCompra(String id) async {
    await _supabase.from('compras_cartao').delete().eq('id', id);
  }
}
