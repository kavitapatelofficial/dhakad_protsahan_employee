import 'package:dashboard_flutter/providers/allocation_provider.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/gift_allocation_card.dart';


import 'package:dashboard_flutter/widgets/row_headint_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllocationView extends StatefulWidget {
  const AllocationView({super.key});

  @override
  State<AllocationView> createState() => _AllocationViewState();
}

class _AllocationViewState extends State<AllocationView> {
  AllocationProvider? myProvider;

  @override
  void initState() {
    super.initState();

    // Call the provider using WidgetsBinding.instance!
    myProvider = Provider.of<AllocationProvider>(context, listen: false);
    myProvider!.fetchAllocations();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.accentBgColor,
        appBar: CustomAppBar("Allocation"),
        body: Consumer<AllocationProvider>(builder: (context, provider, child) {
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
                title: "Allocations",
                onpress: () {
                  Navigator.pushNamed(
                    context,
                    '/add-allocation',
                    arguments: {
                      'title': 'Add Allocation',
                      "isEdit": false,
                    },
                  );
                },
                btnText: "Add"),

        
                provider.getAllocation.data!.isEmpty
                    ? const SizedBox(
                         height: 400,
                        width: double.infinity,
                        child: Center(
                          child: Text("No Data Found"),
                        ),
                      )
                    :
            Flexible(
                flex: 1,
                child: ListView.builder(
                    itemCount: provider.getAllocation.data!.length,
                    itemBuilder: (context, index) {
                      return AllocationCard(
                        contractorName: "Kavita Patel $index",
                        productName: "Product $index",
                        points: "50$index",
                        quantity: "60$index",
                        onEditPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/add-allocation',
                            arguments: {
                              'title': 'Edit Allocation',
                              "isEdit": true,
                              "cName": "Kavita Patel $index",
                              "pName": "Product $index",
                              "points": "50$index",
                              "quantity": "70$index",
                              "id": "1",
                            },
                          );
                        },
                      );
                    }))
          ]),
        );
  }})
        
        );
  }
}
