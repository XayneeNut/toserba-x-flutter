import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toserba/models/barang_models.dart';

class FavoritesBarangProviders extends StateNotifier<List<BarangModels>> {
  FavoritesBarangProviders() : super([]);

  bool toogleBarangFavorites(BarangModels barangModels) {
    final barangIsFavorite = state.contains(barangModels);

    if (barangIsFavorite) {
      state = state
          .where((barang) => barang.idBarang != barangModels.idBarang)
          .toList();
      return false;
    } else {
      state = [...state, barangModels];
      return true;
    }
  }
}

final favoritesBarangProviders =
    StateNotifierProvider<FavoritesBarangProviders, List<BarangModels>>(
  (ref) {
    return FavoritesBarangProviders();
  },
);
