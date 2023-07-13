// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/infra/hive/adpter.dart';
import '../../domain/errors/errors.dart';
import '../../domain/models/favoritePokemon.dart';
import '../../domain/models/fetchPokemons.dart';
import '../../domain/models/pokemon.dart';

abstract class PokemonsDataSource {
  Future<FetchPokemon> getManyPokemons(Uri? url);
  Future<PokemonModel> getPokemon(Uri url);
  Future<FavoritePokemonModel> favoritePokemon(ModelPokemon url);
  bool pokemonIsFavorite(int id);
  bool unFavoritePokemon(int id);
}

class PokemonsData extends PokemonsDataSource {
  final Client http;
  final path =
      Uri().resolve("https://pokeapi.co/api/v2/pokemon?limit=5&offset=0");

  final Box<ModelPokemon> pokeDex;

  PokemonsData(
    this.http,
    this.pokeDex,
  );

  @override
  Future<FetchPokemon> getManyPokemons(Uri? defaultPath) async {
    try {
      final response = await http.get(defaultPath ?? path);

      if (response.statusCode != 200) {
        Left(RequestError(
            message:
                "Não foi possível realizar a requisição, status code: ${response.statusCode}",
            stackTrace: StackTrace.current));
      }

      if (response.body.isEmpty) {
        Left(FormatError(
            message:
                "should be not able continuos of the reques because this response is not a Map<String, dynamic>",
            stackTrace: StackTrace.current));
      }

      final map = jsonDecode(response.body);
      final list = (map["results"] as List)
          .map((e) => {
                "name": e["name"],
                "url": e["url"],
              })
          .toList();

      return FetchPokemon(
          results: list, next: map["next"], previous: map["previous"]);
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<PokemonModel> getPokemon(Uri url) async {
    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        Left(RequestError(
            message:
                "Não foi possível realizar a requisição, status code: ${response.statusCode}",
            stackTrace: StackTrace.current));
      }

      if (response.body.isEmpty) {
        Left(FormatError(
            message:
                "should be not able continuos of the reques because this response is not a Map<String, dynamic>",
            stackTrace: StackTrace.current));
      }

      final map = jsonDecode(response.body);

      return PokemonModel(
          base_experience: map["base_experience"],
          id: map["id"],
          isFavorite: false,
          name: map["name"],
          weight: map["weight"]);
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<FavoritePokemonModel> favoritePokemon(ModelPokemon pokemon) async {
    try {
      await pokeDex.add(pokemon);

      return FavoritePokemonModel(
          base_experience: int.parse(pokemon.base_exprecience),
          id: pokemon.id,
          name: pokemon.name,
          weight: int.parse(pokemon.weight),
          isFavorite: true);
    } catch (e, stackTrace) {
      throw Failure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  bool pokemonIsFavorite(int id) {
    try {
      final response =
          pokeDex.values.where((element) => element.id == id).toList();
      if (response.isEmpty) {
        return false;
      }
      return true;
    } catch (e, stackTrace) {
      throw Failure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  bool unFavoritePokemon(int id) {
    try {
      final response = pokeDex.values.firstWhere((element) => element.id == id);
      response.delete();

      return true;
    } catch (e, stackTrace) {
      throw Failure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
