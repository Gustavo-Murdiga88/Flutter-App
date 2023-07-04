import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/services/infra/hive/adpter.dart';
import '../../../FavoritesPokemons/external/datasource/favorites_pokemons_datasource.dart';
import '../../../Pokemon/presenter/page/home_pokemon.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = Hive.box<ModelPokemon>("poke").listenable();

  final dataSource =
      FavoritesPokemonsDataSource(Hive.box<ModelPokemon>("poke"));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        builder: (context, _, child) {
          final favorites = dataSource.getManyPokemons();
          return Home(favorites: favorites);
        },
        valueListenable: box);
  }
}
