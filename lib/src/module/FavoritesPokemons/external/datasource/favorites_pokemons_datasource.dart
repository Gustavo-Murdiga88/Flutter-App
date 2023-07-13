// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/infra/hive/adpter.dart';
import '../../../Pokemon/domain/models/favoritePokemon.dart';

abstract class IFavoritesPokemonsDataSource {
  List<FavoritePokemonModel> getFavoritesPokemons(int page, int perPage);
  List<FavoritePokemonModel> getManyPokemons();
}

class FavoritesPokemonsDataSource implements IFavoritesPokemonsDataSource {
  final Box<ModelPokemon> pokeDex;

  FavoritesPokemonsDataSource(
    this.pokeDex,
  );

  @override
  List<FavoritePokemonModel> getFavoritesPokemons(page, perPage) {
    try {
      final pokemons = pokeDex.values;

      if (pokemons.isEmpty) {
        return <FavoritePokemonModel>[];
      }

      final lastIndexPage = (page * perPage) + perPage;
      final initialIndexPage = (page * perPage);
      final lastIndexOfListPokemons = pokemons.length;

      final lastIndex = lastIndexOfListPokemons > lastIndexPage
          ? lastIndexPage
          : lastIndexOfListPokemons;

      final initialIndex =
          initialIndexPage > lastIndexOfListPokemons ? 0 : initialIndexPage;

      if (initialIndex != initialIndexPage) {
        return <FavoritePokemonModel>[];
      }

      final list = pokemons
          .toList()
          .getRange(initialIndex, lastIndex)
          .map((pokemon) => FavoritePokemonModel(
              isFavorite: true,
              base_experience: int.parse(pokemon.base_exprecience),
              id: pokemon.id,
              name: pokemon.name,
              weight: int.parse(pokemon.weight)))
          .toList();

      return list;
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
