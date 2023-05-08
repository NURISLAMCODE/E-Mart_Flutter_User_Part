import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class FirestoreServices {
  //get user data
  // static getUser(uid) {
  //   return firestore
  //       .collection(ussersCollections)
  //       .where('id', isEqualTo: uid)
  //       .snapshots();
  // }
  static getUser(id) {
    return firestore.collection(ussersCollections).where('id').snapshots();
  }

  //get products according to category
  static getProducts(category) {
    return firestore
        .collection(poroductCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getSubCategoryProducts(title) {
    return firestore
        .collection(poroductCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }

  //get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //delete document
  static deleteCDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //get all chat message
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messageCollextion)
        .orderBy("created_on", descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestore
        .collection(poroductCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(poroductCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  static allproducts() {
    return firestore.collection(poroductCollection).snapshots();
  }

  //get featured products method
  static getFeaturedProduct() {
    return firestore
        .collection(poroductCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

//search home page
  static searchProducts(title) {
    return firestore
        .collection(poroductCollection)
        .where('p_name', isLessThanOrEqualTo: title)
        .get();
  }
}
