import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/src/features/location_detail_page.dart';
import 'package:travel_app/src/models/categories_api_response_model.dart';

import '../res/app_text_styles.dart';

class LocationItemWidget extends StatelessWidget{
  final LocationData category;
  final String imageUrl;
  final double height;
  final double pageOffset;
  const LocationItemWidget({super.key, required this.category, required this.imageUrl, required this.height, required this.pageOffset});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> LocationDetailPage(location: category))),
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.only(right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // alignment: Alignment.topLeft,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  height: height,
                  alignment: Alignment(pageOffset, 0),
                )
            ),
            Padding(padding: const EdgeInsets.all(8), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category.name, maxLines: 1, style: AppTextStyles.btnTextStyle),
                Row(
                  children: [
                    const Icon(Icons.location_on,),
                    const SizedBox(width:10),
                    Expanded(child: Text(category.address.country, style: AppTextStyles.smallTextStyle))
                  ],
                )
              ],
            ),)

          ],
        ),
      ),
    );
  }

}