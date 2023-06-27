import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/pokemon.dart';
import 'pages/favorites.dart';
import 'pages/home_page.dart';
import 'store/favorites_pokemons.dart';
import 'store/pokemons.dart';

late FToast fToast;

void main() async {
  Hive.registerAdapter(PokemonAdapter());
  await Hive.initFlutter();
  await Hive.openBox<ModelPokemon>('poke');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PaginationPokemons()),
      ChangeNotifierProvider(
        create: (_) => FavoritesPokemons(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = Hive.box<ModelPokemon>('poke').listenable();

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
        "/home": (context) => ValueListenableBuilder<Box>(
              valueListenable: box,
              builder: (context, box, widget) {
                return const Home();
              },
            ),
        "/favorites": (context) => const FavoritesPage()
      },
    );
  }
}
