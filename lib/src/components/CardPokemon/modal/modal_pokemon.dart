import 'package:flutter/material.dart';

class ModalPokemon {
  final String _name;
  final String _img;
  final String _weight;
  final String _specie;
  final String _xp;

  ModalPokemon(
      {required String name,
      required String img,
      required String weight,
      required String specie,
      required String xp})
      : _name = name,
        _img = img,
        _specie = specie,
        _weight = weight,
        _xp = xp;

  Future<String?> modalPokemon(BuildContext context) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(fit: StackFit.loose, children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 10,
                      child: IconButton(
                        alignment: Alignment.center,
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ]),
                  Flex(direction: Axis.horizontal, children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 20, left: 30, bottom: 20),
                        child: Image.network(
                          _img,
                          height: 190,
                          width: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Espécie"),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(_specie,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Força"),
                              ],
                            ),
                            Row(
                              children: [
                                Text(_weight,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Experiência:"),
                              ],
                            ),
                            Row(
                              children: [
                                Text(_xp,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            )));
  }
}
