import '../../../../core/services/infra/hive/adpter.dart';
import '../../domain/models/favoritePokemon.dart';
import '../../domain/models/fetchPokemons.dart';
import '../../domain/models/pokemon.dart';

abstract class IPokemonRepository {
  Future<FetchPokemon> getPokemons(Uri? uri);
  Future<PokemonModel> getPokemon(Uri uri);
  Future<FavoritePokemonModel> favoritePokemon(ModelPokemon pokemon);
  bool pokemonIsFavorite(int id);
  bool unFavoritePokemon(int id);
}
