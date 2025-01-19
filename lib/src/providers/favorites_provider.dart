import 'package:flutter/cupertino.dart';
import 'package:travel_app/src/models/categories_api_response_model.dart';

class FavLocationsProvider extends ChangeNotifier{
  final List<LocationData> _favLocations = [];

  List<LocationData> get favLocations => _favLocations;

  void addToFavLocations(LocationData location){
    _favLocations.add(location);
    notifyListeners();
  }

  void removeFromFavLocation(LocationData location){
    _favLocations.remove(location);
    notifyListeners();
  }

  bool isFav(LocationData location) {
    return _favLocations.contains(location);
  }

}