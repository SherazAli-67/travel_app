import 'package:flutter/cupertino.dart';
import 'package:travel_app/src/res/app_text_styles.dart';

class TripsPage extends StatelessWidget{
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text("Your Trips", style: AppTextStyles.subHeadingTextStyle,),
          const SizedBox(height: 20,),

        ],
      ),
    );
  }

}