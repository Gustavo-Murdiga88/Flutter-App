import '../../../Pokemon/domain/models/favoritePokemon.dart';

abstract class IFavoritesRepository {
  Future<List<FavoritePokemonModel>> getManyFavoritesPokemons(
      int page, int perPage);
}
