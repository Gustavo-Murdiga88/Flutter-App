import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../components/appBar/app_bar.dart';
import '../../../../components/toast/toast.dart';
import '../../../../core/services/infra/hive/adpter.dart';
import '../../../../../main.dart';
import '../../domain/models/favoritePokemon.dart';
import '../../../../components/CardPokemon/card_pokemo_widget.dart';
import '../states/pokemons_states.dart';
import '../store/favorite_pokemon_store.dart';
import '../store/pokemon_store.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.favorites});

  final List<FavoritePokemonModel> favorites;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final favoriteStore = Modular.get<FavoriteStore>();
  final state = Modular.get<PokemonsState>();

  bool areFavoritePokemon(List<FavoritePokemonModel> favorites, int id) {
    final result = favorites.where((item) => item.id == id).toList();

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
                        favorite: () {
                          favoriteStore.favoritePokemon(ModelPokemon(
                              id: value.results[index].id,
                              name: value.results[index].name,
                              weight: value.results[index].weight.toString(),
                              base_exprecience: value
                                  .results[index].base_experience
                                  .toString(),
                              specie: value.results[index].name));

                          fToast.showToast(
                            child: const ToastComponent(
                                toastType: ToastType.success,
                                message: "Pokemon adicionado com sucesso"),
                            gravity: ToastGravity.TOP_LEFT,
                          );
                        },
                        unFavorite: () {
                          favoriteStore
                              .unFavoritePokemon(value.results[index].id);
                          fToast.showToast(
                            child: const ToastComponent(
                                toastType: ToastType.alert,
                                message: "Pokemon removido com sucesso"),
                            gravity: ToastGravity.TOP_LEFT,
                          );
                        },
                        name: value.results[index].name,
                        img: value.results[index].img,
                        isFavorite: areFavoritePokemon(
                            widget.favorites, value.results[index].id),
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
