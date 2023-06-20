import 'package:flutter/material.dart';

import '../components/CardPokemon/index.dart';

class PaginationPokemons extends ChangeNotifier {
  List<Widget> _pokemons = [];
  bool hasFetched = false;
  bool isLoading = true;
  Uri? _previousPage;
  Uri? _nextPage;

  List<Widget> get pokemons => _pokemons;

  final poke = ListPokemons();

  Future<void> build() async {
    final pokemons = await poke.builder(null);

    _nextPage = poke.nextPage;
    _previousPage = poke.previousPage;

    _pokemons = pokemons;
    isLoading = false;
    hasFetched = true;
    notifyListeners();
  }

  Future<void> nextPage() async {
    isLoading = true;
    notifyListeners();
    final pokemons = await poke.builder(_nextPage);
    _nextPage = poke.nextPage;
    _previousPage = poke.previousPage;

    _pokemons = pokemons;
    isLoading = false;
    notifyListeners();
  }

  Future<void> previousPage() async {
    isLoading = true;
    notifyListeners();
    final pokemons = await poke.builder(_previousPage);
    _nextPage = poke.nextPage;
    _previousPage = poke.previousPage;

    _pokemons = pokemons;
    isLoading = false;
    notifyListeners();
  }
}
