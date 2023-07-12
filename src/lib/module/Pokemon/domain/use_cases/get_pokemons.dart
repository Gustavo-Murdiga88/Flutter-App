import 'package:either_dart/either.dart';

import '../../infra/repositories/implementations.dart';
import '../errors/errors.dart';
import '../models/fetchPokemons.dart';

class GetPokemonsUseCase {
  late IPokemonRepository _repository;

  GetPokemonsUseCase(IPokemonRepository repository) {
    _repository = repository;
  }

  Future<Either<GetPokemonsErros, FetchPokemon>> call(Uri? uri) async {
    try {
      final response = await _repository.getPokemons(uri);

      return Right(response);
    } on GetPokemonsErros catch (e) {
      return Left(e);
    } catch (e) {
      rethrow;
    }
  }
}
