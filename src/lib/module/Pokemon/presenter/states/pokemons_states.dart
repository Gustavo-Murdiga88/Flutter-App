import '../../domain/models/pokemon.dart';

abstract class PokemonsStates {
  final String? next;
  final String? previous;
  final List<PokemonModel> results;

  PokemonsStates({this.next, this.previous, required this.results});
}

class InitialState extends PokemonsStates {
  InitialState({next, previous, results})
      : super(next: next, previous: previous, results: []);
}

class SuccessPokemons extends PokemonsStates {
  SuccessPokemons({next, previous, required results})
      : super(next: next, previous: previous, results: results);
}

class FailurePokemons extends PokemonsStates {
  final String message;
  FailurePokemons({next, previous, required results, required this.message})
      : super(next: next, previous: previous, results: results);
}
