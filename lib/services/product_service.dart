import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  String id, titleProduct, description, category;
  double price;
  List images, sizes;

  ProductService.fromDocument(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.documentID;
    titleProduct = documentSnapshot.data["titleProduct"];
    description = documentSnapshot.data["description"];
    price = documentSnapshot.data["price"];
    images = documentSnapshot.data["imagePath"];
    sizes = documentSnapshot.data["sizes"];
  }

  Map<String, dynamic> toResumeMap() {
    return {"titleProduct": titleProduct, "price": price};
  }
}
