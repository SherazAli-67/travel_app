import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/src/models/wishlist_locations_model.dart';
import 'package:travel_app/src/providers/favorites_provider.dart';
import 'package:travel_app/src/res/app_colors.dart';
import 'package:travel_app/src/res/app_text_styles.dart';
import '../../res/app_icons.dart';

class WishlistPage extends StatelessWidget{
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListLocationsProvider>(context);
    List<WishlistLocationsModel> userFavLocations = wishListProvider.wishListLocations;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your Trips", style: AppTextStyles.subHeadingTextStyle,),
          const SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: AppColors.grey50
            ),
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: AppColors.greyColor,),
                const SizedBox(width: 20,),
                Text("Search here",style: AppTextStyles.titleTextStyle.copyWith(color: AppColors.greyColor),),
                const Spacer(),
                SvgPicture.asset(AppIcons.icFilter)
              ],
            ),
          ),
          Expanded(child: ListView.builder(
              itemCount: userFavLocations.length,
              itemBuilder: (ctx, index){
                WishlistLocationsModel wishListItem = userFavLocations[index];

                bool isFav = wishListProvider.isFav(wishListItem.locationID);
                return Container(

                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.grey50)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: wishListItem.imageUrl,
                            height: 75,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(wishListItem.title,style: AppTextStyles.titleTextStyle,),
                              const SizedBox(height: 5,),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: double.parse(wishListItem.ratings),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                  const SizedBox(width: 5,),
                                  Text(wishListItem.ratings, style: AppTextStyles.mediumTextStyle,)
                                ],
                              ),
                              Text(wishListItem.description, maxLines: 2,)
                            ],

                          ),
                        ),
                            IconButton(
                                onPressed: () {
                                  if(isFav){
                                    wishListProvider.removeFromFavLocation(wishListItem.locationID);
                                  }else{
                                    wishListProvider.addToFavLocations(wishListItem.locationID,wishListItem.imageUrl);
                                  }
                                },
                                icon: isFav
                                    ?  const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ) : const Icon(Icons.favorite_border_rounded)
                            )
                          ],
                    )
                );
              }))
        ],
      ),
    );
  }
}
