import 'package:dashboard_flutter/providers/redemption_provider.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/gift_redemption_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GiftRedemptionView extends StatefulWidget {
  const GiftRedemptionView({super.key});

  @override
  State<GiftRedemptionView> createState() => _GiftRedemptionViewState();
}

class _GiftRedemptionViewState extends State<GiftRedemptionView> {
  RedemptionProvider? myProvider;

  BaseClient baseClient = BaseClient();

  @override
  void initState() {
    super.initState();

    // Call the provider using WidgetsBinding.instance!
    myProvider = Provider.of<RedemptionProvider>(context, listen: false);
    myProvider!.fetchRedemptions();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.accentBgColor,
        appBar: CustomAppBar("Gift Redemption"),
        body: Consumer<RedemptionProvider>(builder: (context, provider, child) {
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
                // RowHeadingText(
                //     title: "Gift Redemptions",
                //     onpress: () {
                //       Navigator.pushNamed(
                //         context,
                //         '/add-gift-redemption',
                //         arguments: {
                //           'title': 'Add Gift Redemption',
                //           "isEdit": false,
                //         },
                //       );
                //     },
                //     btnText: "Add"),
                provider.getRedemption.data!.isEmpty
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
                            itemCount: provider.getRedemption.data!.length,
                            itemBuilder: (context, index) {
                              var data=provider.getRedemption.data![index];
                              return GiftRedemptionCard(
                                contractorName: "${data.contractor!.name}",
                                productName: "${data.gift!.name}",
                                points: "${data.gift!.points}",
                                quantity: "${data.gift!.price}",
                                onEditPressed: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   '/add-gift-redemption',
                                  //   arguments: {
                                  //     'title': 'Edit Gift Redemption',
                                  //     "isEdit": true,
                                  //     "cName": "Kavita Patel $index",
                                  //     "pName": "Product $index",
                                  //     "points": "50$index",
                                  //     "quantity": "70$index",
                                  //     "id": "1",
                                  //   },
                                  // );
                                },
                              );
                            }))
              ]),
            );
          }
        }));
  }
}
