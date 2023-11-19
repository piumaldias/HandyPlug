import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hardware_app/models/products_model.dart';

class ProductController{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _productReference = FirebaseFirestore.instance.collection('product_db');


  Future<Map<String, dynamic>> particularItem(String productId) async {

    final QuerySnapshot querySnapshot = await _firestore.collection("product_db")
        .where("productId", isEqualTo: productId)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot doc = querySnapshot.docs.first;
      final data = doc.data() as Map<String, dynamic>;
      ProductModel  Item = ProductModel.fromJson(data);
      return data;
    } else {
      return {"message": "Document with product ID not found."};
    }

  }
}