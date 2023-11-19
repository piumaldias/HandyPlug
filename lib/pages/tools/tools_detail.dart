import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hardware_app/pages/home/main_store_page.dart';
import 'package:hardware_app/routes/route_helper.dart';
import 'package:hardware_app/utils/dimensions.dart';
import 'package:hardware_app/widgets/app_column.dart';
import 'package:hardware_app/widgets/app_icon.dart';
import 'package:hardware_app/widgets/expandable_text_widget.dart';

import '../../controllers/toolsdetails_controller.dart';
import '../../models/products_model.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';


class ToolsDetail extends StatelessWidget {
  final int index;


  ToolsDetail({super.key, required this.index});
  DetailsProductService productDetail = DetailsProductService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: productDetail.getDetailsFromProductsIds((index+1).toString()),
      builder: (context, AsyncSnapshot<ProductModel> snapshot) {
        if (snapshot.data == null) {
          // Handle the case when data is null
          return CircularProgressIndicator();
        } else {
          ProductModel product = snapshot.data ??
              ProductModel(); // Use Product() or handle the case when data is null

          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.toNamed((RouteHelper.getInitial()));
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back_ios,
                          )),
                      AppIcon(icon: Icons.shopping_cart_outlined)
                    ],
                  ),
                  bottom: PreferredSize(
                    preferredSize:
                        Size.fromHeight(120 * Dimensions.atomicHeight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20),
                            topRight: Radius.circular(Dimensions.radius20)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          top: Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppColumn(productList: [product], index: 0),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          BigText(text: "Description"),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 400 * Dimensions.atomicHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      width: Dimensions.atomicHeight * 120,
                      height: Dimensions.atomicHeight * 120,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white38,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(product.img!))),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height20),
                    child: ExpandableTextWidget(
                        text:
                            "Hammer is a great thing. This is very usaful. Buy hammer Buy hammer Buy hammer Buy hammerBuy hammerBuy hammer Buy hammerBuy hammerBuy hammerBuy hammerBuy hammer .Hammer is a great thing. This is very usaful. Buy hammer Buy hammer Buy hammer Buy hammerBuy hammerBuy hammer Buy hammerBuy hammerBuy hammerBuy hammerBuy hammer .Hammer is a great thing. This is very usaful. Buy hammer Buy hammer Buy hammer Buy hammerBuy hammerBuy hammer Buy hammerBuy hammerBuy hammerBuy hammerBuy hammer .Hammer is a great thing. This is very usaful. Buy hammer Buy hammer Buy hammer Buy hammerBuy hammerBuy hammer Buy hammerBuy hammerBuy hammerBuy hammerBuy hammer .Hammer is a great thing. This is very usaful. Buy hammer Buy hammer Buy hammer Buy hammerBuy hammerBuy hammer Buy hammerBuy hammerBuy hammerBuy hammerBuy hammer"),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10,
                        bottom: Dimensions.height10,
                        left: Dimensions.width10,
                        right: Dimensions.width10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          (Icons.remove),
                          color: AppColors.signColor,
                        ),
                        SizedBox(width: Dimensions.width10 / 2),
                        BigText(text: "0"),
                        SizedBox(width: Dimensions.width10 / 2),
                        Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width10,
                          right: Dimensions.width10),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: Row(children: [
                        BigText(
                          text: "\$10",
                          color: Colors.white,
                        ),
                        SizedBox(width: Dimensions.width10 / 2),
                        BigText(text: "Add to cart", color: Colors.white)
                      ]))
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
