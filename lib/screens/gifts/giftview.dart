import 'dart:convert';

import 'package:dashboard_flutter/providers/gifts_provider.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/delete_widget.dart';

import 'package:dashboard_flutter/widgets/gift_card.dart';
import 'package:dashboard_flutter/widgets/row_headint_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:provider/provider.dart';

class GiftsVewScreen extends StatefulWidget {
  @override
  State<GiftsVewScreen> createState() => _GiftsVewScreenState();
}

class _GiftsVewScreenState extends State<GiftsVewScreen> {
  GiftProvider? myProvider;
  BaseClient baseClient = BaseClient();
  @override
  void initState() {
    super.initState();

    // Call the provider using WidgetsBinding.instance!
    myProvider = Provider.of<GiftProvider>(context, listen: false);
    myProvider!.fetchGifts();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.accentBgColor,
        appBar: CustomAppBar("Gifts"),
        body: Consumer<GiftProvider>(builder: (context, provider, child) {
          if (provider.isLoading) {
            return SizedBox(
              height: size.height,
              width: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SizedBox(
              height: size.height,
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: RowHeadingText(
                          title: "Gifts List",
                          onpress: () {
                            Navigator.pushNamed(
                              context,
                              '/add-gift',
                              arguments: {
                                'title': 'Add Gifts',
                                "isEdit": false,
                              },
                            );
                          },
                          btnText: "Add"),
                    ),
                  ],
                ),
                provider.getGift.data!.isEmpty
                    ? const SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Center(
                          child: Text("No Data Found"),
                        ),
                      )
                    : Flexible(
                        flex: 1,
                        child: ListView.builder(
                            itemCount: provider.getGift.data!.length,
                            itemBuilder: (context, index) {
                              var gifts = provider.getGift.data![index];
                              return GiftsCard(
                                name: "${gifts.name}",
                                price: "${gifts.price}",
                                points: "${gifts.points}",
                                onEditpress: () {
                                  Navigator.pushNamed(context, '/add-gift',
                                      arguments: {
                                        'title': 'Edit Gift',
                                        "isEdit": true,
                                        "name": "${gifts.name}",
                                        "id": "${gifts.id}",
                                        "points": "${gifts.points}",
                                        "desc": "${gifts.description}",
                                        "price": "${gifts.price}",
                                        "image": '${gifts.image}'
                                      });
                                },
                                onDeletepress: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        DeleteConfirmationDialog(
                                      message:
                                          "Are you sure you want to delete this ?",
                                      onConfirm: () async {
                                          var url = Endpoints.delete +
                                      "type=gift&id=${gifts.id}";
    
                                  print("=========url======$url===========");
                                  final apiResponse = await showDialog(
                                    context: context,
                                    builder: (context) =>
                                        FutureProgressDialog(baseClient.get(
                                      true,
                                      Endpoints.baseUrl,
                                      url,
                                    )),
                                  );
    
                                  var res = jsonDecode(apiResponse);
    
                                  if (res['success'] == true) {
                                    provider.fetchGifts();
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "${res['message']}",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: AppColor.neturalRed,
                                      textColor: Colors.white,
                                    );
                                  }
                                      },
                                    ),
                                  );
                                },
                                image: '${Endpoints.imageUrl}${gifts.image}',
                              );
                            }))
              ]),
            );
          }
        }));
  }
}
