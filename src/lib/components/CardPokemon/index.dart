import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/pokemon.dart';
import '../../repositories/pokemons_repository.dart';
import '../../store/favorites_pokemons.dart';
import '../../uses_cases/favorite_pokemon.dart';
import '../../uses_cases/pokemon_is_favorite.dart';
import '../../uses_cases/un_favorite_pokemon.dart';
import 'methods/fetch_pokemons.dart';
import 'modal/modal_pokemon.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    this.effect,
  });
  final int id;
  final String name;
  final String img;
  final String gradient;
  final String weight;
  final String xp;
  final String specie;
  final bool isFavorite;

  final Function(int id)? effect;

  @override
  State<CardPokemon> createState() => _CardPokemonState(isFavorite: isFavorite);
}

class _CardPokemonState extends State<CardPokemon> {
  bool isFavorite;
  var pokeDex = Hive.box<ModelPokemon>("poke");

  _CardPokemonState({required bool this.isFavorite});

  Widget _toast(String msg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, color: Colors.white),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            msg,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<String> favorite(Function? updateList) async {
    final useCase = FavoritePokemonUseCase(PokemonsRepository(pokeDex));

    final pokemon = ModelPokemon(
        id: widget.id,
        name: widget.name,
        img: widget.img,
        gradient: widget.gradient,
        isFavorite: isFavorite,
        weight: widget.weight,
        xp: widget.xp,
        specie: widget.specie);
    final result = await useCase.handle(pokemon);

    if (updateList != null) {
      updateList();
    }

    return result;
  }

  Future<String> unFavorite(Function? updateList) async {
    final useCase = UnFavoritePokemonUseCase(PokemonsRepository(pokeDex));

    final result = await useCase.handle(widget.id);

    if (widget.effect != null) {
      widget.effect!(widget.id);
    }

    if (updateList != null) {
      updateList();
    }

    return result;
  }

  bool isFavoritePokemon(List<ModelPokemon> list, int id) {
    final isFavoritePokemon =
        list.where((element) => element.id == id).toList();

    if (isFavoritePokemon.isEmpty) {
      return false;
    }
    return true;
  }

  void fetchList(Function fetchList) {
    fetchList();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesPokemons>().favoritesPokemons;
    final handleChangeFavorites =
        context.watch<FavoritesPokemons>().getFavoritesPokemons;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: isFavoritePokemon(favorites, widget.id)
                        ? "Pokemon favorito"
                        : "Clique e adicione como favorito",
                    icon: Icon(Icons.star,
                        size: 40,
                        color: isFavoritePokemon(favorites, widget.id)
                            ? Colors.yellow
                            : Colors.green),
                    onPressed: () async {
                      if (isFavoritePokemon(favorites, widget.id)) {
                        final message = await unFavorite(handleChangeFavorites);
                        fToast.showToast(
                          child: _toast(message),
                          gravity: ToastGravity.BOTTOM,
                        );
                        return;
                      }

                      final message = await favorite(handleChangeFavorites);
                      fToast.showToast(
                        child: _toast(message),
                        gravity: ToastGravity.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
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

class ListPokemons {
  late String? _previousPage;
  late String? _nextPage;

  Uri get nextPage {
    return Uri.parse(_nextPage ?? "");
  }

  Uri get previousPage {
    return Uri.parse(_previousPage ?? "");
  }

  Future<List<Widget>> builder(Uri? url) async {
    var pokeDex = Hive.box<ModelPokemon>("poke");

    final Uri uri = url ??
        Uri.https(
            "pokeapi.co", "/api/v2/pokemon", {"limit": "5", "offset": "0"});

    const String gradient =
        "https://images.unsplash.com/photo-1579546929518-9e396f3cc809?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80";
    final fetchPoke = FetchPoke(uri: uri);
    var listPoke = await fetchPoke.fetch();

    _nextPage = fetchPoke.nextPage;
    _previousPage = fetchPoke.previousPage;

    final List<Widget> children = [];

    for (Map<String, dynamic> pokemon in listPoke) {
      String url = pokemon["url"];
      var pokeUri = Uri.parse(url);
      var poke = Pokemon(uri: pokeUri);
      await poke.fetch();

      final selected =
          PokemonIsFavoriteUseCase(PokemonsRepository(pokeDex)).handle(poke.id);

      children.add(
        CardPokemon(
          id: poke.id,
          name: poke.name,
          img: poke.img,
          gradient: gradient,
          isFavorite: selected,
          weight: poke.weight,
          xp: poke.xp,
          specie: poke.specie,
        ),
      );
    }

    return children;
  }
}
