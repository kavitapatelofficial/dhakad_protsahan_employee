import 'package:flutter/material.dart';

import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/default_button.dart';

class RowHeadingText extends StatelessWidget {
  const RowHeadingText(
      {super.key,
      required this.title,
      required this.onpress,
      required this.btnText});
  final String title;
  final String btnText;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Texttheme.heading,
          ),
          SizedBox(
                  width: size.width * 0.25,
                  child: DefaultButton(
                      buttonText: btnText,
                      press: onpress,
                      buttonColor: AppColor.primaryColor))
             
        ],
      ),
    );
  }
}
