import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../module/Pokemon/presenter/store/favorite_pokemon_store.dart';
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
    required this.unFavorite,
    required this.favorite,
  });
  final int id;
  final String name;
  final String img;
  final String gradient;
  final String weight;
  final String xp;
  final String specie;
  final bool isFavorite;
  final void Function() unFavorite;
  final void Function() favorite;

  @override
  State<CardPokemon> createState() => _CardPokemonState();
}

class _CardPokemonState extends State<CardPokemon> {
  final favoriteStore = Modular.get<FavoriteStore>();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      tooltip: widget.isFavorite
                          ? "Pokemon favorito"
                          : "Clique e adicione como favorito",
                      icon: Icon(Icons.star,
                          size: 40,
                          color:
                              widget.isFavorite ? Colors.yellow : Colors.green),
                      onPressed: () async {
                        if (widget.isFavorite) {
                          widget.unFavorite.call();
                          return;
                        }

                        widget.favorite.call();
                      }),
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
