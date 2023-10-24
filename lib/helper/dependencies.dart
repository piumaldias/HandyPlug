import 'package:get/get.dart';
import 'package:hardware_app/controllers/popular_product_controller.dart';
import 'package:hardware_app/data/api/api_client.dart';
import 'package:hardware_app/data/repository/popular_product_repo.dart';

Future<void> init()async{

  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: "http://mvs.bslmeiyu.com"));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient:Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
}