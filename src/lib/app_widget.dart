import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Smart App',
      builder: (context, widget) {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              fToast = FToast();
              fToast.init(context);
              return widget ?? Container();
            })
          ],
        );
      },
      theme: ThemeData(primarySwatch: Colors.green),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension
  }
}
