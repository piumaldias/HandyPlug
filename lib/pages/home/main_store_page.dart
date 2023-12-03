import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hardware_app/pages/home/store_page_body.dart';
import 'package:hardware_app/utils/dimensions.dart';
import 'package:hardware_app/widgets/big_text.dart';
import 'package:hardware_app/widgets/small_text.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../location/locate.dart';

class MainStorePage extends StatefulWidget {
  const MainStorePage({super.key});

  @override
  State<MainStorePage> createState() => _MainStorePageState();
}

class _MainStorePageState extends State<MainStorePage> {
  String locationText = "Colombo";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: "Set Location", color: AppColors.mainColor),
                      GestureDetector(
                        onTap: () async {
                          Place selectedLocation = await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return GetLocation(
                                onLocationSelected: (Place place) {
                                  setState(() {
                                    locationText = place.description;
                                  });
                                },
                              );
                            },
                          );

                          if (selectedLocation != null) {
                            setState(() {
                              locationText = selectedLocation.description;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            SmallText(text: locationText, color: Colors.black54),
                            Icon(Icons.location_pin,size: 13,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getSearch());
                      },
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.mainColor),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: StorePageBody(),
          ))
        ],
      ),
    );
  }
}
