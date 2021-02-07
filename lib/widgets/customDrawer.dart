import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/models/user_model.dart';
import 'package:loja_virtual_nova/screens/login_screen.dart';
import 'package:loja_virtual_nova/tiles/Drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(this.pageController, {Key key}) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(125, 203, 118, 130),
            Color.fromARGB(38, 203, 118, 130)
          ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
        );

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(top: 10.0, left: 32.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Loja de\nRoupas",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          print(model.isLoading);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Olá! ${!model.isLognIn() ? "" : model.userData["name"]}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Text(
                                  (!model.isLognIn())
                                      ? "Entre ou Cadastre-se..."
                                      : "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  (!model.isLognIn())
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()))
                                      : model.signOut();
                                },
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(0, pageController, Icons.home, "Início"),
              DrawerTile(1, pageController, Icons.list, "Produtos"),
              DrawerTile(2, pageController, Icons.location_on, "Nossas Lojas"),
              DrawerTile(
                  3, pageController, Icons.playlist_add_check, "Meus Pedidos")
            ],
          )
        ],
      ),
    );
  }
}
