import 'package:either_dart/either.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/infra/hive/adpter.dart';
import '../../infra/repositories/implementations.dart';
import '../errors/errors.dart';
import '../models/favoritePokemon.dart';

class FavoritePokemonUseCase {
  late IPokemonRepository _repository;

  FavoritePokemonUseCase(IPokemonRepository repository) {
    _repository = repository;
  }

  Future<Either<Failure, FavoritePokemonModel>> call(
      ModelPokemon pokemon) async {
    try {
      final response = await _repository.favoritePokemon(pokemon);

      return Right(response);
    } on GetPokemonsErros catch (e) {
      return Left(e);
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }
}
