import 'package:cloud_firestore/cloud_firestore.dart';

class PopularProductRepo {
  Future<DocumentSnapshot> getPopularProductDoc() async {
    try {
      DocumentSnapshot popularProductsDoc =
      await FirebaseFirestore.instance.collection('products').doc('popular_product').get();
      return popularProductsDoc;
    } catch (e) {
      print("Error getting popular products: $e");
      throw e;
    }
  }
}

