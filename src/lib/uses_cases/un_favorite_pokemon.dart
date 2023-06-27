import 'dart:async';

import '../repositories/implementations.dart';

class UnFavoritePokemonUseCase {
  late IPokemonsRepository _repository;

  UnFavoritePokemonUseCase(IPokemonsRepository repository) {
    _repository = repository;
  }

  Future<String> handle(int id) async {
    try {
      await _repository.deletePokemon(id);

      return "Pokemon removido com sucesso";
    } catch (e) {
      print(e);
      throw Error();
    }
  }
}
