import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/models/cart_model.dart';
import 'package:loja_virtual_nova/models/user_model.dart';
import 'package:loja_virtual_nova/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Loja de Roupas",
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Color.fromARGB(255, 211, 100, 80),
              ),
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
