import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/default_button.dart';
import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;

  DeleteConfirmationDialog({
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Confirm Delete",
        style: Texttheme.subheading,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Text(message),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: <Widget>[
        SizedBox(
            height: 40,
            width: 110,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DefaultButton(
                  buttonText: "Cancle",
                  press: () {
                    Navigator.of(context).pop();
                  },
                  buttonColor: AppColor.primaryColor),
            )),
              
        SizedBox(
            height: 40,
            width: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DefaultButton(
                  buttonText: "Delete",
                  press: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  buttonColor: AppColor.neturalRed),
            ))
      ],
    );
  }
}
