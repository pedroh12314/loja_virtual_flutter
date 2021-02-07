import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/models/cart_model.dart';
import 'package:loja_virtual_nova/models/user_model.dart';
import 'package:loja_virtual_nova/screens/login_screen.dart';
import 'package:loja_virtual_nova/screens/order_screen.dart';
import 'package:loja_virtual_nova/tiles/cart_tile.dart';
import 'package:loja_virtual_nova/widgets/cart_price.dart';
import 'package:loja_virtual_nova/widgets/discount_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 10.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int qnt = model.products.length;
                return Text("${qnt ?? 0} ${qnt == 1 ? "ITEM" : "ITENS"}");
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLognIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!UserModel.of(context).isLognIn()) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    color: Theme.of(context).primaryColor,
                    size: 80.0,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Faça o login para adicionar seus produtos ao carrinho...",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 36.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            );
          } else if (model.products.isEmpty || model.products.length == 0) {
            return Container(
                padding: EdgeInsets.all(25.0),
                child: Center(
                  child: Text(
                    "Nenhum produto adicionado ao carrinho...",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ));
          } else {
            return ListView(
              children: [
                Column(
                  children: model.products
                      .map((product) => CartTile(product))
                      .toList(),
                ),
                DiscountCart(),
                CartPrice(() async {
                  String orderId = await model.finishOrder();
                  if (orderId != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OrderScreen(orderId)));
                  }
                })
              ],
            );
          }
        },
      ),
    );
  }
}
