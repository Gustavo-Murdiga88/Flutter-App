// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/errors/failure.dart';
import '../../../Pokemon/domain/models/favoritePokemon.dart';
import '../../external/datasource/favorites_pokemons_datasource.dart';
import 'implementations.dart';

class FavoritesRepository implements IFavoritesRepository {
  final FavoritesPokemonsDataSource dataSource;

  FavoritesRepository(this.dataSource);

  @override
  Future<List<FavoritePokemonModel>> getManyFavoritesPokemons() async {
    try {
      return dataSource.getFavoritesPokemons();
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }
}
