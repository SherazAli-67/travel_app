import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/src/models/categories_api_response_model.dart';
import 'package:travel_app/src/models/photos_api_response_model.dart';

class ApiService {
  static Future<List<Map<String, dynamic>>> getLocationsByCategory(String category)async{
    List<LocationData> locations = [];

    final apiKey = dotenv.env['TRIP_API'];

   /* const url = 'https://api.content.tripadvisor.com/api/v1/location/search?key=482FF4AF3A154040BF116A6FDE2E5B67&searchQuery=Restaurants&category=Hotels&language=en';
    const options = {method: 'GET', headers: {accept: 'application/json'}};
*/
    const String baseUrl =
        'https://api.content.tripadvisor.com/api/v1/location/search';

    final String url =
        '$baseUrl?key=$apiKey&searchQuery=$category&category=$category&language=en';

    final Map<String, String> headers = {
      'accept': 'application/json',
    };
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      debugPrint("Response: ${response.body}");
      CategoryApiResponse apiResponse = CategoryApiResponse.fromJson(jsonResponse);
      locations =  apiResponse.data;

    } else {
      debugPrint('Error: ${response.statusCode}, ${response.body}');
    }
    List<Map<String,dynamic>> mappedLocations = [];

    //Getting picture of each category
    try{
      for (var location in locations) {
        PhotosApiResponseModel? photosApiResponseModel = await getLocationPhotos(locationID: location.locationId, limit: 1);
        if(photosApiResponseModel != null){
          mappedLocations.add({
            'location' : location,
            'imageUrl' : photosApiResponseModel.data.first.images.large.url
          });
        }
      }
    }catch(e){
      debugPrint("Exception while getting location: ${e.toString()}");
    }
    return mappedLocations;
  }

  static Future<dynamic> getLocationDetailsByID({required String locationID})async{
    List<LocationData> locations = [];

    final apiKey = dotenv.env['TRIP_API'];

    const String baseUrl =
        'https://api.content.tripadvisor.com/api/v1/location';

    final String url =
        '$baseUrl/$locationID/details?key=$apiKey&language=en&currency=USD';

    final Map<String, String> headers = {
      'accept': 'application/json',
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    debugPrint("Response: ${response.body}");
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      debugPrint('Error: ${response.statusCode}, ${response.body}');
    }
    return locations;
  }

  static Future<PhotosApiResponseModel?> getLocationPhotos({required String locationID, int? limit}) async{

    /*
    * const url = 'https://api.content.tripadvisor.com/api/v1/location/4053480/photos?key=482FF4AF3A154040BF116A6FDE2E5B67&language=en&limit=1';
const options = {method: 'GET', headers: {accept: 'application/json'}};

    *
    * */
    final apiKey = dotenv.env['TRIP_API'];
    const String baseUrl = 'https://api.content.tripadvisor.com/api/v1/location';
    String url ='';
    if(limit != null){
       url =
          '$baseUrl/$locationID/photos?key=$apiKey&language=en&currency=USD&limit=$limit';
    }else{
      url =
          '$baseUrl/$locationID/photos?key=$apiKey&language=en&currency=USD';
    }


    final Map<String, String> headers = {
      'accept': 'application/json',
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      PhotosApiResponseModel photosApiResponseModel = PhotosApiResponseModel.fromJson(jsonResponse);
      return photosApiResponseModel;
    } else {
      debugPrint('Error: ${response.statusCode}, ${response.body}');
    }
    return null;
  }

  static Future<Map<String,dynamic>?> getLocationReviews({required String locationID}) async{

    final apiKey = dotenv.env['TRIP_API'];
    const String baseUrl = 'https://api.content.tripadvisor.com/api/v1/location';
    final String url =
        '$baseUrl/$locationID/reviews?key=$apiKey&language=en&currency=USD';

    final Map<String, String> headers = {
      'accept': 'application/json',
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      debugPrint('Error: ${response.statusCode}, ${response.body}');
    }
    return null;
  }


}