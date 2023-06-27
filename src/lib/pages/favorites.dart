import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../components/CardPokemon/index.dart';
import '../components/appBar/index.dart';
import '../models/pokemon.dart';
import '../repositories/pokemons_repository.dart';
import '../store/favorites_pokemons.dart';
import '../uses_cases/get_pokemons.dart';

class ListFavoritePokemons extends StatefulWidget {
  const ListFavoritePokemons({super.key});

  @override
  State<ListFavoritePokemons> createState() => _ListFavoritePokemonsState();
}

class _ListFavoritePokemonsState extends State<ListFavoritePokemons> {
  List<CardPokemon> listPokemons = [];
  bool isLoading = true;

  void updateList(int id) {
    final list = listPokemons.where((item) => item.id != id).toList();

    setState(() {
      listPokemons = list;
    });
  }

  Future<void> getPokemons() async {
    var pokeDex = Hive.box<ModelPokemon>("poke");

    final useCase = GetPokemonsUseCase(PokemonsRepository(pokeDex));
    final result = useCase.handle();

    result.fold((left) {
      setState(() {
        isLoading = false;
      });
    }, (list) {
      final cards = list
          .map((ModelPokemon e) => CardPokemon(
                gradient: e.gradient,
                id: e.id,
                img: e.img,
                name: e.name,
                isFavorite: true,
                specie: e.specie,
                weight: e.weight,
                xp: e.xp,
                effect: updateList,
                key: Key(e.id.toString()),
              ))
          .toList();

      setState(() {
        listPokemons = cards;
        isLoading = false;
      });
    });
  }

  Widget _emptyPage() {
    return const Center(
      child: Text(
        "Não existem pokemons selecionados",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    if (listPokemons.isEmpty) {
      return _emptyPage();
    }

    return ListView.builder(
        itemCount: listPokemons.length,
        itemBuilder: (context, index) {
          return listPokemons[index];
        });
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  static const gradient =
      "https://images.unsplash.com/photo-1579546929518-9e396f3cc809?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80";

  static const img =
      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png";

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesPokemons>().getFavorites();

    return const AppScaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 12, left: 12, right: 12),
          child: ListFavoritePokemons()),
    );
  }
}
