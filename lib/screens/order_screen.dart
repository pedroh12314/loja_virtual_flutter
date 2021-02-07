import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen(this.orderId, {Key key}) : super(key: key);

  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido Realizado!"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80.0,
            ),
            Text(
              "Pedido realizado com sucesso!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "o Código de seu pedido é $orderId.",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
