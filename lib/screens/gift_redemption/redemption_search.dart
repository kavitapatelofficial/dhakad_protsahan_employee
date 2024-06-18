import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_flutter/providers/gifts_provider.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/showdialog.dart';
import 'package:dashboard_flutter/widgets/user_profile_widget.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:provider/provider.dart';

class RedemptionSearch extends StatefulWidget {
  final String gId;
  final Map arguments;
  const RedemptionSearch({
    super.key,
    required this.gId,
    required this.arguments,
  });

  @override
  State<RedemptionSearch> createState() => _RedemptionSearchState();
}

class _RedemptionSearchState extends State<RedemptionSearch> {
  final TextEditingController search = TextEditingController();

  int quantity = 0;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  bool isLoading = false;

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
        appBar: CustomAppBar("Gift-Redemption"),
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
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  UserProfileData(
                    isShow: true,
                    name:
                        '${(widget.arguments['name']) == "null" ? "NA" : (widget.arguments['name'])}',
                    points:
                        '${(widget.arguments['points']) == "null" ? "NA" : (widget.arguments['points'])}',
                    phone:
                        '${(widget.arguments['number']) == "null" ? "NA" : (widget.arguments['number'])}',
                    cId:
                        '${(widget.arguments['cId']) == "null" ? "NA" : (widget.arguments['cId'])}',
                    alternateNumber:
                        '${(widget.arguments['number2']) == "null" ? "NA" : (widget.arguments['number2'])}',
                    address:
                        '${(widget.arguments['address']) == "null" ? "NA" : (widget.arguments['address'])}',
                  ),
                  const SizedBox(height: 15.0),
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
                                var product = provider.getGift.data![index];
                                return Card(
                                    elevation: 0.5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${product.name}",
                                                style: Texttheme.subheading,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Required Points - ${product.points}",
                                                style: Texttheme.subheading,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // quantity == 0
                                                  //     ?

                                                  GestureDetector(
                                                    onTap: () async {
                                                      // increaseQuantity();

                                                      var data = {
                                                        'contractor_id':
                                                            '${widget.gId}',
                                                        'gift_id':
                                                            '${product.id}'
                                                      };

                                                      var url = Endpoints
                                                          .addRedemption;

                                                      print(
                                                          "=========data=======$data===========");
                                                      print(
                                                          "=========url======$url===========");
                                                      final apiResponse =
                                                          await showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            FutureProgressDialog(
                                                                baseClient.post(
                                                          true,
                                                          Endpoints.baseUrl,
                                                          url,
                                                          data,
                                                        )),
                                                      );

                                                      var res = jsonDecode(
                                                          apiResponse);

                                                      if (res['success'] ==
                                                          true) {
                                                        setState(() {
                                                          widget.arguments[
                                                                  'points'] =
                                                              "${int.parse(widget.arguments['points']) - int.parse(product.points!)}";
                                                        });
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return CustomDialog(
                                                              success: true,
                                                              title:
                                                                  "Dialog Title",
                                                              content:
                                                                  "${res['message']}",
                                                            );
                                                          },
                                                        );
                                                        provider.fetchGifts();
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return CustomDialog(
                                                              success: false,
                                                              title:
                                                                  "Dialog Title",
                                                              content:
                                                                  "${res['message']}",
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: AppColor
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.add,
                                                            color: AppColor
                                                                .accentWhite,
                                                          ),
                                                          Text(
                                                            'Add ',
                                                            style: Texttheme
                                                                .subheading
                                                                .copyWith(
                                                                    color: AppColor
                                                                        .accentWhite),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                          Column(
                                            children: [
                                              CachedNetworkImage(
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.fill,
                                                imageUrl:
                                                    "${Endpoints.imageUrl}${product.image}",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColor.accentBgColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade200),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/images/placeholder.jpeg"),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                              }))
                ],
              ),
            );
          }
        }));
  }
}
