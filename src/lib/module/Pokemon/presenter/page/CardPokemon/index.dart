import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import '../../../../../components/toast/toast.dart';
import '../../../../../core/services/infra/hive/adpter.dart';
import '../../../../../main.dart';
import '../../../domain/use_cases/favorite_pokemon.dart';
import '../../../domain/use_cases/un_favorite_pokemon.dart';
import '../../../external/data/pokemons_datasouce.dart';
import '../../../infra/repositories/pokemons_repository.dart';
import '../../states/favorite_pokemon.dart';
import '../../store/favorite_pokemon_store.dart';
import 'modal/modal_pokemon.dart';

class CardPokemon extends StatefulWidget {
  const CardPokemon({
    super.key,
    required this.name,
    required this.img,
    required this.isFavorite,
    required this.gradient,
    required this.weight,
    required this.xp,
    required this.specie,
    required this.id,
  });
  final int id;
  final String name;
  final String img;
  final String gradient;
  final String weight;
  final String xp;
  final String specie;
  final bool isFavorite;

  @override
  State<CardPokemon> createState() => _CardPokemonState();
}

class _CardPokemonState extends State<CardPokemon> {
  final favoriteStore = FavoriteStore(
      FavoritePokemonUseCase(PokemonsRepository(
          PokemonsData(Client(), Hive.box<ModelPokemon>("poke")))),
      UnfavoritePokemonUseCase(PokemonsRepository(
          PokemonsData(Client(), Hive.box<ModelPokemon>("poke")))));

  @override
  void initState() {
    super.initState();

    favoriteStore.value =
        InitialStateFavoritePokemon(isFavorite: widget.isFavorite);
  }

  @override
  void didUpdateWidget(covariant CardPokemon oldWidget) {
    super.didUpdateWidget(oldWidget);

    favoriteStore.value =
        InitialStateFavoritePokemon(isFavorite: widget.isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          border: Border.all(width: 8, color: Colors.white70),
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(widget.gradient),
            fit: BoxFit.cover,
          )),
      child: InkWell(
        radius: 20,
        onTap: () => ModalPokemon(
                img: widget.img,
                name: widget.name,
                specie: widget.specie,
                weight: widget.weight,
                xp: widget.xp)
            .modalPokemon(context),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 12),
          child: Column(
            children: [
              ValueListenableBuilder<FavoritePokemonState>(
                  valueListenable: favoriteStore,
                  builder: (context, value, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            tooltip: value.isFavorite
                                ? "Pokemon favorito"
                                : "Clique e adicione como favorito",
                            icon: Icon(Icons.star,
                                size: 40,
                                color: value.isFavorite
                                    ? Colors.yellow
                                    : Colors.green),
                            onPressed: () async {
                              if (value.isFavorite) {
                                favoriteStore.unFavorite(widget.id);

                                fToast.showToast(
                                  child: const ToastComponent(
                                      toastType: ToastType.alert,
                                      message: "Pokemon removido com sucesso"),
                                  gravity: ToastGravity.TOP_LEFT,
                                );

                                return;
                              }

                              favoriteStore.favorite(ModelPokemon(
                                  specie: widget.specie,
                                  base_exprecience: widget.xp,
                                  id: widget.id,
                                  name: widget.name,
                                  weight: widget.weight));
                              fToast.showToast(
                                child: const ToastComponent(
                                    toastType: ToastType.success,
                                    message: "Pokemon adicionado com sucesso"),
                                gravity: ToastGravity.TOP_LEFT,
                              );
                            }),
                      ],
                    );
                  }),
              Image.network(
                alignment: Alignment.center,
                widget.img,
                fit: BoxFit.cover,
                height: 190,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.name,
                maxLines: 12,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
