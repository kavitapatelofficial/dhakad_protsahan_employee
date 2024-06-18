import 'package:dashboard_flutter/utils/assets.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RightSideNavBar extends StatelessWidget {



  _launchURL(String link) async {
   Uri url = Uri.parse('${link}');
   if (!await launchUrl(url)) {
        throw Exception('Could not launch $link');
   }
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          Card(
            margin: EdgeInsets.only(top: 50),
            elevation: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back)),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Settings",
                  style: Texttheme.heading,
                ),
              ],
            ),
          ),
          ListTile(
             leading: Image.asset(
              Assets.AddNewContractor,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Edit Profile',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(
                context,
                "/update-profile",
              );
            },
          ),

          ListTile(
            leading: Image.asset(
              Assets.privacy,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Privacy Policy',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();

              _launchURL(Endpoints.privacyPolicy);
             
            },
          ),
//wevview
          ListTile(
            leading: Image.asset(
              Assets.terms,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Terms and Conditions',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();
              _launchURL(Endpoints.termsCondition);
            },
          ),

          ListTile(
            leading: Image.asset(
              Assets.about,
              height: 35,
              width: 35,
            ),
            title: Text(
              'About us',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();
             _launchURL(Endpoints.aboutUs);
            },
          ),

          ListTile(
            leading: Image.asset(
              Assets.desc,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Disclaimer',
              style: Texttheme.title,
            ),
            onTap: () {
              Navigator.of(context).pop();
             _launchURL(Endpoints.disclaimer);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              "Logout",
              style: Texttheme.heading.copyWith(color: AppColor.primaryColor),
            ),
            onTap: (){
              Endpoints.box.erase();
              Navigator.pushNamedAndRemoveUntil(context, "/signin", (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
