// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../Pokemon/domain/models/favoritePokemon.dart';

abstract class FavoritesPokemonsState {
  final List<FavoritePokemonModel> list;

  FavoritesPokemonsState(
    this.list,
  );
}

class FavoritesPokemonsInitial extends FavoritesPokemonsState {
  FavoritesPokemonsInitial(list) : super(list);
}

class FavoritesPokemonsLoading extends FavoritesPokemonsState {
  FavoritesPokemonsLoading(list) : super(list);
}

class FavoritesPokemonsError extends FavoritesPokemonsState {
  final String message;
  FavoritesPokemonsError(list, this.message) : super(list);
}

class FavoritesPokemonsSuccess extends FavoritesPokemonsState {
  FavoritesPokemonsSuccess(list) : super(list);
}
