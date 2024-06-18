import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_flutter/helper/keyboard.dart';

import 'package:dashboard_flutter/providers/contractor_provider.dart';
import 'package:dashboard_flutter/utils/constant.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class RedemptionContactSearch extends StatefulWidget {
  const RedemptionContactSearch({super.key});

  @override
  State<RedemptionContactSearch> createState() =>
      _RedemptionContactSearchState();
}

class _RedemptionContactSearchState extends State<RedemptionContactSearch> {
  ContractorProvider? myProvider;

  final TextEditingController search = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Call your function here when the user stops typing for 500 milliseconds
      print("User stopped typing: $query");
      myProvider!.searchContractors(search.text.trim());
      // You can replace this with your actual function.
    });
  }

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
        appBar: CustomAppBar("Redeem Gifts"),
        body: Column(
          children: [
            const SizedBox(height: 25.0),
            Text(
              "Choose Contractor To Redeem Gift",
              style: Texttheme.heading,
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (newValue) => search.text = newValue!,
                controller: search,
                onChanged: _onSearchTextChanged,
                // onChanged: (value) {
                //   if (value.isNotEmpty) {
                //     Future.delayed(Duration(seconds: 2), () {
                //       KeyboardUtil.hideKeyboard(context);
                //       provider.searchContractors(value);
                //     });
                //   }
                // },
                decoration: InputDecoration(
                    hintText: 'Search',
                    isDense: true,
                    border: outlineInputBorder(),
                    focusedBorder: outlineInputBorder(),
                    enabledBorder: outlineInputBorder(),
                    filled: true,
                    fillColor: AppColor.accentWhite,
                    prefixIcon: IconButton(
                        onPressed: () {
                          _onSearchTextChanged(search.text.trim());
                        },
                        icon: Icon(Icons.search))),
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'Product name is Required*';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            // const SizedBox(height: 15.0),
            Flexible(
              child: Consumer<ContractorProvider>(
                  builder: (context, provider, child) {
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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        provider.getContractor.data!.isEmpty
                            ? const SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: Center(
                                  child: Text("No Data Found"),
                                ),
                              )
                            : Flexible(
                                flex: 1,
                                child: ListView.builder(
                                    itemCount:
                                        provider.getContractor.data!.length,
                                    itemBuilder: (context, index) {
                                      var _users =
                                          provider.getContractor.data![index];
                                      return Card(
                                        elevation: 0.5,
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/redemption-search',
                                              arguments: {
                                                "id": "${_users.id}",
                                                "name": "${_users.name}",
                                                "address": "${_users.address}",
                                                "number": "${_users.number}",
                                                "number2":
                                                    "${_users.alternateNumber}",
                                                "points":
                                                    "${_users.availablePoints}",
                                                "cId": "${_users.cId}",
                                              },
                                            );
                                          },
                                          tileColor: AppColor.accentWhite,
                                          leading: CachedNetworkImage(
                                            imageUrl:
                                                "${Endpoints.imageUrl}${_users.image}",
                                            errorWidget:
                                                (context, url, error) =>
                                                    CircleAvatar(
                                              backgroundColor:
                                                  AppColor.neturalRed,
                                              radius: 40,
                                              child: Image.asset(
                                                  "assets/images/user_placeholder.png"),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircleAvatar(
                                              child: Center(
                                                  child: Icon(Icons.people)),
                                              radius: 40,
                                            ),
                                            imageBuilder: (context, image) =>
                                                CircleAvatar(
                                              backgroundImage: image,
                                              radius: 40,
                                            ),
                                          ),
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("${_users.cId==null?"NA":_users.cId}"),
                                              Text("${_users.name==null?"NA":_users.name}"),
                                            ],
                                          ),
                                          subtitle: Text("${_users.number==null?"NA":_users.number}"),
                                          trailing: IconButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/redemption-search',
                                                  arguments: {
                                                    "id": "${_users.id}",
                                                    "name": "${_users.name}",
                                                    "address":
                                                        "${_users.address}",
                                                    "number":
                                                        "${_users.number}",
                                                    "number2":
                                                        "${_users.alternateNumber}",
                                                    "points":
                                                        "${_users.availablePoints}",
                                                    "cId": "${_users.cId}",
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                  Icons.arrow_forward_ios)),
                                        ),
                                      );
                                    }))
                      ],
                    ),
                  );
                }
              }),
            ),
          ],
        ));
  }
}
