class Product {
  String? _totalSize;
  String? _typeId;
  String? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;

  Product({totalSize, typeId, offset, products}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products!;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['product_list'] != null) {
      _products = <ProductModel>[];
      if (json['product_list'] is Map<String, dynamic>) {
        json['product_list'].values.forEach((productJson) {
          _products.add(ProductModel.fromJson(productJson));
        });
      }
    }
  }
  addfromJson(Map<String, dynamic> json) {
    products.add(ProductModel.fromJson(json));
  }
}

class ProductModel {
  String id;
  String name;
  String description ='';
  String price='';
  String stars='';
  String img='';
  String location='';
  String typeId='';
  String store='';



  ProductModel(
      this.id,
      this.name,
      this.description ,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.typeId,
      this.store);

/* ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    typeId = json['typeId'];
    store = json['store'];
  } */
  static ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
        json['id'],
        json['name'],
        json['description']?? '',
        json['price']?? '',
        json['stars']?? '',
        json['img']?? '',
        json['location']?? '',
        json['typeId']?? '',
        json['store']?? '');
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stars': stars,
      'img': img,
      'location': location,
      'typeId': typeId,
      'store': store,
    };
  }

}
