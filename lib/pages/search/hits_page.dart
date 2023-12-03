import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

import '../../models/products_model.dart';

class HitsPage {
  const HitsPage(this.items, this.pageKey, this.nextPageKey);

  final List<ProductModel> items;
  final int pageKey;
  final int? nextPageKey;

  factory HitsPage.fromResponse(SearchResponse response) {
    final items = response.hits.map(ProductModel.fromJson).toList();
    final isLastPage = response.page >= response.nbPages;
    final nextPageKey = isLastPage ? null : response.page + 1;
    return HitsPage(items, response.page, nextPageKey);
  }
}
