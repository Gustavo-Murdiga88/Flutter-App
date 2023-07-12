import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/infra/hive/adpter.dart';
import '../Pokemon/domain/use_cases/favorite_pokemon.dart';
import '../Pokemon/domain/use_cases/un_favorite_pokemon.dart';
import 'domain/use_cases/get_many_pokemons_favorites.dart';
import 'external/datasource/favorites_pokemons_datasource.dart';
import 'infra/repositories/pokemons_repository.dart';
import 'presenter/page/favorites.dart';
import 'presenter/store/pokemons_favorites_store.dart';

class FavoritesModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => GetManyPokemonsFavoritesUseCase(i())),
        Bind.factory((i) => FavoritesRepository(i())),
        Bind.factory((i) => FavoritesPokemonsDataSource(PokeDex.instance.box)),
        Bind.factory((i) => FavoritePokemonUseCase(i())),
        Bind.factory((i) => UnfavoritePokemonUseCase(i())),
        Bind.factory((i) => FavoritesPokemonsStore(i(), i(), i())),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute("/", child: (context, args) => const ListFavoritePokemons())];
}
