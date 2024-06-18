import 'dart:convert';

import 'package:dashboard_flutter/providers/contractor_provider.dart';
import 'package:dashboard_flutter/providers/products_provider.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/assets.dart';
import 'package:dashboard_flutter/utils/constant.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';

import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/default_button.dart';
import 'package:dashboard_flutter/widgets/showdialog.dart';
import 'package:dashboard_flutter/widgets/user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class AddAllocationScreen extends StatefulWidget {
  final Map arguments;

  const AddAllocationScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<AddAllocationScreen> createState() => _AddAllocationScreenState();
}

class _AddAllocationScreenState extends State<AddAllocationScreen> {
  // RegisterUser? registerUser;
  ContractorProvider? myCProvider;
  BaseClient baseClient = BaseClient();
  var formKey = GlobalKey<FormState>();

  final TextEditingController points = TextEditingController();

  final TextEditingController quantity = TextEditingController();

  List<GlobalKey<FormState>> formKeys = [];
  List<String> productIds = [];
  List<TextEditingController> pointsControllers = [];
  List<TextEditingController> quantityControllers = [];

  List<Map<String, String>> productList = [];
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  start() {
    formKeys.add(GlobalKey<FormState>());
    productIds.add('${widget.arguments['pId']}');
    pointsControllers.add(TextEditingController());
    quantityControllers.add(TextEditingController());
  }

  ProductProvider? myProvider;

  @override
  void initState() {
    super.initState();

    start();
  }

  @override
  Widget build(BuildContext context) {
     myCProvider = Provider.of<ContractorProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.accentBgColor,
        appBar: CustomAppBar(widget.arguments['title']),
        body: Consumer<ProductProvider>(builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      onSaved: (newValue) => _dateController.text = newValue!,
                      decoration: InputDecoration(
                        hintText: 'Select Purchase Date',
                        counterText: "",
                        isDense: true,
                        border: outlineInputBorder(),
                        focusedBorder: outlineInputBorder(),
                        enabledBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: AppColor.accentWhite,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: productIds.asMap().entries.map((e) {
                        print(
                            "=============e.key+1======${e.key}================");
                        return addform(e.key, provider);
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Add More Point",
                          style: Texttheme.subheading,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                setState(() {
                                  formKeys.add(GlobalKey<FormState>());
                                  productIds.add(
                                      '${productIds.first}'); // Set the initial product selection
                                  pointsControllers
                                      .add(TextEditingController());
                                  quantityControllers
                                      .add(TextEditingController());
                                });
                              });
                            },
                            icon: Image.asset(
                              Assets.AddPoint,
                              height: 40,
                              width: 40,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DefaultButton(
                      buttonText:
                          widget.arguments['isEdit'] == true ? "Edit" : "Save",
                      press: () async {
                        formKey.currentState!.save();
                        if (_dateController.text.trim().isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please select purchase date",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 2,
                            backgroundColor: AppColor.neturalRed,
                            textColor: Colors.white,
                          );
                        } else if (quantityControllers[0].text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please enter quantity",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 2,
                            backgroundColor: AppColor.neturalRed,
                            textColor: Colors.white,
                          );
                        } else {
                          print(
                              "=================productList===============$productList======");

                          List<Map<String, String>> dataList = [];

                          for (int i = 0; i < productIds.length; i++) {
                            dataList.add({
                              'product': productIds[i],
                              'quantity': quantityControllers[i].text,
                            });
                          }

                          print(dataList);
                          Map<String, dynamic> result = {
                            'contractor_id': '${widget.arguments['id']}',
                            'date': _dateController.text,
                          };

                          for (Map<String, String> data in dataList) {
                            data.forEach((key, value) {
                              if (key != 'contractor_id') {
                                if (!result.containsKey(key)) {
                                  result[key] = [];
                                }
                                result[key]!.add(value);
                              }
                            });
                          }

                          print(result);

                          final apiResponse = await showDialog(
                            context: context,
                            builder: (context) => FutureProgressDialog(
                                baseClient.post(true, Endpoints.baseUrl,
                                    Endpoints.addAllocation, result)),
                          );

                          if (apiResponse != null) {
                            var data2 = jsonDecode(apiResponse);
                            print(
                                "==========data2========$data2==================");
                            if (data2['success'] == true) {
                              myCProvider!.fetchContractors();
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    success: true,
                                    title: "Dialog Title",
                                    content: "${data2['message']}",
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    success: false,
                                    title: "Dialog Title",
                                    content: "${data2['message']}",
                                  );
                                },
                              );
                            }
                          }
                        }
                      },
                      buttonColor: AppColor.primaryColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Column addform(int index, ProductProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 15.0),
        provider.getProduct!.data!.isEmpty
            ? const SizedBox(
                height: 400,
                width: double.infinity,
                child: Center(
                  child: Text("No Data Found"),
                ),
              )
            : DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: "Select a product",
                  isDense: true,
                  border: outlineInputBorder(),
                  focusedBorder: outlineInputBorder(),
                  enabledBorder: outlineInputBorder(),
                  filled: true,
                  fillColor: AppColor.accentWhite,
                ),
                validator: (value) =>
                    // ignore: unnecessary_null_comparison
                    productIds[index] == null ? "Select a product" : null,
                value: productIds[index],
                onChanged: (String? newValue) {
                  setState(() {
                    productIds[index] = newValue!;
                  });
                },
                items: provider.getProduct!.data!.map((e) {
                  return DropdownMenuItem(
                      child: Text("${e.productName}"), value: "${e.id}");
                }).toList()),
        const SizedBox(height: 15.0),
        TextFormField(
          keyboardType: TextInputType.number,
          onSaved: (newValue) => quantityControllers[index].text = newValue!,
          maxLength: 10,
          controller: quantityControllers[index],
          decoration: InputDecoration(
            hintText: 'Enter quantity',
            counterText: "",
            isDense: true,
            border: outlineInputBorder(),
            focusedBorder: outlineInputBorder(),
            enabledBorder: outlineInputBorder(),
            filled: true,
            fillColor: AppColor.accentWhite,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          color: AppColor.defaultBlackColor,
        )
      ],
    );
  }
}

class UserInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}
