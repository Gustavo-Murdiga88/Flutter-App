import '../repositories/implementations.dart';

class PokemonIsFavoriteUseCase {
  late IPokemonsRepository _repository;

  PokemonIsFavoriteUseCase(IPokemonsRepository repository) {
    _repository = repository;
  }

  bool handle(int id) {
    try {
      final isFavorite = _repository.isPokemonFavorite(id);
      return isFavorite;
    } catch (e) {
      print(e);
      throw Error();
    }
  }
}
