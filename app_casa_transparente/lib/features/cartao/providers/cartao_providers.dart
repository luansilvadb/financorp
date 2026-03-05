import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/cartao_repository.dart';
import '../../../shared/models/compra_cartao.dart';
import '../../../shared/providers/month_year_provider.dart';

final cartaoRepositoryProvider = Provider((ref) => CartaoRepository());

final cartaoProvider =
    AsyncNotifierProvider<CartaoNotifier, List<CompraCartao>>(() {
  return CartaoNotifier();
});

class CartaoNotifier extends AsyncNotifier<List<CompraCartao>> {
  @override
  Future<List<CompraCartao>> build() async {
    final period = ref.watch(periodProvider);
    return ref
        .read(cartaoRepositoryProvider)
        .getCompras(period.mes, period.ano);
  }

  Future<void> addCompra(CompraCartao c) async {
    await ref.read(cartaoRepositoryProvider).saveCompra(c);
    ref.invalidateSelf();
  }

  Future<void> deleteCompra(String id) async {
    await ref.read(cartaoRepositoryProvider).deleteCompra(id);
    ref.invalidateSelf();
  }

  Future<void> togglePagamento(CompraCartao c) async {
    final updated = c.copyWith(pago: !c.pago);
    await ref.read(cartaoRepositoryProvider).saveCompra(updated);
    ref.invalidateSelf();
  }
}
