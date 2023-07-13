// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavoritePokemonModel {
  final bool isFavorite;
  final int base_experience;
  final int id;
  final String name;
  final int weight;

  FavoritePokemonModel({
    required this.isFavorite,
    required this.base_experience,
    required this.id,
    required this.name,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isFavorite': isFavorite,
      'base_experience': base_experience,
      'id': id,
      'name': name,
      'weight': weight,
    };
  }

  factory FavoritePokemonModel.fromMap(Map<String, dynamic> map) {
    return FavoritePokemonModel(
      isFavorite: map['isFavorite'] as bool,
      base_experience: map['base_experience'] as int,
      id: map['id'] as int,
      name: map['name'] as String,
      weight: map['weight'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoritePokemonModel.fromJson(String source) =>
      FavoritePokemonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FavoritePokemonModel copyWith({
    bool? isFavorite,
    int? base_experience,
    int? id,
    String? name,
    int? weight,
  }) {
    return FavoritePokemonModel(
      isFavorite: isFavorite ?? this.isFavorite,
      base_experience: base_experience ?? this.base_experience,
      id: id ?? this.id,
      name: name ?? this.name,
      weight: weight ?? this.weight,
    );
  }
}
