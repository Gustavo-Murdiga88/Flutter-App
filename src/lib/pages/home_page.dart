import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store/pokemons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<PaginationPokemons>().isLoading;
    final hasFetched = context.watch<PaginationPokemons>().hasFetched;

    if (hasFetched == false) {
      context.read<PaginationPokemons>().build();
    }

    if (isLoading) {
      return Container(
        color: Colors.green,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white70,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Padding(
            padding: EdgeInsets.only(right: 90),
            child: Center(
              child: Text(
                "App Pokemon",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          )),
      endDrawer: Drawer(
          shadowColor: Colors.green,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  'App Pokemon guarani sistemas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.star, color: Colors.yellow),
                title: const Text('Favoritos'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )),
      body: ListView(
        padding:
            const EdgeInsets.only(top: 10, bottom: 12, left: 12, right: 12),
        children: context.watch<PaginationPokemons>().pokemons,
      ),
      backgroundColor: Colors.white70,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.green,
        child: Container(
          height: 60.0,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                icon: const Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  context.read<PaginationPokemons>().previousPage();
                },
                tooltip: "Previous Page"),
            const SizedBox(
              width: 20,
            ),
            IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  context.read<PaginationPokemons>().nextPage();
                },
                tooltip: "Next Page"),
          ]),
        ),
      ),
    );
  }
}
