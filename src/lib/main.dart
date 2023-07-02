import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'core/services/infra/hive/adpter.dart';
import 'module/FavoritesPokemons/external/datasource/favorites_pokemons_datasource.dart';
import 'module/FavoritesPokemons/presenter/page/favorites.dart';
import 'module/Pokemon/domain/use_cases/get_pokemons.dart';
import 'module/Pokemon/external/data/pokemons_datasouce.dart';
import 'module/Pokemon/infra/repositories/pokemons_repository.dart';
import 'module/Pokemon/presenter/page/home_pokemon.dart';
import 'module/Pokemon/presenter/store/pokemon_store.dart';

late FToast fToast;

void main() async {
  Hive.registerAdapter(PokemonAdapter());
  await Hive.initFlutter();
  await Hive.openBox<ModelPokemon>("poke");

  runApp(MultiProvider(
    providers: [
      // ChangeNotifierProvider(create: (_) => PaginationPokemons()),
      // ChangeNotifierProvider(
      //   create: (_) => FavoritesPokemons(),
      // ),
      Provider<GetPokemonsUseCase>(
          create: (context) => GetPokemonsUseCase(context.read())),
      Provider<PokemonsRepository>(
          create: (context) => PokemonsRepository(context.read())),
      Provider<PokemonsData>(
          create: (context) => PokemonsData(context.read(), context.read())),
      Provider(create: (context) => Client()),
      ChangeNotifierProvider<PokemonsState>(
          create: (context) => PokemonsState(context.read(), context.read()))
    ],
    child: const MyApp(),
  ));
}

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
    return MaterialApp(
        builder: (context, widget) {
          return Overlay(
            initialEntries: [
              OverlayEntry(builder: (context) {
                fToast = FToast();
                fToast.init(context);
                return widget ?? Container();
              })
            ],
          );
        },
        title: 'Pokemon App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: "/home",
        routes: {
          "/home": (context) => ValueListenableBuilder(
                builder: (context, _, child) {
                  final favorites = dataSource.getFavoritesPokemons();
                  return Home(favorites: favorites);
                },
                valueListenable: box,
              ),
          "/favorites": (context) => ValueListenableBuilder(
                valueListenable: box,
                builder: (context, value, child) {
                  return const ListFavoritePokemons();
                },
              )
        });
  }
}
