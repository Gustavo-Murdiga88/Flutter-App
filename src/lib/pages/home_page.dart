import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/appBar/index.dart';
import '../store/favorites_pokemons.dart';
import '../store/pokemons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final pagination = context.watch<PaginationPokemons>();
    final isLoading = pagination.isLoading;
    final hasFetched = pagination.hasFetched;
    context.read<FavoritesPokemons>().getFavorites();

    if (hasFetched == false) {
      pagination.build();
    }

    return AppScaffold(
      body: isLoading
          ? Container(
              color: Colors.green.withOpacity(0.5),
              height: double.infinity,
              width: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white70,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 12, left: 12, right: 12),
              children: pagination.pokemons,
            ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.green,
        child: SizedBox(
          height: 60.0,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                disabledColor: Colors.grey,
                color: Colors.white,
                icon: const Icon(Icons.remove),
                onPressed: pagination.hasPreviewPage
                    ? () {
                        pagination.previousPage();
                      }
                    : null,
                tooltip: "Previous Page"),
            const SizedBox(
              width: 20,
            ),
            IconButton(
                disabledColor: Colors.grey,
                color: Colors.white,
                icon: const Icon(Icons.add),
                onPressed: pagination.hasNextPage
                    ? () {
                        pagination.nextPage();
                      }
                    : null,
                tooltip: "Next Page"),
          ]),
        ),
      ),
    );
  }
}
