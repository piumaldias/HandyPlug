import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hardware_app/models/products_model.dart';

class RecomendedProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Product _recomendedProduct;
  Product get recomendedProduct => _recomendedProduct;

  Future<List<String>> getRecomendedProductIds() async {
    try {
      // Replace 'products' with your actual collection name
      DocumentSnapshot<Map<String, dynamic>> recomendedProductsDoc =
      await _firestore.collection('products').doc('recomended_products').get();

      // Assuming 'product_list' is the field containing the IDs in the 'recomended_products' document
      Map<String, dynamic> productMap =
          recomendedProductsDoc['product_list'] ?? [];

      List<String> productList = productMap.values
          .map((entry) => entry['id']?.toString() ?? '')
          .toList();
      return productList;
    } catch (e) {
      print('Error fetching recomended product IDs: $e');
      throw e;
    }
  }

  Future<Product> getProductsFromRecomendedIds() async {
    try {
      List<String> recomendedProductIds = await getRecomendedProductIds();
      List<ProductModel>  productList =[];
      for (String productId in recomendedProductIds) {
        // Replace 'products' with your actual collection name
        QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection('products')
            .doc('all_products')
            .collection('product_list')
            .where('id', isEqualTo: productId)
            .get();

        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          Map<String, dynamic> dataMap = doc.data() ?? {};
          productList.add(ProductModel.fromJson(dataMap));
        }
      }
      _recomendedProduct = Product(totalSize: recomendedProductIds.length.toString(),offset: '0',typeId: '1',products: productList);
      return _recomendedProduct;
    } catch (e2) {
      print('Error fetching products from recomended product IDs: $e2');
      rethrow;
    }
  }
}
