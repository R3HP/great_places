import 'dart:io';

class Place {
  int? id;
  final String title;
  final File imageFile;
  final MyLocation location;
  Place({this.id,required this.title,required this.imageFile,required this.location});
}

class MyLocation {
  final double latitude;
  final double longitude;
  final String address;

  MyLocation({required this.latitude,required this.longitude, this.address = ''});

}