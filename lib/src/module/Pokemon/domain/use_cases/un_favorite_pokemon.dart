import 'package:either_dart/either.dart';

import '../../../../core/errors/failure.dart';
import '../../infra/repositories/implementations.dart';
import '../errors/errors.dart';

class UnfavoritePokemonUseCase {
  late IPokemonRepository _repository;

  UnfavoritePokemonUseCase(IPokemonRepository repository) {
    _repository = repository;
  }

  Future<Either<Failure, bool>> call(int id) async {
    try {
      final response = _repository.unFavoritePokemon(id);

      return Right(response);
    } on GetPokemonsErros catch (e) {
      return Left(e);
    } catch (e) {
      rethrow;
    }
  }
}
