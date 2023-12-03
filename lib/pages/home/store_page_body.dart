import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hardware_app/routes/route_helper.dart';

import 'package:hardware_app/utils/colors.dart';
import 'package:hardware_app/utils/dimensions.dart';
import 'package:hardware_app/widgets/app_column.dart';
import 'package:hardware_app/widgets/big_text.dart';
import 'package:hardware_app/widgets/icon_and_text_widget.dart';
import 'package:hardware_app/widgets/small_text.dart';

import '../../controllers/popular_product_controller.dart';

import '../../controllers/recomended_product_controller.dart';
import '../../models/products_model.dart';

class StorePageBody extends StatefulWidget {
  const StorePageBody({super.key});

  @override
  State<StorePageBody> createState() => _StorePageBodyState();
}

class _StorePageBodyState extends State<StorePageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currPageValue = 0.0;
  var _scaleFactor = 0.8;
  double _height = 220;

  final PopularProductService _popularService = PopularProductService();
  final RecomendedProductService _recomendedService =RecomendedProductService();
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [SizedBox(
            width: 30*Dimensions.atomicWidth,
            height: 40*Dimensions.atomicHeight,
          ),
            BigText(text: "Popular This week"),
          ],
        ),
        //slides section
        FutureBuilder(
          future: _popularService.getProductsFromPopularIds(),
          builder: (context, AsyncSnapshot<Product> snapshot) {
            if (snapshot.data == null) {
              // Handle the case when data is null
              return CircularProgressIndicator();
            } else {
              Product product = snapshot.data ??
                  Product(); // Use Product() or handle the case when data is null

              return Container(
                height: Dimensions.pageView,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: product.products
                      .length, // Since you have only one product in the snapshot
                  itemBuilder: (context, position) {
                    return _buildPageItem(position, product);
                  },
                ),
              );
            }
          },
        ),
        //dots
        FutureBuilder(
            future: _popularService.getProductsFromPopularIds(),
            builder: (context, AsyncSnapshot<Product> snapshot) {
              if (snapshot.data == null) {
                // Handle the case when data is null
                return Text('Loading');
              } else {
                Product product = snapshot.data ?? Product();
                return DotsIndicator(
                  dotsCount:
                      product.products.isEmpty ? 1 : product.products.length,
                  position: _currPageValue,
                  decorator: DotsDecorator(
                    activeColor: AppColors.mainColor,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                );
              }
            }),

        //Popular text
        SizedBox(
          height: Dimensions.height10,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            children: [
              BigText(text: "Recomended"),
              SizedBox(
                width: Dimensions.width10,
              ),
              SizedBox(
                width: Dimensions.width30,
              ),
              Container(
                child: SmallText(
                  text: "Top 10 Items of the week", //test branch
                ),
                margin: const EdgeInsets.only(bottom: 2),
              )
            ],
          ),
        ),
        FutureBuilder(
          future: _recomendedService.getProductsFromRecomendedIds(),
          builder: (context, AsyncSnapshot<Product> snapshot) {
            if (snapshot.data == null) {
              // Handle the case when data is null
              return CircularProgressIndicator();
            } else {
              Product product = snapshot.data ??
                  Product(); // Use Product() or handle the case when data is null

              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: product.products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getToolsDetail(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.atomicWidth * 10,
                            right: Dimensions.atomicWidth * 10,
                            bottom: Dimensions.atomicHeight * 10),
                        child: Row(
                          children: [
                            Container(
                              width: Dimensions.atomicHeight * 120,
                              height: Dimensions.atomicHeight * 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          product.products[index].img!))),
                            ),
                            Expanded(
                              child: Container(
                                height: Dimensions.atomicHeight * 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20)),
                                  color: Colors.white,
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: Dimensions.height15,
                                      left: 15,
                                      right: 15),
                                  child: AppColumnSmall(
                                      productList: product.products,
                                      index: index),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),

        //list of items in popular products
      ],
    );
  }

  Widget _buildPageItem(int index, Product popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      //matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      //matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = _scaleFactor;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getToolsDetail(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? Colors.blue : Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(popularProduct.products[index].img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.width30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0XFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularProduct.products[index].name!),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              int.parse(popularProduct.products[index].stars!),
                              (index) => Icon(Icons.star,
                                  color: AppColors.mainColor, size: 15)),
                        ),
                        SizedBox(
                          width: 30 * Dimensions.atomicWidth,
                        ),
                        SmallText(text: popularProduct.products[index].stars!),
                        SizedBox(
                          width: 30 * Dimensions.atomicWidth,
                        ),
                        Icon(Icons.shopping_bag_outlined,color: AppColors.iconColor1,size:Dimensions.atomicWidth*15,),
                        SizedBox(width: 2*Dimensions.atomicWidth,),
                        SmallText(text: popularProduct.products[index].store!),
                        SizedBox(
                          width: 30 * Dimensions.atomicWidth,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                            icon: Icons.attach_money,
                            text: popularProduct.products[index].price!,
                            iconColor: Colors.green),
                        IconAndTextWidget(
                            icon: Icons.location_pin,
                            text: "1.7km",
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            icon: Icons.timer_sharp,
                            text: "32min",
                            iconColor: AppColors.iconColor2)
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
