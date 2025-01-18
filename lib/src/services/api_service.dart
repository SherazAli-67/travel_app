import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/src/models/categories_api_response_model.dart';
import 'package:travel_app/src/models/photos_api_response_model.dart';
import 'package:travel_app/src/models/review_api_response.dart';

class ApiService {
  static Future<List<LocationData>> getCategoryDetails(String category)async{
    List<LocationData> locations = [];

    final apiKey = dotenv.env['TRIP_API'];

    const String baseUrl =
        'https://api.content.tripadvisor.com/api/v1/location/search';

    final String url =
        '$baseUrl?key=$apiKey&searchQuery=Asia&category=$category&language=en';

    final Map<String, String> headers = {
      'accept': 'application/json',
    };
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      CategoryApiResponse apiResponse = CategoryApiResponse.fromJson(jsonResponse);
      locations =  apiResponse.data;
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
    }
    return locations;
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
      print('Error: ${response.statusCode}, ${response.body}');
    }
    return locations;
  }

  static Future<PhotosApiResponseModel?> getLocationPhotos({required String locationID}) async{

    final apiKey = dotenv.env['TRIP_API'];
    const String baseUrl = 'https://api.content.tripadvisor.com/api/v1/location';
    final String url =
        '$baseUrl/$locationID/photos?key=$apiKey&language=en&currency=USD';

    final Map<String, String> headers = {
      'accept': 'application/json',
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      PhotosApiResponseModel photosApiResponseModel = PhotosApiResponseModel.fromJson(jsonResponse);
      return photosApiResponseModel;
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
    }
    return null;
  }

  static Future<ReviewResponse?> getLocationReviews({required String locationID}) async{

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
      ReviewResponse reviewResponse = ReviewResponse.fromJson(jsonResponse);
      return reviewResponse;
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
    }
    return null;
  }
}