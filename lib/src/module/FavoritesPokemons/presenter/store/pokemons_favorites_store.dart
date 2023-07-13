import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/infra/hive/adpter.dart';
import '../../../Pokemon/domain/models/favoritePokemon.dart';
import '../../../Pokemon/domain/use_cases/favorite_pokemon.dart';
import '../../../Pokemon/domain/use_cases/un_favorite_pokemon.dart';
import '../../domain/use_cases/get_many_pokemons_favorites.dart';
import '../states/pokemons_favorites_states.dart';

class FavoritesPokemonsStore extends ValueNotifier<FavoritesPokemonsState> {
  final GetManyPokemonsFavoritesUseCase _getPokemons;
  final UnfavoritePokemonUseCase _unFavoritePokemonUseCase;
  final FavoritePokemonUseCase _favoritePokemonUseCase;

  FavoritesPokemonsStore(this._getPokemons, this._favoritePokemonUseCase,
      this._unFavoritePokemonUseCase)
      : super(FavoritesPokemonsInitial(<FavoritePokemonModel>[]));

  Future<bool> getManyPokemons(int page, int perPage) async {
    bool shouldBeRefreshed = true;
    value = FavoritesPokemonsLoading(value.list);
    await Future.delayed(const Duration(seconds: 4));

    final response = _getPokemons(page, perPage);

    await response.fold((left) {
      value = FavoritesPokemonsError(value.list, left.message);
    }, (right) {
      if (right.isEmpty) {
        shouldBeRefreshed = false;
      }

      value = FavoritesPokemonsSuccess([...value.list, ...right.toList()]);
    });

    return shouldBeRefreshed;
  }

  void unFavoritePokemon(int index, int id) {
    final response = _unFavoritePokemonUseCase(id);

    response.fold((left) {
      value = FavoritesPokemonsError(value.list, left.message);
    }, (right) {
      value.list[index] = value.list[index].copyWith(isFavorite: false);
      value = FavoritesPokemonsSuccess(value.list);
    });
  }

  void favoritePokemon(ModelPokemon pokemon, int index) async {
    final response = _favoritePokemonUseCase(pokemon);

    response.fold((left) {
      value = FavoritesPokemonsError(value.list, left.message);
    }, (right) {
      value.list[index] = value.list[index].copyWith(isFavorite: true);

      value = FavoritesPokemonsSuccess(value.list);
    });
  }
}
