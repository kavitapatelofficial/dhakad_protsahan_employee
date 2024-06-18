import 'package:dashboard_flutter/providers/allocation_provider.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/allocation_response.dart';

class PointSalesHistory extends StatefulWidget {
  const PointSalesHistory({Key? key}) : super(key: key);

  @override
  State<PointSalesHistory> createState() => _PointSalesHistoryState();
}

class _PointSalesHistoryState extends State<PointSalesHistory> {
  List<String> items = [
    "Today",
    "Yesterday",
    "This Week",
    "This Month",
    "This Year"
  ];
  String currentItem = "Today";

  AllocationProvider? myProvider;

  @override
  void initState() {
    currentItem = items[0];
    myProvider = Provider.of<AllocationProvider>(context, listen: false);
    myProvider!.fetchAllocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar("All Points"),
      backgroundColor: AppColor.accentBgColor,
      body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child:
              Consumer<AllocationProvider>(builder: (context, provider, child) {
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
                height: size.height + .98,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    DropdownButton(
                      isExpanded: true,
                      value: currentItem,
                      items: items
                          .map<DropdownMenuItem<String>>(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) => setState(
                        () {
                          if (value != null) currentItem = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    provider.getAllocation.data!.isEmpty
                        ? const SizedBox(
                            height: 400,
                            width: double.infinity,
                            child: Center(
                              child: Text("No Data Found"),
                            ),
                          )
                        : Expanded(
                            child: PaginatedDataTable(
                              // horizontalMargin: 18,
                              // columnSpacing: 25,
                              showCheckboxColumn: false,
                              showFirstLastButtons: true,

                              onPageChanged: (pageIndex) {
                                setState(() {});
                              },
                              rowsPerPage:
                                  provider.getAllocation.data!.length > 5
                                      ? 5
                                      : provider.getAllocation.data!.length,
                              // availableRowsPerPage: [
                              //   5,
                              //   8,
                              //   8
                              // ], // Define the available rows per page options

                              source: _MyDataTableSource(
                                  dataList: provider.getAllocation.data!,
                                  context: context,
                                  provider1: provider),
                              columns: const [
                                DataColumn(
                                  label: Text('S.no'),
                                  numeric: true,
                                ),
                                DataColumn(
                                  label: Text('Customer Name'),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text('Points'),
                                  numeric: true,
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                  ],
                ),
              );
            }
          })),
    ));
  }
}

class _MyDataTableSource extends DataTableSource {
  final List<Datum> dataList;
  final BuildContext context;
  final AllocationProvider provider1;

  _MyDataTableSource({
    required this.dataList,
    required this.context,
    required this.provider1,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= dataList.length) {
      return null;
    }

    final data = dataList[index];
    return DataRow.byIndex(
      index: data.id,
      cells: [
        DataCell(Text("${index + 1}".toString())),
        DataCell(Text(data.contractor!.name!)),
        DataCell(Text(data.points!)),
      ],
      onSelectChanged: (_) {},
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataList.length;

  @override
  int get selectedRowCount => 0;
}
