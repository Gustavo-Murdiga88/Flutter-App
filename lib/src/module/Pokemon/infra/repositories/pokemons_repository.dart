// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/errors/failure.dart';
import '../../../../core/services/infra/hive/adpter.dart';
import '../../domain/models/favoritePokemon.dart';
import '../../domain/models/fetchPokemons.dart';
import '../../domain/models/pokemon.dart';
import '../../external/data/pokemons_datasouce.dart';
import 'implementations.dart';

class PokemonsRepository extends IPokemonRepository {
  final PokemonsData dataSource;

  PokemonsRepository(
    this.dataSource,
  );

  @override
  Future<FetchPokemon> getPokemons(Uri? uri) async {
    try {
      final response = await dataSource.getManyPokemons(uri);

      return response;
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<PokemonModel> getPokemon(Uri url) async {
    try {
      final response = await dataSource.getPokemon(url);

      return response;
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<FavoritePokemonModel> favoritePokemon(ModelPokemon pokemon) async {
    try {
      await dataSource.favoritePokemon(pokemon);

      final response = FavoritePokemonModel(
          isFavorite: true,
          base_experience: int.parse(pokemon.base_exprecience),
          id: pokemon.id,
          name: pokemon.name,
          weight: int.parse(pokemon.weight));

      return response;
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  bool pokemonIsFavorite(int id) {
    try {
      final response = dataSource.pokemonIsFavorite(id);

      return response;
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  bool unFavoritePokemon(int id) {
    try {
      final response = dataSource.unFavoritePokemon(id);
      if (response) {
        return true;
      }
      return false;
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }
}
