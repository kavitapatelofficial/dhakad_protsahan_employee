import 'dart:convert';

import 'package:dashboard_flutter/providers/contractor_provider.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/contractor_card.dart';
import 'package:dashboard_flutter/widgets/delete_widget.dart';

import 'package:dashboard_flutter/widgets/row_headint_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:provider/provider.dart';

class ContractorView extends StatefulWidget {
  const ContractorView({super.key});

  @override
  State<ContractorView> createState() => _ContractorViewState();
}

class _ContractorViewState extends State<ContractorView> {
  ContractorProvider? myProvider;
  BaseClient baseClient = BaseClient();
  @override
  void initState() {
    super.initState();

    // Call the provider using WidgetsBinding.instance!
    myProvider = Provider.of<ContractorProvider>(context, listen: false);
    myProvider!.fetchContractors();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.accentBgColor,
        appBar: CustomAppBar("Contractor"),
        body: Consumer<ContractorProvider>(builder: (context, provider, child) {
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
                RowHeadingText(
                    title: "Contractors",
                    onpress: () {
                      Navigator.pushNamed(
                        context,
                        '/add-contractor',
                        arguments: {
                          'title': 'Add Contractor',
                          "isEdit": false,
                        },
                      );
                    },
                    btnText: "Add"),
                provider.getContractor.data!.isEmpty
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
                            itemCount: provider.getContractor.data!.length,
                            itemBuilder: (context, index) {
                              var user = provider.getContractor.data![index];
                              return ContractorCard(
                                name: "${user.name}",
                                onEditPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/add-contractor',
                                    arguments: {
                                      'title': 'Edit Contractor',
                                      "isEdit": true,
                                      "points": "${user.availablePoints}",
                                      "cId": "${user.cId==null?"NA":user.cId}",
                                      "name": "${user.name}",
                                      "address": "${user.address}",
                                      "number": "${user.number}",
                                      "number2": "${user.alternateNumber}",
                                      "id": "${user.id}",
                                      "image":
                                          "${user.image == null ? null : user.image}",
                                    },
                                  );
                                },
                                image: "${Endpoints.imageUrl}${user.image}",
                                address: '${user.address}',
                                number: "${user.number}",
                                alternateNumber: "${user.alternateNumber}",
                                onDeletePressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        DeleteConfirmationDialog(
                                      message:
                                          "Are you sure you want to delete this ?",
                                      onConfirm: () async {
                                        var url = Endpoints.delete +
                                            "type=contractor&id=${user.id}";

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
                                          provider.fetchContractors();
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
                                cId: '${user.cId}',
                              );
                            }))
              ]),
            );
          }
        }));
  }
}
