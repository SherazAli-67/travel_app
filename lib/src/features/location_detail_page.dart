import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/src/app_data/app_data.dart';
import 'package:travel_app/src/bloc_cubit/location_details_cubit/location_details_cubit.dart';
import 'package:travel_app/src/models/photos_api_response_model.dart';
import 'package:travel_app/src/models/review_api_response.dart';
import 'package:travel_app/src/res/app_colors.dart';
import 'package:travel_app/src/res/app_icons.dart';
import 'package:travel_app/src/res/app_text_styles.dart';
import 'package:travel_app/src/services/api_service.dart';
import 'package:travel_app/src/widgets/avatar_stack_widget.dart';
import 'package:travel_app/src/widgets/loading_widgets.dart';

class LocationDetailPage extends StatefulWidget{
  const LocationDetailPage({super.key, required this.locationID});
  final String locationID;

  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {

  dynamic _locationDetailsApiResponse;
  late PhotosApiResponseModel photosApiResponseModel;
  late ReviewResponse reviewResponse;
  int _selectedPictureIndex = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initLocationDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LocationDetailsCubit, LocationDetailStates>(

            builder: (_, state){
              if(state is LoadingLocDetailsState){
                return LoadingWidget();
              }else if(state is LoadingLocDetailsFailed){
                return Center(child: Text(state.errorMessage, style: AppTextStyles.mediumTextStyle,),);
              }else if(state is LoadedLocDetailsState){
                _locationDetailsApiResponse = state.locDetails;
                photosApiResponseModel = state.photosApiResponseModel!;
                String ratingCount = NumberFormat.compact().format(int.parse(_locationDetailsApiResponse['num_reviews']));
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        // alignment: Alignment.bottomCenter,
                        children: [
                          AppBar(
                            leading: IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: const Icon(Icons.navigate_before_rounded),),
                            title: Text(_locationDetailsApiResponse['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                            actions: [
                              IconButton(onPressed: (){}, icon: SvgPicture.asset(AppIcons.icFavorite))
                            ],
                            leadingWidth: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: double.infinity,
                                  maxHeight: 300
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: photosApiResponseModel.data[_selectedPictureIndex].images.large.url,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 1,
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                            ),
                            margin: const EdgeInsets.only(top: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 55,
                                    width: double.infinity,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: photosApiResponseModel.data.length,
                                        itemBuilder: (ctx, index){
                                          return GestureDetector(
                                            onTap: ()=> setState(()=> _selectedPictureIndex = index),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: _selectedPictureIndex == index ? AppColors.primaryColor : Colors.transparent)
                                              ),
                                              margin: const EdgeInsets.only(right: 10),
                                              padding: const EdgeInsets.all(2), child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: CachedNetworkImage(imageUrl: photosApiResponseModel.data[index].images.medium.url,),
                                            ),),
                                          );
                                        }),
                                  ),
                                  const SizedBox(height: 20,),
                                  AvatarStackWidget(avatarUrls: AppData.ratingUsers, overlayText: ratingCount),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("About", style: AppTextStyles.subHeadingTextStyle,),
                                      Row(
                                        children: [
                                          const Icon(Icons.star,color: Colors.amber,),
                                          const SizedBox(width: 5,),
                                          Text('${_locationDetailsApiResponse['rating']}', style: AppTextStyles.subHeadingTextStyle,)
                                        ],
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10,),
                                  Text(_locationDetailsApiResponse['description']),
                                  const SizedBox(height: 20,),
                                  const Text("Features", style: AppTextStyles.subHeadingTextStyle,),
                                  const SizedBox(height: 10,),
                                  SizedBox(height: 40, child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                      itemCount: _locationDetailsApiResponse['features'].length,
                                      itemBuilder: (ctx, index){
                                      String feature = _locationDetailsApiResponse['features'][index];
                                      return Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.circular(99)
                                        ),
                                        child: Text(feature,style: AppTextStyles.smallTextStyle.copyWith(color: Colors.white),),
                                      );
                                  }),),
                                  const SizedBox(height: 20,),
                                  const Text("Location", style: AppTextStyles.subHeadingTextStyle,),
                                  const SizedBox(height: 10,),
                                  SizedBox(
                                    height: 200,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(AppIcons.icMapPng, fit: BoxFit.cover,),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  const Text("Reviews", style: AppTextStyles.subHeadingTextStyle,),
                                  const SizedBox(height: 10,),
                                  FutureBuilder(future: ApiService.getLocationReviews(locationID: widget.locationID), builder: (ctx, snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return LoadingWidget();
                                    }else if(snapshot.hasError){
                                      return Center(child: Text(snapshot.error.toString()),);
                                    }else if(snapshot.hasData){
                                      reviewResponse = snapshot.requireData!;
                                      return Column(
                                        children: List.generate(5, (index){
                                          Review review = reviewResponse.data[index];
                                          return ListTile(
                                              titleAlignment: ListTileTitleAlignment.titleHeight,
                                              leading: CircleAvatar(
                                                backgroundImage: CachedNetworkImageProvider(
                                                    review.user.avatar.large
                                                ),
                                              ),
                                              title: Text(review.title, style: AppTextStyles.titleTextStyle,),
                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                      children: List.generate(5, (index)=> Icon(Icons.star, color: Colors.amber,))
                                                  ),
                                                  Text(review.text),
                                                ],
                                              )
                                          );
                                        }),
                                      );
                                    }
                                    return const SizedBox();
                                  })
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    /*Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor
                            ),
                            onPressed: (){}, child: Text("Book Now", style: AppTextStyles.btnTextStyle.copyWith(color: Colors.white),)),
                      ),
                    )*/
                  ],
                );
              }

              return const SizedBox();
            }, listener: (_, state){
        }),
      )
    );
  }

  void _initLocationDetails() {
    context.read<LocationDetailsCubit>().fetchLocationDetailsByID(locID: widget.locationID);
  }
}