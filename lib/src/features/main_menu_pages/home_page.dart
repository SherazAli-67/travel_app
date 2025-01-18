import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app/src/app_data/app_data.dart';
import 'package:travel_app/src/bloc_cubit/home_page_cubit/home_cubit.dart';
import 'package:travel_app/src/bloc_cubit/home_page_cubit/home_states.dart';
import 'package:travel_app/src/features/location_detail_page.dart';
import 'package:travel_app/src/models/categories_api_response_model.dart';
import 'package:travel_app/src/res/app_colors.dart';
import 'package:travel_app/src/res/app_icons.dart';
import 'package:travel_app/src/res/app_text_styles.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;

  List<LocationData> categoriesList = [];
  @override
  void didChangeDependencies() {
    _initCategoryInfo();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.grey50,
                      shape: BoxShape.circle
                    ),
                    child: IconButton(onPressed: (){}, icon: SvgPicture.asset(AppIcons.icDrawerMenu),)
                  ),

                  Container(
                      decoration: const BoxDecoration(
                          color: AppColors.grey50,
                          shape: BoxShape.circle
                      ),
                      child: IconButton(onPressed: (){}, icon: SvgPicture.asset(AppIcons.icNotifications),)
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Text("Explore the world!",style: AppTextStyles.subHeadingTextStyle.copyWith(fontWeight: FontWeight.w600),),
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
              const SizedBox(height: 10,),
              Text("Categories",style: AppTextStyles.btnTextStyle.copyWith(fontSize: 20),),
              const SizedBox(height: 10,),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: AppData.categories.length,
                    itemBuilder: (ctx, index){
                      bool isSelected = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: (){
                      setState(() =>  _selectedCategoryIndex = index);
                      homeCubit.fetchCategoryDetail(category: AppData.categories[_selectedCategoryIndex]);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 15,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(color: isSelected ? AppColors.primaryColor : AppColors.greyColor),
                        color: isSelected ? AppColors.primaryColor : null
                      ),
                      child: Text(AppData.categories[index], style: AppTextStyles.titleTextStyle.copyWith(color: isSelected ? Colors.white : AppColors.greyColor),),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 220,
                child: BlocConsumer<HomeCubit, HomeStates>(builder: (_,state){
                  if(state is LoadingCategoriesState){
                    return const Center(child: CupertinoActivityIndicator(),);
                  }else if(state is LoadedCategoriesState){
                    categoriesList = state.categoriesList;
                    return GridView.builder(
                      
                      scrollDirection: Axis.horizontal,
                        itemCount: categoriesList.length,
                        itemBuilder: (ctx, index){
                          LocationData category = categoriesList[index];
                      return GestureDetector(
                        onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> LocationDetailPage(locationID: category.locationId))),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fitWidth,
                                    width: 200,
                                    imageUrl: 'https://images.unsplash.com/photo-1600271772470-bd22a42787b3?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fE1vdW50YWluc3xlbnwwfHwwfHx8MA%3D%3D'),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(category.name, style: AppTextStyles.btnTextStyle.copyWith(color: Colors.white),),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on,color: Colors.white,),
                                            const SizedBox(width:10),
                                            Expanded(child: Text(category.address.country, style: AppTextStyles.smallTextStyle.copyWith(color: Colors.white),))
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 5/4, mainAxisSpacing: 10),);
                  }else if(state is LoadingCategoriesFailedState){
                    return Center(child: Text(state.errorMessage),);
                  }

                  return const SizedBox();
                }, listener: (_, state){}),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _initCategoryInfo() {
    context.read<HomeCubit>().fetchCategoryDetail(category: AppData.categories[0]);
  }
}