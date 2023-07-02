import 'package:hive/hive.dart';

@HiveType(typeId: 32)
class ModelPokemon extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String weight;
  @HiveField(3)
  late String base_exprecience;
  @HiveField(4)
  late String specie;

  ModelPokemon(
      {required this.id,
      required this.name,
      required this.weight,
      required this.base_exprecience,
      required this.specie});
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
      weight: pokemon[2] as String,
      base_exprecience: pokemon[3] as String,
      specie: pokemon[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ModelPokemon obj) {
    // writer.write(obj);
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.base_exprecience)
      ..writeByte(4)
      ..write(obj.specie);
  }
}
