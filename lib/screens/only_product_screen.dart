import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/models/cart_model.dart';
import 'package:loja_virtual_nova/models/user_model.dart';
import 'package:loja_virtual_nova/screens/cart_screen.dart';
import 'package:loja_virtual_nova/screens/login_screen.dart';
import 'package:loja_virtual_nova/services/cart_service.dart';
import 'package:loja_virtual_nova/services/product_service.dart';

class OnlyProductScreen extends StatefulWidget {
  OnlyProductScreen(this.data, {Key key}) : super(key: key);

  final ProductService data;

  @override
  _OnlyProductScreenState createState() => _OnlyProductScreenState(data);
}

class _OnlyProductScreenState extends State<OnlyProductScreen> {
  final ProductService data;

  _OnlyProductScreenState(this.data);

  String selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.titleProduct),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: data.images.map((url) => NetworkImage(url)).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: Theme.of(context).primaryColor,
              autoplay: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  data.titleProduct,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${data.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  data.description,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: data.sizes
                        .map((size) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = size;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(
                                        color: (selectedSize == size)
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                        width: 1.5)),
                                width: 50.0,
                                alignment: Alignment.center,
                                child: Text(size),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: (selectedSize != null)
                        ? () {
                            if (UserModel.of(context).isLognIn()) {
                              CartProduct cartProduct = new CartProduct();
                              cartProduct.size = selectedSize;
                              cartProduct.quantity = 1;
                              cartProduct.product_id = data.id;
                              cartProduct.category = data.category;
                              cartProduct.product_data = data;

                              CartModel.of(context).addCartItem(cartProduct);

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Você adiconou esse item com sucesso"),
                                      content: Text(
                                          "Gostaria de ir para a página do carrinho?"),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Ficar")),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CartScreen()));
                                            },
                                            child: Text("Ir")),
                                      ],
                                    );
                                  });
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLognIn()
                          ? "Adicionar ao Carrinho"
                          : "Entre para Comprar",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
