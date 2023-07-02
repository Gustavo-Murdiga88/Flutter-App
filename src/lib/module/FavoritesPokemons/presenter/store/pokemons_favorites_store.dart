import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

import '../../../Pokemon/domain/models/favoritePokemon.dart';
import '../../domain/use_cases/get_many_pokemons_favorites.dart';
import '../states/pokemons_favorites_states.dart';

class FavoritesPokemonsStore extends ValueNotifier<FavoritesPokemonsState> {
  final GetManyPokemonsFavoritesUseCase _getPokemons;

  FavoritesPokemonsStore(this._getPokemons)
      : super(FavoritesPokemonsInitial(<FavoritePokemonModel>[]));

  void getManyPokemons() {
    value = FavoritesPokemonsLoading(value.list);
    final response = _getPokemons();

    response.fold((left) {
      value = FavoritesPokemonsError(value.list, left.message);
    }, (right) {
      value = FavoritesPokemonsSuccess(right);
    });
  }
}
