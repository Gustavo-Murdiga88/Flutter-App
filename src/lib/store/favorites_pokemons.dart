import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/pokemon.dart';
import '../repositories/pokemons_repository.dart';
import '../uses_cases/get_many_favorites_pokemons.dart';

class FavoritesPokemons extends ChangeNotifier {
  var pokeDex = Hive.box<ModelPokemon>("poke");

  bool firstRender = true;
  List<ModelPokemon> _favoritesPokemons = [];

  List<ModelPokemon> get favoritesPokemons => _favoritesPokemons;

  void getFavoritesPokemons() {
    List<ModelPokemon> list =
        GetManyFavoritesPokemonsUseCase(PokemonsRepository(pokeDex)).handle();

    _favoritesPokemons = list;

    if (firstRender) firstRender = !firstRender;

    notifyListeners();
  }

  void getFavorites() {
    List<ModelPokemon> list =
        GetManyFavoritesPokemonsUseCase(PokemonsRepository(pokeDex)).handle();

    _favoritesPokemons = list;
  }
}
