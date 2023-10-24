import 'package:get/get.dart';
import 'package:hardware_app/data/repository/popular_product_repo.dart';
import 'package:hardware_app/models/products_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController ({required this.popularProductRepo});
  List<dynamic> _popularProductList =[];
  List<dynamic> getpopularProductList() => _popularProductList;

  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    print("Done");
    print(response.statusText.toString());
    if (response.statusCode ==200){
      print("got products");
      _popularProductList =[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      update();
    }else{

    }
  }
}