import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/src/app_data/app_data.dart';
import 'package:travel_app/src/models/trips_model.dart';
import 'package:travel_app/src/res/app_colors.dart';
import 'package:travel_app/src/res/app_text_styles.dart';
import '../../res/app_icons.dart';

class TripsPage extends StatelessWidget{
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your Trips", style: AppTextStyles.subHeadingTextStyle,),
          const SizedBox(height: 20,),
          const SizedBox(height: 24,),
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
              itemCount: AppData.getTrips.length,
              itemBuilder: (ctx, index){
                TripsModel trip = AppData.getTrips[index];
                return Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.grey50)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trip.locationTitle, style: AppTextStyles.titleTextStyle,),
                      const SizedBox(height: 10,),
                      Text('\$ ${trip.priceInUSD}', style: AppTextStyles.mediumTextStyle.copyWith(color: Colors.blueGrey, fontWeight: FontWeight.w600,),),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_rounded, color: AppColors.greyColor,),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(trip.dateTime)
                        ],
                      )
                    ],
                  ),
                );
              }))
        ],
      ),
    );
  }
}