import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class TermsandCondtions extends StatefulWidget {
  @override
  State<TermsandCondtions> createState() => _TermsandCondtionsState();
}

class _TermsandCondtionsState extends State<TermsandCondtions> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(color: AppColor.defaultBlackColor),
        backgroundColor: AppColor.accentWhite,
        automaticallyImplyLeading: true,
        title: Text("Terms and Conditions",style: Texttheme.heading,),
      ),
      url: Endpoints.aboutUs,
    );
  }
}
