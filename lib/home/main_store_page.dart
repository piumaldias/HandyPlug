import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hardware_app/home/store_page_body.dart';
import 'package:hardware_app/utils/dimensions.dart';
import 'package:hardware_app/widgets/big_text.dart';
import 'package:hardware_app/widgets/small_text.dart';

import '../utils/colors.dart';

class MainStorePage extends StatefulWidget {
  const MainStorePage({super.key});

  @override
  State<MainStorePage> createState() => _MainStorePageState();
}

class _MainStorePageState extends State<MainStorePage> {
  @override
  Widget build(BuildContext context) {
    print("Current height is "+MediaQuery.of(context).size.height.toString());
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text:"Country",color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text:"Colombo",color:Colors.black54),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: Icon(Icons.search,color: Colors.white,size:Dimensions.iconSize24,),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor

                    ),
                  )
                ],
              ),
            ),
          ),
          StorePageBody(),
        ],
      ),
    );
  }
}
