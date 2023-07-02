import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../components/appBar/index.dart';
import '../../../../core/services/infra/hive/adpter.dart';
import '../../../Pokemon/domain/models/pokemon.dart';
import '../../../Pokemon/presenter/page/CardPokemon/index.dart';
import '../../domain/use_cases/get_many_pokemons_favorites.dart';
import '../../external/datasource/favorites_pokemons_datasource.dart';
import '../../infra/repositories/pokemons_repository.dart';
import '../states/pokemons_favorites_states.dart';
import '../store/pokemons_favorites_store.dart';

class ListFavoritePokemons extends StatefulWidget {
  const ListFavoritePokemons({super.key});

  @override
  State<ListFavoritePokemons> createState() => _ListFavoritePokemonsState();
}

class _ListFavoritePokemonsState extends State<ListFavoritePokemons> {
  final favoritesStore = FavoritesPokemonsStore(GetManyPokemonsFavoritesUseCase(
      FavoritesRepository(
          FavoritesPokemonsDataSource(Hive.box<ModelPokemon>("poke")))));

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
    favoritesStore.getManyPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: ValueListenableBuilder(
      valueListenable: favoritesStore,
      builder: (context, value, _) {
        if (value is FavoritesPokemonsLoading) {
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

        if (value is FavoritesPokemonsSuccess && value.list.isNotEmpty) {
          return ListView.builder(
              itemCount: value.list.length,
              itemBuilder: (context, index) {
                final item = value.list[index];
                final pokemon = PokemonModel(
                    base_experience: item.base_experience,
                    id: item.id,
                    name: item.name,
                    weight: item.weight,
                    isFavorite: true);

                return CardPokemon(
                    key: Key(pokemon.id.toString()),
                    name: pokemon.name,
                    img: pokemon.img,
                    isFavorite: pokemon.favorite,
                    gradient: pokemon.gradient,
                    weight: pokemon.weight.toString(),
                    xp: pokemon.base_experience.toString(),
                    specie: pokemon.name,
                    id: pokemon.id);
              });
        }

        return _emptyPage();
      },
    ));
  }
}
