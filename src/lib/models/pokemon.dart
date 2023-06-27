import 'package:hive/hive.dart';

@HiveType(typeId: 32)
class ModelPokemon extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String img;
  @HiveField(3)
  late String gradient;
  @HiveField(4)
  late bool isFavorite;
  @HiveField(5)
  late String weight;
  @HiveField(6)
  late String xp;
  @HiveField(7)
  late String specie;

  ModelPokemon(
      {required this.id,
      required this.name,
      required this.img,
      required this.gradient,
      required this.isFavorite,
      required this.weight,
      required this.xp,
      required this.specie});

  int get _id {
    return id;
  }

  String get _name {
    return name;
  }

  String get _img {
    return img;
  }

  String get _xp {
    return xp;
  }

  String get _weight {
    return weight;
  }

  get _specie {
    return specie;
  }
}

class PokemonAdapter extends TypeAdapter<ModelPokemon> {
  @override
  final typeId = 1;

  @override
  ModelPokemon read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var pokemon = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return ModelPokemon(
      id: pokemon[0] as int,
      name: pokemon[1] as String,
      weight: pokemon[5] as String,
      img: pokemon[2] as String,
      gradient: pokemon[3] as String,
      isFavorite: pokemon[4] as bool,
      xp: pokemon[6] as String,
      specie: pokemon[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ModelPokemon obj) {
    // writer.write(obj);
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.gradient)
      ..writeByte(4)
      ..write(obj.isFavorite)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.xp)
      ..writeByte(7)
      ..write(obj.specie);
  }
}
