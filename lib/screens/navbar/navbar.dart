import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_flutter/utils/assets.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 55,
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "${Endpoints.imageUrl}${Endpoints.box.read("image") == "" ? "" : Endpoints.box.read("image")}",
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundColor: AppColor.neturalRed,
                    radius: 25,
                    child: Image.asset("assets/images/user_placeholder.png"),
                  ),
                  placeholder: (context, url) => const CircleAvatar(
                    child: Center(child: Icon(Icons.people)),
                    radius: 25,
                  ),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 25,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${Endpoints.box.read("name") == "" ? "" : Endpoints.box.read("name")}',
                        overflow: TextOverflow.ellipsis,
                        style: Texttheme.subheading
                            .copyWith(color: AppColor.accentWhite),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${Endpoints.box.read("phone") == "" ? "" : Endpoints.box.read("phone")}',
                        style: Texttheme.subheading
                            .copyWith(color: AppColor.accentWhite),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          ListTile(
            leading: Image.asset(
              Assets.AddPoint,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Add Points',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/allocation-search");
            },
          ),
          // ListTile(
          //   leading: Image.asset(
          //     Assets.DeductPoint,
          //     height: 35,
          //     width: 35,
          //   ),
          //   title: Text(
          //     'Deduct Points ',
          //     style: Texttheme.title,
          //   ),
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.pushNamed(context, "/deduct-point-history");
          //   },
          // ),

          ListTile(
            leading: Image.asset(
              Assets.ConytractorMasonDetails,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Contractor/Mason Details ',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/contractor");
            },
          ),

          ListTile(
            leading: Image.asset(
              Assets.AddNewContractor,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Add New Contractor/Mason',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(
                context,
                '/add-contractor',
                arguments: {
                  'title': 'Add Contractor',
                  "isEdit": false,
                },
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              Assets.OurProducts,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Our Products',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/products");
            },
          ),
          // ListTile(
          //   leading: Image.asset(
          //     Assets.PointHistory,
          //     height: 35,
          //     width: 35,
          //   ),
          //   title: Text(
          //     'Points History',
          //     style: Texttheme.title,
          //   ),
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.pushNamed(context, "/points-sales-history");
          //   },
          // ),

          //  ListTile(
          //   leading: Image.asset(
          //     Assets.PointHistory,
          //     height: 35,
          //     width: 35,
          //   ),
          //   title: Text(
          //     'Redemption History',
          //     style: Texttheme.title,
          //   ),
          //   onTap: (){
          //     Navigator.of(context).pop();
          //     Navigator.pushNamed(
          //       context,
          //       "/gift-redemption",
          //     );
          //   },
          // ),
          ListTile(
            leading: Image.asset(
              Assets.GiftProduct,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Gift Products',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/gifts");
            },
          ),

          ListTile(
            leading: Image.asset(
              Assets.GiftRedemption,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Gift Redemption',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/redemption-contact-search");
            },
          ),

// webview
        ],
      ),
    );
  }
}
