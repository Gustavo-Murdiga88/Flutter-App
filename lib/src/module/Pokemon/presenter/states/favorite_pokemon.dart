// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class FavoritePokemonState {
  bool _isFavorite;

  FavoritePokemonState(this._isFavorite);

  bool get isFavorite => _isFavorite;

  set favorite(bool value) {
    _isFavorite = value;
  }
}

class InitialStateFavoritePokemon extends FavoritePokemonState {
  InitialStateFavoritePokemon({isFavorite}) : super(isFavorite ?? false);
}

class SuccessStateFavoritePokemon extends FavoritePokemonState {
  SuccessStateFavoritePokemon({required isFavorite}) : super(isFavorite);
}

class FailureFavorite extends FavoritePokemonState {
  String message;
  FailureFavorite({required this.message, required isFavorite})
      : super(isFavorite);
}
