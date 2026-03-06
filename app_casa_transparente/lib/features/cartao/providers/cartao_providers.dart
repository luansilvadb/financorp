import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/cartao_repository.dart';
import '../../../shared/models/compra_cartao.dart';
import '../../../core/engine/finance_engine.dart';
import '../../../shared/providers/month_year_provider.dart';

final cartaoRepositoryProvider = Provider((ref) => CartaoRepository());

final cartaoProvider =
    AsyncNotifierProvider<CartaoNotifier, List<CompraCartao>>(() {
  return CartaoNotifier();
});

class CartaoNotifier extends AsyncNotifier<List<CompraCartao>> {
  @override
  Future<List<CompraCartao>> build() async {
    ref.keepAlive();
    final period = ref.watch(periodProvider);
    return ref
        .read(cartaoRepositoryProvider)
        .getCompras(period.mes, period.ano);
  }

  Future<void> addCompra(CompraCartao c) async {
    final previousState = state;
    state = state.whenData((list) => [...list, c]);
    try {
      await ref.read(cartaoRepositoryProvider).saveCompra(c);
      // Re-fetch to get the server-generated UUID
      ref.invalidateSelf();
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> updateCompra(CompraCartao c) async {
    final previousState = state;
    state = state.whenData(
        (list) => list.map((item) => item.id == c.id ? c : item).toList());
    try {
      await ref.read(cartaoRepositoryProvider).saveCompra(c);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> deleteCompra(String id) async {
    final previousState = state;
    state =
        state.whenData((list) => list.where((item) => item.id != id).toList());
    try {
      await ref.read(cartaoRepositoryProvider).deleteCompra(id);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> togglePagamento(CompraCartao c) async {
    final updated = c.copyWith(pago: !c.pago);
    final previousState = state;
    state = state.whenData((list) =>
        list.map((item) => item.id == c.id ? updated : item).toList());
    try {
      await ref.read(cartaoRepositoryProvider).saveCompra(updated);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}

/// Provider granular que utiliza o motor central (O(1) access).
final compraItemProvider = Provider.family<CompraItemRecord?, String>((ref, id) {
  final compra = ref.watch(financeEngineProvider.select((s) => s.compras[id]));
  if (compra == null) return null;

  return (
    compra: compra,
    isLuan: compra.pessoa == 'Luan',
  );
});
