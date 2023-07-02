import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

import '../../../../core/services/infra/hive/adpter.dart';
import '../../domain/models/favoritePokemon.dart';
import 'CardPokemon/index.dart';
import '../../../../components/appBar/index.dart';
import '../../domain/use_cases/get_pokemon.dart';
import '../../domain/use_cases/get_pokemons.dart';
import '../../external/data/pokemons_datasouce.dart';
import '../../infra/repositories/pokemons_repository.dart';
import '../states/pokemons_states.dart';
import '../store/pokemon_store.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.favorites});

  final List<FavoritePokemonModel> favorites;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final state = PokemonsState(
      GetPokemonsUseCase(PokemonsRepository(
          PokemonsData(Client(), Hive.box<ModelPokemon>("poke")))),
      GetPokemonUseCase(PokemonsRepository(
          PokemonsData(Client(), Hive.box<ModelPokemon>("poke")))));

  bool areFavoritePokemon(int id) {
    final result = widget.favorites.where((item) => item.id == id).toList();

    if (result.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    state.addListener(() {
      setState(() {});
    });

    state.getPokemons(null);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ValueListenableBuilder(
          valueListenable: state,
          builder: (context, value, child) {
            if (value is InitialState) {
              return Container(
                color: Colors.green.withOpacity(0.5),
                height: double.infinity,
                width: double.infinity,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white70,
                  ),
                ),
              );
            }
            if (value is FailurePokemons) {
              return Center(
                child: Text(value.message),
              );
            }

            if (value is SuccessPokemons) {
              return ListView.builder(
                  itemCount: value.results.length,
                  itemBuilder: (context, index) {
                    return CardPokemon(
                        name: value.results[index].name,
                        img: value.results[index].img,
                        isFavorite: areFavoritePokemon(value.results[index].id),
                        gradient: value.results[index].gradient,
                        weight: value.results[index].weight.toString(),
                        xp: value.results[index].base_experience.toString(),
                        specie: value.results[index].name,
                        id: value.results[index].id);
                  });
            }

            return Container();
          }),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.green,
        child: SizedBox(
          height: 60.0,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                disabledColor: Colors.grey,
                color: Colors.white,
                icon: const Icon(Icons.remove),
                onPressed: state.value.previous is String
                    ? () {
                        state.getPreviousPage(state.value.previous!);
                      }
                    : null,
                tooltip: "Previous Page"),
            const SizedBox(
              width: 20,
            ),
            IconButton(
                disabledColor: Colors.grey,
                color: Colors.white,
                icon: const Icon(Icons.add),
                onPressed: state.value.next is String
                    ? () {
                        state.getNexPage(state.value.next!);
                      }
                    : null,
                tooltip: "Next Page"),
          ]),
        ),
      ),
    );
  }
}
