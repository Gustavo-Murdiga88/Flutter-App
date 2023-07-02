// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import '../../../../core/errors/failure.dart';
import '../../../Pokemon/domain/models/favoritePokemon.dart';

abstract class IFavoritesPokemonsDataSource {
  List<FavoritePokemonModel> getFavoritesPokemons();
}

class FavoritesPokemonsDataSource implements IFavoritesPokemonsDataSource {
  final Box<dynamic> pokeDex;

  FavoritesPokemonsDataSource(
    this.pokeDex,
  );

  @override
  List<FavoritePokemonModel> getFavoritesPokemons() {
    try {
      final favoritesPokemons = pokeDex.values.toList();

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
