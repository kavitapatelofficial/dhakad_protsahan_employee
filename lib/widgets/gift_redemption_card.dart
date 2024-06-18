
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';

class GiftRedemptionCard extends StatelessWidget {
  final String contractorName;
  final String productName;
  final String points;
  final String quantity;
 
  final Function()? onEditPressed;
  final Function()? onDeletePressed;

  GiftRedemptionCard({

    this.onEditPressed,
   
    this.onDeletePressed, required this.contractorName, required this.productName, required this.points, required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
             
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Contractor Name : ',
                          style: Texttheme.lableStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: contractorName,
                              style: Texttheme.subheading,
                            ),
                          ],
                        ),
                      ),
                        
                         const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Product Name : ',
                          style: Texttheme.lableStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: productName,
                              style: Texttheme.subheading,
                            ),
                          ],
                        ),
                      ),
                  
                       const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Gift Points : ',
                          style: Texttheme.lableStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: points,
                              style: Texttheme.subheading,
                            ),
                          ],
                        ),
                      ),
                  
                       const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Qunatity : ',
                          style: Texttheme.lableStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: quantity,
                              style: Texttheme.subheading,
                            ),
                          ],
                        ),
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
                IconButton(
                    onPressed: onDeletePressed,
                    icon: Icon(
                      Icons.delete,
                      color: AppColor.neturalRed,
                    )),
                IconButton(
                    onPressed: onEditPressed,
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
