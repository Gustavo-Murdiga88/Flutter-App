import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

import 'module/FavoritesPokemons/favorites_module.dart';
import 'module/Pokemon/pokemon_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => Client()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute("/", module: PokemonModule()),
        ModuleRoute("/favorites", module: FavoritesModule())
      ];
}
