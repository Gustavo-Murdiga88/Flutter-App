import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/infra/hive/adpter.dart';
import '../../domain/use_cases/favorite_pokemon.dart';
import '../../domain/use_cases/un_favorite_pokemon.dart';
import '../states/favorite_pokemon.dart';

class FavoriteStore extends ValueNotifier<FavoritePokemonState> {
  final FavoritePokemonUseCase favoritePokemon;
  final UnfavoritePokemonUseCase unFavoritePokemon;

  FavoriteStore(this.favoritePokemon, this.unFavoritePokemon)
      : super(InitialStateFavoritePokemon());

  void favorite(ModelPokemon pokemon) {
    final response = favoritePokemon(pokemon);

    response.fold(
        (left) =>
            {value = FailureFavorite(message: left.message, isFavorite: false)},
        (right) => {value = SuccessStateFavoritePokemon(isFavorite: true)});
  }

  void unFavorite(int id) {
    final response = unFavoritePokemon(id);

    response.fold(
        (left) => value = FailureFavorite(
            message: left.message, isFavorite: value.isFavorite),
        (right) => value = SuccessStateFavoritePokemon(isFavorite: false));
  }
}
