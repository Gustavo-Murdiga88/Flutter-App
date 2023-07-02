import 'package:either_dart/either.dart';

import '../../../../core/errors/failure.dart';
import '../../../Pokemon/domain/models/favoritePokemon.dart';
import '../../infra/repositories/implementations.dart';

class GetManyPokemonsFavoritesUseCase {
  final IFavoritesRepository _repository;

  GetManyPokemonsFavoritesUseCase(this._repository);

  Future<Either<Failure, List<FavoritePokemonModel>>> call() async {
    try {
      final response = await _repository.getManyFavoritesPokemons();

      return Right(response);
    } catch (e, stackTrace) {
      return Left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }
}
