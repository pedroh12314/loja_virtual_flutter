import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/models/cart_model.dart';
import 'package:loja_virtual_nova/services/cart_service.dart';
import 'package:loja_virtual_nova/services/product_service.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct, {Key key}) : super(key: key);
  final CartProduct cartProduct;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: (cartProduct.product_data == null)
            ? FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("products")
                    .document(cartProduct.category)
                    .collection("items")
                    .document(cartProduct.product_id)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cartProduct.product_data =
                        ProductService.fromDocument(snapshot.data);
                    return _buildContent(context);
                  } else {
                    return Container(
                      height: 70.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                })
            : _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    CartModel.of(context).updatePrices();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 120.0,
          padding: EdgeInsets.all(8.0),
          child: Image.network(
            cartProduct.product_data.images[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cartProduct.product_data.titleProduct,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
              ),
              Text(
                "Tamanho: ${cartProduct.size}",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Text("R\$ ${cartProduct.product_data.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.blue,
                      onPressed: (cartProduct.quantity > 1)
                          ? () {
                              CartModel.of(context).decProduct(cartProduct);
                            }
                          : null),
                  Text(cartProduct.quantity.toString()),
                  IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.blue[300],
                      onPressed: () {
                        CartModel.of(context).incProduct(cartProduct);
                      }),
                  FlatButton(
                    onPressed: () {
                      CartModel.of(context).removeCartItem(cartProduct);
                    },
                    child: Text("Remover"),
                    textColor: Colors.red[200],
                  )
                ],
              )
            ],
          ),
        ))
      ],
    );
  }
}
