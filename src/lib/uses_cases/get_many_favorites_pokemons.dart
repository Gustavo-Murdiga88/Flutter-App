import '../models/pokemon.dart';
import '../repositories/implementations.dart';

class GetManyFavoritesPokemonsUseCase {
  late IPokemonsRepository _repository;

  GetManyFavoritesPokemonsUseCase(IPokemonsRepository repository) {
    _repository = repository;
  }

  List<ModelPokemon> handle() {
    try {
      final listPokemons = _repository.getManyFavoritesPokemons();
      return listPokemons;
    } catch (e) {
      print(e);
      throw Error();
    }
  }
}
