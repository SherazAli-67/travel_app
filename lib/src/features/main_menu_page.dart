import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/src/features/main_menu_pages/home_page.dart';
import 'package:travel_app/src/features/main_menu_pages/trips_page.dart';
import 'package:travel_app/src/features/main_menu_pages/wishlist_page.dart';

import '../bloc_cubit/main_menu_bloc/main_menu_bloc.dart';
import '../res/app_colors.dart';
import '../res/app_icons.dart';

class MainMenuPage extends StatefulWidget{
  const MainMenuPage({super.key, this.comingFromNotification = false});
  final bool comingFromNotification;
  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final List<Widget>  pages = [
    const HomePage(),
    const TripsPage(),
    const WishlistPage(),
    const SizedBox()
  ];
  @override
  void initState() {
    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    /* pages = [
      const HomePage(),
      const SizedBox(),
      const SizedBox(),
      const SizedBox()
    ];*/
    final tabChangeBloc = BlocProvider.of<MainMenuTabChangeBloc>(context);
    return BlocConsumer<MainMenuTabChangeBloc, MainMenuState>(
      listener: (_, state){},
      builder: (_, state) {
        return Scaffold(
          body: SafeArea(child: pages.elementAt(state.tabIndex)),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0), // Add some spacing around the navbar
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30), // Rounded corners
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
                child: Card(
                  elevation: 1,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99)
                  ),
                  child: SizedBox(
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavIcon(icon: AppIcons.icHomeNav, isSelected: state.tabIndex == 0 , onTap: ()=> tabChangeBloc.add(TabChangeEvent(tabIndex: 0))),
                        _buildNavIcon(icon: AppIcons.icNavigator, isSelected: state.tabIndex == 1 , onTap: ()=> tabChangeBloc.add(TabChangeEvent(tabIndex: 1))),
                        _buildNavIcon(icon: AppIcons.icFavorite, isSelected: state.tabIndex == 2 , onTap: ()=> tabChangeBloc.add(TabChangeEvent(tabIndex: 2))),
                        _buildNavIcon(icon: AppIcons.icUserProfile, isSelected: state.tabIndex == 3 , onTap: ()=> tabChangeBloc.add(TabChangeEvent(tabIndex: 3))),

                      ],
                    ),
                  )
                ),
              ),
            ),
          ),
        );
      }
    );
   /* return BlocConsumer<MainMenuTabChangeBloc, MainMenuState>(
        bloc: tabChangeBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,

            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.grey, spreadRadius: 0.5, blurRadius: 1),
                  ]
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                items: [
                  _buildBottomNavigationBarItem(state, icon: AppIcons.icHomeNav, label: 'Messages',  index: 0),
                  _buildBottomNavigationBarItem(state, icon: AppIcons.icNavigator, label: 'Calls', index: 1,),
                  _buildBottomNavigationBarItem(state, icon: AppIcons.icFavorite, label: 'Search',  index: 2),
                  _buildBottomNavigationBarItem(state, icon: AppIcons.icUserProfile, label: 'Profile', index: 3,),

                ],
                currentIndex: state.tabIndex,
                selectedItemColor: Colors.black,
                unselectedItemColor: AppColors.greyColor,
                selectedLabelStyle: AppTextStyles.smallTextStyle,
                unselectedLabelStyle: AppTextStyles.smallTextStyle,
                onTap: (index) => tabChangeBloc.add(TabChangeEvent(tabIndex: index)),
              ),
            ),
            body: pages.elementAt(state.tabIndex),
          ) ;
        });*/
  }

  Widget _buildNavIcon({required String icon, required bool isSelected, required VoidCallback onTap}) {
    return isSelected ? Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor
      ),
      // padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: onTap,
        child:  SvgPicture.asset(icon, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
      ),
    ) : IconButton(
      icon: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(isSelected ? AppColors.primaryColor : AppColors.greyColor, BlendMode.srcIn),),
      onPressed: onTap
    );
  }

}