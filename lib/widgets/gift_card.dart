import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';

class GiftsCard extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String points;

  final VoidCallback? onEditpress;
  final VoidCallback? onDeletepress;

  const GiftsCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.points,
    this.onEditpress,
    this.onDeletepress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/placeholder.jpg",
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                ),
               
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Name : ',
                          style: Texttheme.lableStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: name,
                              style: Texttheme.subheading,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Points : ',
                          style: Texttheme.lableStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: points,
                              style: Texttheme.subheading,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // IconButton(
                    //     onPressed: onDeletepress,
                    //     icon: Icon(
                    //       Icons.delete,
                    //       color: AppColor.neturalRed,
                    //     )),
                    IconButton(
                        onPressed: onEditpress,
                        icon: Icon(
                          Icons.edit,
                          color: AppColor.accentGreen,
                        ))
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
