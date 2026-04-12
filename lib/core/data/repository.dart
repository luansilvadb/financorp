import 'package:supabase_flutter/supabase_flutter.dart';
import '../../shared/models/domain.dart';

/// Repository for all Supabase CRUD operations.
///
/// Thin wrapper around SupabaseClient — no business logic, just data access.
/// Injectable for testability (accepts optional SupabaseClient in constructor).
class AppRepository {
  final SupabaseClient _client;

  AppRepository({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  // ==================== DESPESAS ====================

  /// Fetches all fixed expenses, ordered by name ascending.
  Future<List<Despesa>> fetchDespesas() async {
    final response = await _client
        .from('despesas')
        .select()
        .order('nome', ascending: true);

    return response.map((json) => Despesa.fromJson(json)).toList();
  }

  /// Creates a new fixed expense and returns the created record with generated ID.
  Future<Despesa> createDespesa(Despesa despesa) async {
    final payload = despesa.toJson()..remove('id'); // id is auto-generated
    final response = await _client
        .from('despesas')
        .insert(payload)
        .select()
        .single();

    return Despesa.fromJson(response);
  }

  /// Updates an existing fixed expense. Only non-null fields are sent.
  Future<void> updateDespesa(Despesa despesa) async {
    final payload = despesa.toJson()..removeWhere((k, v) => v == null);
    await _client.from('despesas').update(payload).eq('id', despesa.id!);
  }

  /// Deletes a fixed expense by ID.
  Future<void> deleteDespesa(String id) async {
    await _client.from('despesas').delete().eq('id', id);
  }

  // ==================== COMPRAS CARTAO ====================

  /// Fetches credit card purchases for a specific month/year, ordered by date descending.
  Future<List<CompraCartao>> fetchCompras(int mes, int ano) async {
    final response = await _client
        .from('compras_cartao')
        .select()
        .eq('mes', mes)
        .eq('ano', ano)
        .order('data', ascending: false);

    return response.map((json) => CompraCartao.fromJson(json)).toList();
  }

  /// Creates a new credit card purchase and returns the created record with generated ID.
  Future<CompraCartao> createCompra(CompraCartao compra) async {
    final payload = compra.toJson()..remove('id'); // id is auto-generated
    final response = await _client
        .from('compras_cartao')
        .insert(payload)
        .select()
        .single();

    return CompraCartao.fromJson(response);
  }

  /// Updates an existing credit card purchase. Only non-null fields are sent.
  Future<void> updateCompra(CompraCartao compra) async {
    final payload = compra.toJson()..removeWhere((k, v) => v == null);
    await _client.from('compras_cartao').update(payload).eq('id', compra.id!);
  }

  /// Deletes a credit card purchase by ID.
  Future<void> deleteCompra(String id) async {
    await _client.from('compras_cartao').delete().eq('id', id);
  }

  // ==================== PAGAMENTOS ====================

  /// Fetches payment tracking records for a specific month/year.
  Future<List<Pagamento>> fetchPagamentos(int mes, int ano) async {
    final response = await _client
        .from('pagamentos')
        .select()
        .eq('mes', mes)
        .eq('ano', ano);

    return response.map((json) => Pagamento.fromJson(json)).toList();
  }

  /// Inserts or updates a payment record.
  ///
  /// Defensive strategy: Uses onConflict for performance, but assumes the 
  /// calling code might be sending a partial object.
  Future<void> upsertPagamento(Pagamento pagamento) async {
    final payload = pagamento.toJson();
    
    // Defensive check: if ID is null, we should double check if a record with these 
    // unique fields already exists to prevent duplicate insertion if constraint is missing.
    if (pagamento.id.isEmpty) {
      final existing = await _client
          .from('pagamentos')
          .select('id')
          .eq('despesa_id', pagamento.despesaId)
          .eq('pessoa', pagamento.pessoa)
          .eq('mes', pagamento.mes)
          .eq('ano', pagamento.ano)
          .maybeSingle();
      
      if (existing != null) {
        payload['id'] = existing['id'];
      }
    }

    await _client
        .from('pagamentos')
        .upsert(payload);
  }

  /// Deletes a payment tracking record by ID.
  Future<void> deletePagamento(String id) async {
    await _client.from('pagamentos').delete().eq('id', id);
  }

  // ==================== ALIASES (for backward compat with existing providers) ====================

  /// Alias for fetchDespesas (used by existing providers).
  Future<List<Despesa>> getDespesas() => fetchDespesas();

  /// Alias for createDespesa or updateDespesa (used by existing providers).
  Future<void> saveDespesa(Despesa despesa) async {
    if (despesa.id == null || despesa.id!.isEmpty) {
      await createDespesa(despesa);
    } else {
      await updateDespesa(despesa);
    }
  }

  /// Alias for fetchCompras (used by existing providers).
  Future<List<CompraCartao>> getCompras(int mes, int ano) =>
      fetchCompras(mes, ano);

  /// Alias for createCompra or updateCompra (used by existing providers).
  Future<void> saveCompra(CompraCartao compra) async {
    if (compra.id == null || compra.id!.isEmpty) {
      await createCompra(compra);
    } else {
      await updateCompra(compra);
    }
  }

  /// Batch save multiple compras using a single Supabase call.
  Future<void> saveCompras(List<CompraCartao> compras) async {
    if (compras.isEmpty) return;
    final payloads = compras.map((c) => c.toJson()).toList();
    await _client.from('compras_cartao').upsert(payloads);
  }

  /// Alias for fetchPagamentos (used by existing providers).
  Future<List<Pagamento>> getPagamentos(int mes, int ano) =>
      fetchPagamentos(mes, ano);

  /// Batch upsert multiple pagamentos using a single Supabase call.
  ///
  /// Note: Now uses batching for efficiency (1 round-trip).
  Future<void> upsertPagamentos(List<Pagamento> pagamentos) async {
    if (pagamentos.isEmpty) return;
    final payloads = pagamentos.map((p) => p.toJson()).toList();
    await _client
        .from('pagamentos')
        .upsert(payloads);
  }
}
