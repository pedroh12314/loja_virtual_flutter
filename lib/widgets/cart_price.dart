import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  CartPrice(this.buy, {Key key}) : super(key: key);

  final VoidCallback buy;
  double price = 0.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            price = model.getProductsPrice();
            double discount = model.getDiscount();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Resumo do pedido",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal"),
                    Text("R\$ ${price.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Desconto"),
                    Text(
                        "R\$ ${(discount > 0) ? "-" : ""}${discount.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "R\$ ${(price - discount).toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                RaisedButton(
                  onPressed: buy,
                  child: Text("Finalizar pedido"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
