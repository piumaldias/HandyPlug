import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hardware_app/pages/home/main_store_page.dart';
import 'package:hardware_app/pages/tools/tools_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static const String toolsDetail = "/tools-detail";

  static String getInitial() => '$initial';
  static String getToolsDetail(int pageId) => '$toolsDetail?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: "/", page: () => MainStorePage()),
    GetPage(
      name: toolsDetail,
      page: () {
        var pageId =Get.parameters['pageId'];
       return ToolsDetail(index: int.parse(pageId!));
      },
    )
  ];
}
