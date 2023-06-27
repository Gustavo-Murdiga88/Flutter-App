import 'package:either_dart/either.dart';

import '../models/pokemon.dart';
import '../repositories/implementations.dart';

class GetPokemonsUseCase {
  late IPokemonsRepository _repository;

  GetPokemonsUseCase(IPokemonsRepository repository) {
    _repository = repository;
  }

  Either<Error, List<ModelPokemon>> handle() {
    try {
      final list = _repository.getManyPokemons() as List<ModelPokemon>;
      return Right(list);
    } on Error catch (e) {
      return Left(e);
    }
  }
}
