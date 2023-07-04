import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FavoritePokemonModel {
  final int id;
  final String name;
  final String weight;
  final String base_exprecience;
  final String specie;
  final bool isFavorite;

  FavoritePokemonModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.base_exprecience,
    required this.specie,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'weight': weight,
      'base_exprecience': base_exprecience,
      'specie': specie,
    };
  }

  factory FavoritePokemonModel.fromMap(Map<String, dynamic> map) {
    return FavoritePokemonModel(
      id: map['id'] as int,
      name: map['name'] as String,
      weight: map['weight'] as String,
      base_exprecience: map['base_exprecience'] as String,
      specie: map['specie'] as String,
      isFavorite: true,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoritePokemonModel.fromJson(String source) =>
      FavoritePokemonModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
