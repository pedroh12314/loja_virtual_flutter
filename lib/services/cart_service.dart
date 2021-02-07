import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_nova/services/product_service.dart';

class CartProduct {
  CartProduct();
  // ignore: non_constant_identifier_names
  String cart_id;
  // ignore: non_constant_identifier_names
  String product_id;
  // ignore: non_constant_identifier_names
  ProductService product_data;
  String category;
  String size;
  int quantity;
  CartProduct.fromDocument(DocumentSnapshot document) {
    cart_id = document.documentID;
    category = document.data["category"];
    product_id = document.data["product_id"];
    quantity = document.data["quantity"];
    size = document.data["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "product_id": product_id,
      "quantity": quantity,
      "size": size,
      "product": product_data.toResumeMap()
    };
  }
}
