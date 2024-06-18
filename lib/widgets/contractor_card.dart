// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';

class ContractorCard extends StatelessWidget {
  final String name;
   final String cId;

  final String number;
  final String alternateNumber;
  final String address;
  final String image;
  final Function()? onEditPressed;
  final Function()? onDeletePressed;

  ContractorCard({
    Key? key,
    required this.name,
    required this.cId,
    required this.number,
    required this.alternateNumber,
    required this.address,
    required this.image,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    CachedNetworkImage(
                      imageUrl: image,
                      errorWidget: (context, url, error) => CircleAvatar(
                        backgroundColor: AppColor.neturalRed,
                        radius: 35,
                        child: Image.asset("assets/images/user_placeholder.png"),
                      ),
                      placeholder: (context, url) => const CircleAvatar(
                        child: Center(child: Icon(Icons.people)),
                        radius: 35,
                      ),
                      imageBuilder: (context, image) => CircleAvatar(
                        backgroundImage: image,
                        radius: 35,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                           Text(
                            cId==null&&cId== "null"?"NA":cId,
                            style: Texttheme.subheading,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            name=="null"?"NA":name,
                            style: Texttheme.subheading,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            number=="null"?"NA":number,
                            style: Texttheme.lableStyle,
                          ),
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
                  //     onPressed: onDeletePressed,
                  //     icon: Icon(
                  //       Icons.delete,
                  //       color: AppColor.neturalRed,
                  //     )),
                  IconButton(
                      onPressed: onEditPressed,
                      icon: Icon(
                        Icons.edit,
                        color: AppColor.accentGreen,
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
