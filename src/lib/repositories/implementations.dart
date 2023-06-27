import '../models/pokemon.dart';

abstract class IPokemonsRepository {
  List<dynamic> getManyPokemons();
  Future<void> savePokemon(ModelPokemon data);
  Future<void> deletePokemon(int index);
  bool isPokemonFavorite(int id);
  List<ModelPokemon> getManyFavoritesPokemons();
}
