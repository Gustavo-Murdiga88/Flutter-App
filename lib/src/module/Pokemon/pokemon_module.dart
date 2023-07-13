import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/infra/hive/adpter.dart';
import '../main/presenter/page/main.dart';
import 'domain/use_cases/favorite_pokemon.dart';
import 'domain/use_cases/get_pokemon.dart';
import 'domain/use_cases/get_pokemons.dart';
import 'domain/use_cases/un_favorite_pokemon.dart';
import 'external/data/pokemons_datasouce.dart';
import 'infra/repositories/pokemons_repository.dart';
import 'presenter/store/favorite_pokemon_store.dart';
import 'presenter/store/pokemon_store.dart';

class PokemonModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => FavoritePokemonUseCase(i())),
        Bind.factory((i) => GetPokemonUseCase(i())),
        Bind.factory((i) => GetPokemonsUseCase(i())),
        Bind.factory((i) => PokemonsRepository(i())),
        Bind.factory((i) => UnfavoritePokemonUseCase(i())),
        Bind.factory((i) => PokemonsState(i(), i())),
        Bind.factory((i) => PokemonsData(i(), pokeDex.box)),
        Bind.factory((i) => FavoriteStore(i(), i())),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute("/", child: (context, args) => const MyApp())];
}
