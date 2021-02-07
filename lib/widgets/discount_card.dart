import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/models/cart_model.dart';

class DiscountCart extends StatelessWidget {
  const DiscountCart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cumpom de desconto",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        leading: Icon(Icons.card_giftcard_sharp),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Digite seu cupom"),
              initialValue: CartModel.of(context).cumpomCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection("cupoms")
                    .document(text)
                    .get()
                    .then((value) {
                  if (value.data != null) {
                    CartModel.of(context).setCupom(text, value.data["percent"]);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Desconto de ${value.data["percent"]}% aplicado!"),
                      backgroundColor: Colors.green,
                    ));
                  } else {
                    CartModel.of(context).setCupom(null, 0);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Cupom não encontrado!"),
                      backgroundColor: Colors.red,
                    ));
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
