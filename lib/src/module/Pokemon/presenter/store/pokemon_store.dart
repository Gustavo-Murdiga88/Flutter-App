// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

import '../../domain/models/pokemon.dart';
import '../../domain/use_cases/get_pokemon.dart';
import '../../domain/use_cases/get_pokemons.dart';
import '../states/pokemons_states.dart';

class PokemonsState extends ValueNotifier<PokemonsStates> {
  GetPokemonsUseCase pokemonsUseCase;
  GetPokemonUseCase pokemonUseCase;

  PokemonsState(
    this.pokemonsUseCase,
    this.pokemonUseCase,
  ) : super(InitialState());

  void getPokemons(Uri? uri) async {
    value = InitialState();

    final response = await pokemonsUseCase(uri);

    response.fold(
        (left) => value =
            FailurePokemons(results: value.results, message: left.message),
        (right) async {
      final mapPokemons = await this.mapPokemons(right.results);

      final listPokemons = mapPokemons.map((pokemon) => pokemon).toList();

      value = SuccessPokemons(
          next: right.next, previous: right.previous, results: listPokemons);
    });
  }

  Future<List<PokemonModel>> mapPokemons(
      List<Map<String, dynamic>> list) async {
    final pokemons = <PokemonModel>[];

    for (final element in list) {
      final uri = Uri().resolve(element["url"]);
      final response = await pokemonUseCase(uri);

      response.fold((left) => Left(value), (right) => pokemons.add(right));
    }

    return pokemons;
  }

  void getNexPage(String url) {
    final uri = Uri().resolve(url);
    getPokemons(uri);
  }

  void getPreviousPage(String url) {
    final uri = Uri().resolve(url);
    getPokemons(uri);
  }
}
