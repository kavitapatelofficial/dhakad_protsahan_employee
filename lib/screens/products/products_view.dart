import 'dart:convert';

import 'package:dashboard_flutter/providers/products_provider.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/delete_widget.dart';
import 'package:flutter/material.dart';

import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/product.dart';

import 'package:dashboard_flutter/widgets/row_headint_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductProvider? myProvider;
  BaseClient baseClient = BaseClient();

  @override
  void initState() {
    super.initState();

    // Call the provider using WidgetsBinding.instance!
    myProvider = Provider.of<ProductProvider>(context, listen: false);
    myProvider!.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.accentBgColor,
        appBar: CustomAppBar("Our Products"),
        body: Consumer<ProductProvider>(builder: (context, provider, child) {
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
                          title: "Product List",
                          onpress: () {
                            Navigator.pushNamed(
                              context,
                              '/add-product',
                              arguments: {
                                'title': 'Add Product',
                                "isEdit": false,
                              },
                            );
                          },
                          btnText: "Add"),
                    ),
                  ],
                ),
                provider.getProduct!.data!.isEmpty
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
                            itemCount: provider.getProduct!.data!.length,
                            itemBuilder: (context, index) {
                              var data = provider.getProduct!.data![index];
                              return ProductsCard(
                                name: "${data.productName}",
                                quantity: "",
                                points: "${data.points}",
                                onEditpress: () {
                                  Navigator.pushNamed(context, '/add-product',
                                      arguments: {
                                        'title': 'Edit Product',
                                        "isEdit": true,
                                        "id": data.id,
                                        "name": "${data.productName}",
                                        "desc": "${data.description}",
                                        "points": "${data.points}",
                                        "image": '${data.productImage}'
                                      });
                                },
                                onDeletepress: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        DeleteConfirmationDialog(
                                      message:
                                          "Are you sure you want to delete this?",
                                      onConfirm: () async {
                                        var url = Endpoints.delete +
                                            "type=product&id=${data.id}";

                                        print(
                                            "=========url======$url===========");
                                        final apiResponse = await showDialog(
                                          context: context,
                                          builder: (context) =>
                                              FutureProgressDialog(
                                                  baseClient.get(
                                            true,
                                            Endpoints.baseUrl,
                                            url,
                                          )),
                                        );

                                        var res = jsonDecode(apiResponse);

                                        if (res['success'] == true) {
                                          provider.fetchProduct();
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "${res['message']}",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.SNACKBAR,
                                            timeInSecForIosWeb: 2,
                                            backgroundColor:
                                                AppColor.neturalRed,
                                            textColor: Colors.white,
                                          );
                                        }
                                      },
                                    ),
                                  );
                                },
                                image:
                                    '${Endpoints.imageUrl}${data.productImage}',
                              );
                            }))
              ]),
            );
          }
        }));
  }
}
