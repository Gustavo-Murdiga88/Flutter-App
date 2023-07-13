// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PokemonModel {
  final int base_experience;
  final int id;
  final String name;
  final int weight;
  bool isFavorite;

  PokemonModel(
      {required this.base_experience,
      required this.id,
      required this.name,
      required this.weight,
      required this.isFavorite});

  String get img =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$id.png";

  String get gradient =>
      "https://images.unsplash.com/photo-1579546929518-9e396f3cc809?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80";

  set favorite(bool favorite) => isFavorite = favorite;

  bool get favorite => isFavorite;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'base_experience': base_experience,
      'id': id,
      'name': name,
      'weight': weight,
      "isFavorite": isFavorite,
    };
  }

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      base_experience: map['base_experience'] as int,
      id: map['id'] as int,
      name: map['name'] as String,
      weight: map['weight'] as int,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonModel.fromJson(String source) =>
      PokemonModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
