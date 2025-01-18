import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/src/models/photos_api_response_model.dart';
import 'package:travel_app/src/services/api_service.dart';

part 'location_detail_states.dart';
class LocationDetailsCubit extends Cubit<LocationDetailStates> {
  LocationDetailsCubit() : super(InitialDetailState());

  void fetchLocationDetailsByID({required String locID})async{
    try{
      emit(LoadingLocDetailsState());
      final locDetails = await ApiService.getLocationDetailsByID(locationID: locID);
      PhotosApiResponseModel? photosApiResponseModel = await ApiService.getLocationPhotos(locationID: locID);
      emit(LoadedLocDetailsState(locDetails: locDetails, photosApiResponseModel: photosApiResponseModel));
    }catch(e){
      String errorMessage = e.toString();
      if(e is PlatformException){
        errorMessage = e.message!;
      }

      emit(LoadingLocDetailsFailed(errorMessage: errorMessage));
    }
  }

  void fetchLocationPhotos({required String locID})async{
    try{
      emit(LoadingLocPhotos());
      final photos = await ApiService.getLocationPhotos(locationID: locID);
      if(photos != null){

        emit(LoadedLocPhotos(photosApiResponseModel: photos));
      }else{
        emit(LoadingLocPhotosFailed(errorMessage: "Failed to get photos"));
      }
    }catch(e){
      String errorMessage = e.toString();
      if(e is PlatformException){
        errorMessage = e.message!;
      }

      emit(LoadingLocPhotosFailed(errorMessage: errorMessage));
    }
  }
}