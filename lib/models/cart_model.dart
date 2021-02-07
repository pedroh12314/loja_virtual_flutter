import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_nova/models/user_model.dart';
import 'package:loja_virtual_nova/services/cart_service.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<CartProduct> products = [];
  UserModel user;
  String cumpomCode;
  int discount = 0;

  CartModel(this.user) {
    if (user.isLognIn()) _loadAllItems();
  }

  bool isLoading = false;

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cart_id)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cart_id)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cart_id = doc.documentID;
    });
    products.add(cartProduct);
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cart_id)
        .delete();
    products.remove(cartProduct);
    notifyListeners();
  }

  void _loadAllItems() async {
    QuerySnapshot data = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();
    products = data.documents.map((e) => CartProduct.fromDocument(e)).toList();
    notifyListeners();
  }

  void setCupom(String cupomCode, int discount) {
    this.cumpomCode = cumpomCode;
    this.discount = discount;
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct prod in products) {
      if (prod != null) price += prod.quantity * prod.product_data.price;
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discount / 100;
  }

  void updatePrices() {
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null;
    isLoading = true;
    notifyListeners();
    double productsPrice = getProductsPrice();
    double discountPrice = getDiscount();

    DocumentReference refOrder =
        await Firestore.instance.collection("orders").add({
      "clienteID": user.firebaseUser.uid,
      "products": products.map((e) => e.toMap()).toList(),
      "productsPrice": productsPrice,
      "discount": discount,
      "totalPrice": productsPrice - discountPrice,
      "status": 1
    });
    await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("orders")
        .document(refOrder.documentID)
        .setData({"orderId": refOrder.documentID});

    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    for (DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }

    products.clear();
    discount = 0;
    cumpomCode = null;
    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }
}
