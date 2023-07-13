import '../../../Pokemon/domain/models/favoritePokemon.dart';
import '../../external/datasource/favorites_pokemons_datasource.dart';
import 'implementations.dart';

class FavoritesRepository implements IFavoritesRepository {
  final FavoritesPokemonsDataSource dataSource;

  FavoritesRepository(this.dataSource);

  @override
  Future<List<FavoritePokemonModel>> getManyFavoritesPokemons(
      page, perPage) async {
    try {
      return dataSource.getFavoritesPokemons(page, perPage);
    } catch (error) {
      rethrow;
    }
  }
}
