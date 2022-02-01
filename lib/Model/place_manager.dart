import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:great_places/Model/place.dart';
import 'package:great_places/Util/database_util.dart';

class PlaceManager with ChangeNotifier {
  List<Place> _myPlaces = [];

  List<Place> get myPlaces {
    return List<Place>.from(_myPlaces);
  }

  void addPlace(Place place) {
    _myPlaces.add(place);
    notifyListeners();
  }

  Future<void> initial() async {
    final response = await DBHelper.getAll();
    _myPlaces = [];
    response.forEach((element) {
      _myPlaces.add(
        Place(
            title: element['title'],
            imageFile: File(element['image']),
            location: MyLocation(
                latitude: element['loc_lat'],
                longitude: element['loc_long'],
                address: element['address']),
            id: element['_id']),
      );
    });
    notifyListeners();
  }

  Future<int> deletePlace(Place place) async {
    try{
      final response = await DBHelper.delete(place.id ?? 0);
      _myPlaces.remove(place);
      notifyListeners();
      return response;
    }catch (error){
      throw error;
    }
  }
}
