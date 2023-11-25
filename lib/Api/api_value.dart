import 'package:retro_netflix/Api/Dio/dio_client.dart';
import 'package:retro_netflix/SharedPrefrences/sharedprefrences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiValue {
  static String BASE_URL = "https://api.tvmaze.com/";

  //==========================================Movies APIs==================================================

  static String showsURL = "search/shows";
  static String allShowsURL = 'schedule';

  final DioClinet _dioClinet = DioClinet.instance;

  Future<dynamic> AllShows() async {
    dynamic data = {
      'country': SharedPreferencesHelper.getCountryCode() ?? 'US',
      'date': DateTime.now().toString().substring(0, 10),
    };

    try {
      Response response =
          await _dioClinet.dio!.get(allShowsURL, queryParameters: data);

      if (response.statusCode == 200) {
        // Successful response
        return response.data;
      } else {
        // Show error toast
        Fluttertoast.showToast(
          msg: "Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Return null or handle the error as needed
        return null;
      }
    } catch (error) {
      // Show error toast for network or other errors
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Return null or handle the error as needed
      return null;
    }
  }

  Future<dynamic> AllSearchShows() async {
    dynamic data = {
      'q': 'all',
      'country': SharedPreferencesHelper.getCountryCode() ?? 'IN',
    };

    try {
      Response response =
          await _dioClinet.dio!.get(showsURL, queryParameters: data);

      if (response.statusCode == 200) {
        // Successful response
        return response.data;
      } else {
        // Show error toast
        Fluttertoast.showToast(
          msg: "Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Return null or handle the error as needed
        return null;
      }
    } catch (error) {
      // Show error toast for network or other errors
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Return null or handle the error as needed
      return null;
    }
  }

  Future<dynamic> SearchAllShows(String search) async {
    dynamic data = {
      'q': search,
      'country': SharedPreferencesHelper.getCountryCode() ?? 'IN',
    };

    try {
      Response response =
          await _dioClinet.dio!.get(showsURL, queryParameters: data);

      if (response.statusCode == 200) {
        // Successful response
        return response.data;
      } else {
        // Show error toast
        Fluttertoast.showToast(
          msg: "Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Return null or handle the error as needed
        return null;
      }
    } catch (error) {
      // Show error toast for network or other errors
      Fluttertoast.showToast(
        msg: "Something went wrong.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Return null or handle the error as needed
      return null;
    }
  }
}
