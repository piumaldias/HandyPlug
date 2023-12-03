import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hardware_app/models/products_model.dart';

class PopularProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Product _popularProduct;
  Product get popularProduct => _popularProduct;

  Future<List<String>> getPopularProductIds() async {
    try {

      DocumentSnapshot<Map<String, dynamic>> popularProductsDoc =
          await _firestore.collection('products').doc('popular_product').get();

      Map<String, dynamic> productMap =
          popularProductsDoc['product_list'] ?? [];

      List<String> productList = productMap.values
          .map((entry) => entry['id']?.toString() ?? '')
          .toList();
      return productList;
    } catch (e) {
      print('Error fetching popular product IDs: $e');
      throw e;
    }
  }

  Future<Product> getProductsFromPopularIds() async {
    try {
      List<String> popularProductIds = await getPopularProductIds();
      List<ProductModel>  productList =[];
      for (String productId in popularProductIds) {

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
      _popularProduct = Product(totalSize: popularProductIds.length.toString(),offset: '0',typeId: '1',products: productList);
      return _popularProduct;
    } catch (e2) {
      print('Error fetching products from popular product IDs: $e2');
      rethrow;
    }
  }
}
