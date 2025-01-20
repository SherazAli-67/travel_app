import 'package:flutter/cupertino.dart';
import 'package:travel_app/src/models/wishlist_locations_model.dart';

class WishListLocationsProvider extends ChangeNotifier{
  final List<WishlistLocationsModel> _favLocations = [];

  List<WishlistLocationsModel> get wishListLocations => _favLocations;

  void addToFavLocations(dynamic locationApiResponse, String imageUrl){
    WishlistLocationsModel wishlistLocationsModel = WishlistLocationsModel(
        locationID: locationApiResponse['location_id'],
        title: locationApiResponse['name'],
        ratings: locationApiResponse['rating'] ?? '4.5',
        description: locationApiResponse['description'] ?? '',
        imageUrl: imageUrl);
    _favLocations.add(wishlistLocationsModel);
    notifyListeners();
  }

  void removeFromFavLocation(String locationID){
    _favLocations.removeWhere((location)=> location.locationID == locationID);
    notifyListeners();
  }

  bool isFav(String locationID) {
    return _favLocations.where((location)=> location.locationID == locationID).toList().isNotEmpty;
  }

}