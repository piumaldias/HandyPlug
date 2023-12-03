import 'package:flutter/cupertino.dart';
import 'package:hardware_app/widgets/small_text.dart';

import '../utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;

  const IconAndTextWidget({super.key,
    required this.icon,
    required this.text,
    required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 80*Dimensions.atomicWidth,
      child: Row(
        children: [
          Icon(icon,color: iconColor,size:Dimensions.atomicWidth*15,),
          SizedBox(width: 5*Dimensions.atomicWidth,),
          SmallText(text: text,overFlow:TextOverflow.clip ,size: Dimensions.atomicWidth*12,),

        ]
        ,
      ),
    );
  }
}
class IconAndTextWidgetBig extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;

  const IconAndTextWidgetBig({super.key,
    required this.icon,
    required this.text,
    required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 80*Dimensions.atomicWidth,
      child: Wrap(
        children: [
          Icon(icon,color: iconColor,size:Dimensions.atomicWidth*20,),
          SizedBox(width: 5*Dimensions.atomicWidth,),
          SmallText(text: text,overFlow:TextOverflow.clip ,size: Dimensions.atomicWidth*16,color: CupertinoColors.black,),

        ]
        ,
      ),
    );
  }
}
