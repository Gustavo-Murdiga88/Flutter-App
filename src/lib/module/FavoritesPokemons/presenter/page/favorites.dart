import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../components/appBar/app_bar.dart';
import '../../../../components/toast/toast.dart';
import '../../../../core/services/infra/hive/adpter.dart';
import '../../../../main.dart';
import '../../../Pokemon/domain/models/pokemon.dart';
import '../../../../components/CardPokemon/card_pokemo_widget.dart';
import '../states/pokemons_favorites_states.dart';
import '../store/pokemons_favorites_store.dart';

class ListFavoritePokemons extends StatefulWidget {
  const ListFavoritePokemons({super.key});

  @override
  State<ListFavoritePokemons> createState() => _ListFavoritePokemonsState();
}

class _ListFavoritePokemonsState extends State<ListFavoritePokemons> {
  int page = 0;
  int perPage = 5;

  bool hasLastPage = false;

  bool isFetching = false;

  final ScrollController controller = ScrollController();

  final favoritesStore = Modular.get<FavoritesPokemonsStore>();

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

  void handleChangePagination() async {
    if (controller.offset >= controller.position.maxScrollExtent - 100 &&
        !hasLastPage &&
        !isFetching) {
      isFetching = true;
      final shouldBeGetMorePokemons =
          await favoritesStore.getManyPokemons(page, perPage);
      if (shouldBeGetMorePokemons) {
        page++;
        isFetching = false;
      } else {
        hasLastPage = true;
        isFetching = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    favoritesStore.getManyPokemons(page, perPage);
    controller.addListener(() {
      handleChangePagination();
    });
    page++;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: "Pokemons Favoritos",
        body: ValueListenableBuilder(
          valueListenable: favoritesStore,
          builder: (context, value, _) {
            if (value is FavoritesPokemonsLoading && value.list.isEmpty) {
              return Container(
                color: Colors.green,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
              );
            }

            if (value is FavoritesPokemonsError) {
              return Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(value.message),
                  ));
            }

            if ((value is FavoritesPokemonsSuccess ||
                    value is FavoritesPokemonsLoading) &&
                value.list.isNotEmpty) {
              return Stack(
                children: [
                  ListView.builder(
                      controller: controller,
                      itemCount: value.list.length,
                      itemBuilder: (context, index) {
                        final item = value.list[index];
                        final pokemon = PokemonModel(
                            base_experience: item.base_experience,
                            id: item.id,
                            name: item.name,
                            weight: item.weight,
                            isFavorite: item.isFavorite);

                        return CardPokemon(
                            unFavorite: () {
                              favoritesStore.unFavoritePokemon(index, item.id);
                              fToast.showToast(
                                child: const ToastComponent(
                                    toastType: ToastType.alert,
                                    message: "Pokemon removido com sucesso"),
                                gravity: ToastGravity.TOP_LEFT,
                              );
                            },
                            favorite: () {
                              favoritesStore.favoritePokemon(
                                  ModelPokemon(
                                      id: pokemon.id,
                                      name: pokemon.name,
                                      weight: pokemon.weight.toString(),
                                      base_exprecience:
                                          pokemon.base_experience.toString(),
                                      specie: pokemon.name),
                                  index);

                              fToast.showToast(
                                child: const ToastComponent(
                                    toastType: ToastType.alert,
                                    message: "Pokemon removido com sucesso"),
                                gravity: ToastGravity.TOP_LEFT,
                              );
                            },
                            key: Key(pokemon.id.toString()),
                            name: pokemon.name,
                            img: pokemon.img,
                            isFavorite: pokemon.favorite,
                            gradient: pokemon.gradient,
                            weight: pokemon.weight.toString(),
                            xp: pokemon.base_experience.toString(),
                            specie: pokemon.name,
                            id: pokemon.id);
                      }),
                  if (value is FavoritesPokemonsLoading)
                    Positioned(
                      bottom: 20,
                      left: MediaQuery.of(context).size.width / 2,
                      child: const CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                ],
              );
            }

            return _emptyPage();
          },
        ));
  }
}
