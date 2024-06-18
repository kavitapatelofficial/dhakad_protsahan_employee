import 'package:cached_network_image/cached_network_image.dart';

import 'package:dashboard_flutter/providers/contractor_provider.dart';

import 'package:dashboard_flutter/screens/navbar/navbar.dart';
import 'package:dashboard_flutter/screens/navbar/right_drawer.dart';
import 'package:dashboard_flutter/utils/assets.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';

import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.accentBgColor,
      drawer: NavBar(),
      endDrawer: RightSideNavBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          iconTheme: IconThemeData(color: AppColor.defaultBlackColor),
          backgroundColor: AppColor.accentBgColor,
          elevation: 1,
          actions: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              child: CachedNetworkImage(
                imageUrl:
                    "${Endpoints.imageUrl}${Endpoints.box.read("image") == "" ? "" : Endpoints.box.read("image")}",
                errorWidget: (context, url, error) => CircleAvatar(
                  backgroundColor: AppColor.neturalRed,
                  radius: 20,
                  child: Image.asset("assets/images/user_placeholder.png"),
                ),
                placeholder: (context, url) => CircleAvatar(
                  backgroundColor: AppColor.neturalRed,
                  radius: 20,
                  child: Image.asset("assets/images/user_placeholder.png"),
                ),
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 20,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                title: Text('Welcome To', style: Texttheme.heading),
                subtitle:
                    Text('Dhakad Protsahan Employee', style: Texttheme.subTitle),
              ),
              const SizedBox(height: 5)
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: const BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(200))),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                itemDashboard('Add Point', Assets.AddPoint, () {
                  final productProvider =
                      Provider.of<ContractorProvider>(context, listen: false);
                  productProvider.fetchContractors();
                  Navigator.pushNamed(context, "/allocation-search");
                }),
                // itemDashboard('Deduct Point', Assets.DeductPoint, () {
                //   Navigator.pushNamed(context, "/deduct-point-history");
                // }),
                itemDashboard(
                    'Contractor/Mason Details', Assets.ConytractorMasonDetails,
                    () {
                  Navigator.pushNamed(context, "/contractor");
                }),
                itemDashboard(
                    'Add New Contractor/Mason', Assets.AddNewContractor, () {
                  Navigator.pushNamed(
                    context,
                    '/add-contractor',
                    arguments: {
                      'title': 'Add Contractor',
                      "isEdit": false,
                    },
                  );
                }),
                itemDashboard('Our Products', Assets.OurProducts, () {
                  // Navigator.pushNamed(context, "/redemption-search");
                  Navigator.pushNamed(context, "/products");
                }),
                // itemDashboard('Point History', Assets.PointHistory, () {
                //   Navigator.pushNamed(context, "/points-sales-history");
                // }),
                itemDashboard('Gift Products', Assets.GiftProduct, () {
                  Navigator.pushNamed(context, "/gifts");
                }),
                itemDashboard('Gift Redemption', Assets.GiftRedemption, () {
                  final productProvider =
                      Provider.of<ContractorProvider>(context, listen: false);
                  productProvider.fetchContractors();
                  Navigator.pushNamed(context, "/redemption-contact-search");
                }),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Material(
          //     color: Colors.white,
          //     elevation: 18,
          //     shadowColor: AppColor.primaryColor,
          //     shape: RoundedRectangleBorder(
          //       borderRadius:
          //           BorderRadius.circular(15.0), // Set your border radius here
          //     ),
          //     child: ListTile(
          //       onTap: () {},
          //       contentPadding: EdgeInsets.symmetric(horizontal: 20),
          //       tileColor: AppColor.accentWhite,
          //       title: Text(
          //         "Settings",
          //         style: Texttheme.subheading,
          //       ),
          //       leading: Icon(CupertinoIcons.settings),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(
          //             15.0), // Set your border radius here
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  itemDashboard(String title, String iconData, VoidCallback onpress) =>
      GestureDetector(
        onTap: onpress,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 5),
                    color: AppColor.primaryColor.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconData,
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  title,
                  style: Texttheme.lableStyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );
}
