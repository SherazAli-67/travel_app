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
import 'package:travel_app/src/services/api_service.dart';
import 'package:travel_app/src/widgets/loading_widgets.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;
  List<Map<String, dynamic>> categoriesList = [];

  bool _loadingExploreMore = false;

  List<Map<String, dynamic>> exploreMoreLocations = [];
  @override
  void initState() {
    _initExploreMore();
    super.initState();
  }
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
        child: SingleChildScrollView(
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
                height: 300,
                child: BlocConsumer<HomeCubit, HomeStates>(builder: (_,state){
                  if(state is LoadingCategoriesState){
                    return const Center(child: CupertinoActivityIndicator(),);
                  }else if(state is LoadedCategoriesState){
                    categoriesList = state.categoriesList;

                    return GridView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: categoriesList.length,
                        itemBuilder: (ctx, index){

                      LocationData category= categoriesList[index]['location'];
                      String imageUrl = categoriesList[index]['imageUrl'];
                      return GestureDetector(
                        onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> LocationDetailPage(location: category))),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    fit: BoxFit.cover,
                                    height: 220,
                                  )
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
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Explore more",style: AppTextStyles.subHeadingTextStyle.copyWith(fontWeight: FontWeight.w600),),
                  TextButton(onPressed: ()=>_initExploreMore(), child: Text("See all", style: AppTextStyles.btnTextStyle,))
                ],
              ),
              _loadingExploreMore ? LoadingWidget() :
              Column(
                children: List.generate(exploreMoreLocations.length, (index){
                  String imageUrl = exploreMoreLocations[index]['imageUrl'];
                  LocationData location = exploreMoreLocations[index]['location'];
                  return GestureDetector(
                    onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> LocationDetailPage(location: location))),
                    child: Card(
                        elevation: 1,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(imageUrl: imageUrl, width: 100,),
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(location.name, style: AppTextStyles.titleTextStyle,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.location_on_rounded, color: Colors.grey, size: 20,),
                                        Expanded(child: Text(location.address.country,))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  );
                }),
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

  void _initExploreMore()async{
    setState(()=>  _loadingExploreMore = true);
   exploreMoreLocations = await ApiService.getLocationsByCategory('America');
    setState(()=>  _loadingExploreMore = false);
  }
}