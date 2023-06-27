import 'dart:async';

import '../models/pokemon.dart';
import '../repositories/implementations.dart';

class FavoritePokemonUseCase {
  late IPokemonsRepository _repository;

  FavoritePokemonUseCase(IPokemonsRepository repository) {
    _repository = repository;
  }

  Future<String> handle(ModelPokemon pokemon) async {
    try {
      await _repository.savePokemon(pokemon);

      return "Pokemon adicionado com sucesso";
    } catch (e) {
      print(e);
      throw Error();
    }
  }
}
