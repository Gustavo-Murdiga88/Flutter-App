import 'package:either_dart/either.dart';

import '../../../../core/errors/failure.dart';
import '../../infra/repositories/implementations.dart';
import '../errors/errors.dart';
import '../models/pokemon.dart';

class GetPokemonUseCase {
  late IPokemonRepository _repository;

  GetPokemonUseCase(IPokemonRepository repository) {
    _repository = repository;
  }

  Future<Either<GetPokemonsErros, PokemonModel>> call(Uri uri) async {
    try {
      final response = await _repository.getPokemon(uri);
      final isFavorite = _repository.pokemonIsFavorite(response.id);

      response.favorite = isFavorite;

      return Right(response);
    } on GetPokemonsErros catch (e) {
      return Left(e);
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }
}
