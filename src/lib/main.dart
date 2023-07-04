import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'core/services/infra/hive/adpter.dart';

late FToast fToast;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Hive.registerAdapter(PokemonAdapter());
  await Hive.initFlutter();
  await Hive.openBox<ModelPokemon>("poke");

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  FlutterNativeSplash.remove();
}
