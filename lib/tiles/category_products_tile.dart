import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/screens/products_screen.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(this.document, {Key key}) : super(key: key);

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(document.data["icon"]),
      ),
      title: Text(document.data["titleCategory"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductsScreen(document)));
      },
    );
  }
}
