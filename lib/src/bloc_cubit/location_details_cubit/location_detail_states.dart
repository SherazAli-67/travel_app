part of 'location_details_cubit.dart';
abstract class LocationDetailStates {}

class InitialDetailState extends LocationDetailStates{}

class LoadingLocDetailsState  extends LocationDetailStates{}
class LoadedLocDetailsState extends LocationDetailStates{
  final dynamic locDetails;
  final PhotosApiResponseModel? photosApiResponseModel;
  LoadedLocDetailsState({required this.locDetails, this.photosApiResponseModel});
}
class LoadingLocDetailsFailed extends LocationDetailStates{
  final String errorMessage;
  LoadingLocDetailsFailed({required this.errorMessage});
}

class LoadingLocPhotos extends LocationDetailStates{}
class LoadedLocPhotos extends LocationDetailStates{
  final PhotosApiResponseModel photosApiResponseModel;

  LoadedLocPhotos({required this.photosApiResponseModel});
}
class LoadingLocPhotosFailed extends LocationDetailStates{
  final String errorMessage;

  LoadingLocPhotosFailed({required this.errorMessage});
}