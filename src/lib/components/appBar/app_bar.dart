// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.body,
    this.title,
    this.bottomNavigationBar,
  }) : super(key: key);

  final Widget body;
  final BottomAppBar? bottomNavigationBar;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Padding(
            padding: const EdgeInsets.only(right: 90),
            child: Center(
              child: Text(
                title ?? "App Pokemon",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          )),
      endDrawer: Drawer(
          shadowColor: Colors.green,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("Guarani sistemas")],
                  ),
                ),
                accountEmail: SizedBox(),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                currentAccountPictureSize: Size(280, 100),
                currentAccountPicture: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/74632138?v=4")),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.star, color: Colors.yellow),
                title: const Text('Favoritos'),
                onTap: () {
                  Modular.to.popAndPushNamed("/favorites");
                },
              ),
            ],
          )),
      body: body,
      backgroundColor: Colors.white70,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
