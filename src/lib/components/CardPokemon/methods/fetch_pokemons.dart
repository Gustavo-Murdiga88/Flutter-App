import 'dart:convert';

import 'package:http/http.dart' as http;

class Sprites {
  final String img;

  Sprites({required this.img});

  String get image {
    return img;
  }
}

class Pokemon {
  late int _id;
  late String _name;
  late Sprites _sprites;
  late String _img;
  late String _weight;
  late String _specie;
  late String _xp;

  final Uri uri;

  Pokemon({required this.uri});

  Future<void> fetch() async {
    final response = await http.get(uri);

    final Map<String, dynamic> values = jsonDecode(response.body);

    final String image = values["sprites"]["other"]["home"]["front_default"];
    _name = values["name"];
    _specie = values["species"]["name"];
    _weight = values["weight"].toString();
    _xp = values["base_experience"].toString();
    _img = image;
    _id = values["id"];
  }

  int get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get img {
    return _img;
  }

  Sprites get sprite {
    return _sprites;
  }

  String get xp {
    return _xp;
  }

  String get weight {
    return _weight;
  }

  String get specie {
    return _specie;
  }
}

class FetchPoke {
  final Uri uri;
  late String? _previousPage;
  late String? _nextPage;

  FetchPoke({required this.uri});

  String? get nextPage {
    return _nextPage;
  }

  String? get previousPage {
    return _previousPage;
  }

  Future<List<dynamic>> fetch() async {
    final response = await http.get(uri);

    final Map<String, dynamic> values = jsonDecode(response.body);
    _previousPage = values["previous"];
    _nextPage = values["next"];

    final List<dynamic> list = values["results"];
    return list;
  }
}
