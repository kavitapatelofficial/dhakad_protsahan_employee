import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/default_button.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool success;

  CustomDialog(
      {required this.title, required this.content, required this.success});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: success ? AppColor.accentGreen : AppColor.neturalOrange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                success
                    ? Image.asset(
                        "assets/images/checkIcon.png",
                        height: 40,
                        width: 40,
                        color: AppColor.accentWhite,
                      )
                    : Image.asset(
                        "assets/images/error.png",
                        color: AppColor.accentWhite,
                        height: 40,
                        width: 40,
                        scale: 0.2,
                      ),
                      SizedBox(width: 10,),
                Text(
                   success
                    ?"Success":"Error",
                  style: TextStyle(
                    fontSize: 19,
                    color: AppColor.accentWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(content, style: Texttheme.subheading,textAlign: TextAlign.center,),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: (){
               Navigator.of(context).pop();
            },
            child: Container(
              width: 100,
              height: 40,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColor.accentLightGrey,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  'OK ',
                  style:
                      Texttheme.subheading.copyWith(color: AppColor.accentWhite),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
