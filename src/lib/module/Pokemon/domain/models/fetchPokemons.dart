import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FetchPokemon {
  final String? next;
  final String? previous;
  final List<Map<String, dynamic>> results;

  FetchPokemon({
    this.next,
    this.previous,
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'next': next,
      'previous': previous,
      'results': results,
    };
  }

  factory FetchPokemon.fromMap(Map<String, dynamic> map) {
    return FetchPokemon(
      next: map['next'] != null ? map['next'] as String : null,
      previous: map['previous'] != null ? map['previous'] as String : null,
      results: List<Map<String, String>>.from(
        (map['results'] as List).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchPokemon.fromJson(String source) =>
      FetchPokemon.fromMap(json.decode(source) as Map<String, dynamic>);
}
