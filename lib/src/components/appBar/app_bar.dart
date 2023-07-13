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
        centerTitle: true,
        leadingWidth: 80,
        automaticallyImplyLeading: false,
        primary: true,
        leading: Builder(builder: (context) {
          final shouldBeAppearArrowReturn =
              Modular.to.canPop() && !Scaffold.of(context).isEndDrawerOpen;

          if (shouldBeAppearArrowReturn) {
            return IconButton(
              onPressed: () {
                Modular.to.pop();
              },
              icon: const Icon(Icons.arrow_back),
            );
          }
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://media.licdn.com/dms/image/C4D0BAQFpjwdvGxJuTg/company-logo_200_200/0/1638359007014?e=2147483647&v=beta&t=-q_JJw95LcfsFFbd-OgVMImb2qTi6BF795hPTyHVeXs",
              ),
            ),
          );
        }),
        backgroundColor: Colors.green,
        title: Text(
          title ?? "App Pokemon",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      endDrawer: Drawer(
          width: 290,
          clipBehavior: Clip.none,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          filterQuality: FilterQuality.high,
                          repeat: ImageRepeat.noRepeat,
                          image: AssetImage(
                            "assets/images/drawer_header.jpg",
                          )),
                    )),
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
