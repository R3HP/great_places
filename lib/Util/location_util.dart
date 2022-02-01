// import 'package:geocoder/geocoder.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:great_places/Model/place.dart';
import 'package:location/location.dart';

class LocationHelper {
  static Future<MyLocation?> getLocationData() async {
    Location location = Location();
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }
    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    try{
    final _locationData = await location.getLocation();
    final adresses = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(_locationData.latitude, _locationData.longitude));
    final address = adresses.first.addressLine;
    print('${_locationData.latitude},${_locationData.longitude},$address');
    return MyLocation(latitude: _locationData.latitude!, longitude: _locationData.longitude! , address: address!);
    }catch (err){
      throw err;
    }
  }
}
