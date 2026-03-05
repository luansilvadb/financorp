import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../shared/models/despesa.dart';
import '../../../shared/models/pagamento.dart';

class FinanceRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Despesa>> getDespesas() async {
    final response = await _supabase.from('despesas').select();
    return (response as List).map((m) => Despesa.fromMap(m)).toList();
  }

  Future<List<Pagamento>> getPagamentos(int mes, int ano) async {
    final response = await _supabase
        .from('pagamentos')
        .select()
        .eq('mes', mes)
        .eq('ano', ano);
    return (response as List).map((m) => Pagamento.fromMap(m)).toList();
  }

  Future<void> upsertPagamento(Pagamento pagamento) async {
    await _supabase.from('pagamentos').upsert(pagamento.toMap());
  }

  Future<void> saveDespesa(Despesa despesa) async {
    await _supabase.from('despesas').upsert(despesa.toMap());
  }

  Future<void> deleteDespesa(String id) async {
    await _supabase.from('despesas').delete().eq('id', id);
  }
}
