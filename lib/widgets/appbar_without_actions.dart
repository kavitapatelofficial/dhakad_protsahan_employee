import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  CustomAppBar(
    this.title, {
    Key? key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      iconTheme: IconThemeData(color: AppColor.defaultBlackColor),
      backgroundColor: AppColor.accentWhite,
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: Texttheme.heading,
      ),
    );
  }
}
