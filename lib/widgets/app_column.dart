import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hardware_app/widgets/small_text.dart';

import '../models/products_model.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final int index ;
  List<ProductModel> productList;
  AppColumn({super.key,required this.index,required this.productList});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: productList[index].name!,
          overFlow: TextOverflow.ellipsis,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),

        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 40,
              child: IconAndTextWidgetBig(
                  icon: Icons.shopping_bag_outlined,
                  text: productList[index].store!,
                  iconColor: AppColors.iconColor1),
            ),
            Flexible(
              flex: 40,
              child: IconAndTextWidgetBig(
                  icon: Icons.location_pin,
                  text: productList[index].location!,
                  iconColor: AppColors.mainColor),
            ),
            Flexible(
              flex: 20,
              child: IconAndTextWidgetBig(
                  icon: Icons.attach_money,
                  text: productList[index].price!,
                  iconColor: AppColors.iconColor2),
            )
          ],
        )
      ],
    );
  }
}
class AppColumnSmall extends StatelessWidget {
  final int index ;
  List<ProductModel> productList;
  AppColumnSmall({super.key,required this.index,required this.productList});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: productList[index].name!,
          overFlow: TextOverflow.ellipsis,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        SmallText(
            text:
            productList[index].description!),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150*Dimensions.atomicWidth,
              child:Row(
                children: [
                  Icon(Icons.shopping_bag_outlined,color:  AppColors.iconColor1,size:Dimensions.atomicWidth*15,),
                  SizedBox(width: 5*Dimensions.atomicWidth,),
                  SmallText(text: productList[index].store!,overFlow:TextOverflow.clip ,size: Dimensions.atomicWidth*12,),
                ]
                ,
              )

              /*
              IconAndTextWidget(

                  icon: Icons.location_pin,
                  text: productList[index].store!,
                  iconColor: AppColors.mainColor)
              */
              ,
            ),

            Expanded(
              child: IconAndTextWidget(
                  icon: Icons.attach_money,
                  text: productList[index].price!,
                  iconColor: Colors.green),
            )
          ],
        )
      ],
    );
  }
}