import 'package:flutter/material.dart';

// ignore: avoid_relative_lib_imports
import 'methods/fetch_pokemons.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon(
      {super.key,
      required this.name,
      required this.img,
      required this.gradient,
      required this.isFavorite});

  final String name;
  final String img;
  final String gradient;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.loose, children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(width: 8, color: Colors.white70),
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(gradient),
              fit: BoxFit.cover,
            )),
        transformAlignment: AlignmentDirectional.center,
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
                child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                        child: Image.network(
                      img,
                      fit: BoxFit.cover,
                      height: 190,
                    )),
                  ),
                  Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 16, top: 8),
                              child: Text(
                                name,
                                maxLines: 12,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
      Positioned(
          top: 10,
          right: 20,
          child: IconButton(
            tooltip: isFavorite
                ? "Pokemon favorito"
                : "Clique e adicione como favorito",
            icon: Icon(Icons.star,
                size: 40, color: isFavorite ? Colors.yellow : Colors.green),
            onPressed: () {
              print(name);
            },
          )),
      Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            tooltip: "Mais informações",
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("oi"),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ]),
                    )),
          ))
    ]);
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

    var selected = false;

    for (Map<String, dynamic> pokemon in listPoke) {
      String url = pokemon["url"];
      var pokeUri = Uri.parse(url);
      var poke = Pokemon(uri: pokeUri);
      await poke.fetch();
      selected = !selected;

      children.add(
        CardPokemon(
            name: poke.name,
            img: poke.img,
            gradient: gradient,
            isFavorite: selected),
      );
    }

    return children;
  }
}
