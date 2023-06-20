import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'store/pokemons.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('pokeDex');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PaginationPokemons()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => ValueListenableBuilder<Box>(
              valueListenable: Hive.box("pokeDex").listenable(),
              builder: (context, box, widget) {
                return const Home();
              },
            ),
      },
    );
  }
}
