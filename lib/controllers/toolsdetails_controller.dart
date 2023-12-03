import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hardware_app/models/products_model.dart';

class DetailsProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProductModel> getDetailsFromProductsIds(String productId) async {
    try {

     // ProductModel  detailedProduct = ProductModel();

        // Replace 'products' with your actual collection name
        QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection('products')
            .doc('all_products')
            .collection('product_list')
            .where('id', isEqualTo: productId)
            .get();

          Map<String, dynamic> dataMap = snapshot.docs.first.data() ?? {};
        ProductModel detailedProduct=ProductModel.fromJson(dataMap);


      return detailedProduct;
    } catch (e2) {
      print('Error fetching products from Details product IDs: $e2');
      rethrow;
    }
  }
}
