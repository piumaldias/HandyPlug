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
        SmallText(
            text:
        productList[index].description!),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconAndTextWidget(
                  icon: Icons.circle_sharp,
                  text: productList[index].store!,
                  iconColor: AppColors.iconColor1),
            ),
            Expanded(
              child: IconAndTextWidget(
                  icon: Icons.location_pin,
                  text: productList[index].location!,
                  iconColor: AppColors.mainColor),
            ),
            Expanded(
              child: IconAndTextWidget(
                  icon: Icons.timer_sharp,
                  text: productList[index].price!,
                  iconColor: AppColors.iconColor2),
            )
          ],
        )
      ],
    );
  }
}
