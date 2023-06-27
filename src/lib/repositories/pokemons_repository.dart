import 'package:hive_flutter/hive_flutter.dart';

import '../models/pokemon.dart';
import 'implementations.dart';

class PokemonsRepository extends IPokemonsRepository {
  late Box<dynamic> pokeDex;

  PokemonsRepository(Box<dynamic> box) {
    pokeDex = box;
  }

  @override
  Future<void> deletePokemon(int id) async {
    final pokemon = pokeDex.values.where((element) => element.id == id).first;

    try {
      await pokeDex.delete(pokemon.key);
    } catch (e) {
      throw Error();
    }
  }

  @override
  List<dynamic> getManyPokemons() {
    try {
      final result = pokeDex.values.toList();
      return result;
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<void> savePokemon(ModelPokemon pokemon) async {
    await pokeDex.add(pokemon);
  }

  @override
  bool isPokemonFavorite(int id) {
    final isSelected =
        pokeDex.values.where((element) => element.id == id).toList();

    if (isSelected.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  List<ModelPokemon> getManyFavoritesPokemons() {
    final favoritesPokemons = pokeDex.values.toList() as List<ModelPokemon>;

    return favoritesPokemons;
  }
}
