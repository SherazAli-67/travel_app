import 'package:flutter/material.dart';
import 'package:travel_app/src/res/app_colors.dart';
import 'package:travel_app/src/res/app_icons.dart';
import 'package:travel_app/src/res/app_text_styles.dart';

class WelcomePage extends StatelessWidget{
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(AppIcons.welcomePageBg, fit: BoxFit.cover, height: size.height,),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: size.height*0.4,
                width: size.width,
                color: Colors.black45,
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text("Get Ready for", style: AppTextStyles.subHeadingTextStyle.copyWith(color: Colors.white),),
                    Text("New Adventures", style: AppTextStyles.largeTextStyle.copyWith(color: Colors.white),),
                    Text(
                      "If you like to travel, then this is for you!, Here you can explore the beauty of the world",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.mediumTextStyle
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greyColor
                          ),
                          padding: const EdgeInsets.all(4),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greyColor
                          ),
                          padding: const EdgeInsets.all(4),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),
                    SizedBox(
                        width: size.width*0.5,
                        child: ElevatedButton(onPressed: (){}, child:  Text("Let's Tour", style: AppTextStyles.btnTextStyle.copyWith(fontFamily: 'Poppin'),)))

                  ],
                ),
              ))
          /*Column(
            children: [
              Text("Welcome to Travel App")
            ],
          ),*/
        ],
      ),
    );
  }

}