import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hardware_app/utils/colors.dart';
import 'package:hardware_app/utils/dimensions.dart';
import 'package:hardware_app/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key,required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText =true;
  double textHeght =150*Dimensions.atomicHeight;

  @override
  void initState()  {
    super.initState();
    if(widget.text.length>textHeght){
      firstHalf = widget.text.substring(0,textHeght.toInt());
      secondHalf = widget.text.substring(textHeght.toInt()+1,widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(color: AppColors.paraColor,size:Dimensions.font16,text: firstHalf,overFlow: TextOverflow.visible):Column(
        children: [
          SmallText(height: 1.8,color: AppColors.paraColor,size:Dimensions.font16,overFlow: TextOverflow.visible,text: hiddenText?(firstHalf+"..."):(firstHalf+secondHalf),),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: (
            Row(
              children: [
                SmallText(text: "Show more",color: AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,)
              ],
            )
            ),
          )
        ],
      ),
    );
  }
}
