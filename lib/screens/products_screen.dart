import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/services/product_service.dart';
import 'package:loja_virtual_nova/tiles/product_tile.dart';
import 'package:loja_virtual_nova/widgets/cart_button.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen(this.document, {Key key}) : super(key: key);

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: CartButton(),
          appBar: AppBar(
            title: Text(document.data["titleCategory"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection("products")
                .document(document.documentID)
                .collection("items")
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else
                return TabBarView(children: [
                  GridView.builder(
                      padding: EdgeInsets.all(4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        ProductService data = ProductService.fromDocument(
                            snapshot.data.documents[index]);
                        data.category = this.document.documentID;
                        return ProductTile("grid", data);
                      }),
                  ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        ProductService data = ProductService.fromDocument(
                            snapshot.data.documents[index]);
                        data.category = this.document.documentID;
                        return ProductTile("list", data);
                      })
                ]);
            },
          ),
        ));
  }
}
