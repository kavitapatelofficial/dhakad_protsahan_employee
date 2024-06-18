import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';

class ProductsCard extends StatelessWidget {
  final String name;
  final String image;
  final String quantity;
  final String points;

  final VoidCallback? onEditpress;
  final VoidCallback? onDeletepress;

  const ProductsCard({
    super.key,
    required this.name,
    required this.image,
    required this.quantity,
    required this.points,
    this.onEditpress,
    this.onDeletepress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Row(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          name,
                          style: Texttheme.subheading,
                           overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Ponits:",
                                style: Texttheme.subheading.copyWith(color: AppColor.defaultBlackColor),
                                children: [
                              TextSpan(
                                text: "$points",
                                style: Texttheme.lableStyle,
                              )
                            ]))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
        ));
  }
}
