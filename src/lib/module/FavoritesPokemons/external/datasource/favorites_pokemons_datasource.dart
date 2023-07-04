// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import '../../../../core/errors/failure.dart';
import '../../../Pokemon/domain/models/favoritePokemon.dart';

abstract class IFavoritesPokemonsDataSource {
  List<FavoritePokemonModel> getFavoritesPokemons(int page, int perPage);
  List<FavoritePokemonModel> getManyPokemons();
}

class FavoritesPokemonsDataSource implements IFavoritesPokemonsDataSource {
  final Box<dynamic> pokeDex;

  FavoritesPokemonsDataSource(
    this.pokeDex,
  );

  @override
  List<FavoritePokemonModel> getFavoritesPokemons(page, perPage) {
    try {
      final totalItems = pokeDex.length;
      var lastIndex = (page * perPage) + perPage;
      lastIndex = lastIndex < totalItems ? lastIndex : totalItems;
      var initialIndex = page * perPage;

      final pokemons = pokeDex.values.toList().reversed.skip(initialIndex);

      if (lastIndex < totalItems) {
        final favoritesPokemons = pokemons.takeWhile((value) {
          if (initialIndex < lastIndex) {
            initialIndex++;
            return true;
          }
          return false;
        }).toList();

        final list = favoritesPokemons.map((e) {
          final favoritePokemon = FavoritePokemonModel(
              isFavorite: true,
              base_experience: int.parse(e.base_exprecience),
              id: e.id,
              name: e.name,
              weight: int.parse(e.weight));

          return favoritePokemon;
        }).toList();

        return list;
      }

      return <FavoritePokemonModel>[];
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  List<FavoritePokemonModel> getManyPokemons() {
    try {
      final favoritesPokemons = pokeDex.values;

      final list = favoritesPokemons.map((e) {
        final favoritePokemon = FavoritePokemonModel(
            isFavorite: true,
            base_experience: int.parse(e.base_exprecience),
            id: e.id,
            name: e.name,
            weight: int.parse(e.weight));

        return favoritePokemon;
      }).toList();

      return list;
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }
}
