import 'package:flutter/material.dart';
import 'package:great_places/Model/place.dart';
import 'package:great_places/Util/location_util.dart';
import 'package:great_places/View/Widget/my_map.dart';
import 'package:great_places/main.dart';
import 'package:latlong2/latlong.dart' as latlong ;

class MapScreen extends StatelessWidget {

  double? latitude;
  double? longitude;

  void setDestination(double lat,double long){
    latitude = lat;
    longitude = long;
  }


  
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: LocationHelper.getLocationData(),
      builder: (ctx,locationSnapshot) => locationSnapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator(),) : Scaffold(
        appBar: AppBar(
          title: Text('Select Your Location'),
          primary: true,
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).pop<latlong.LatLng>(latlong.LatLng(latitude!,longitude!));
            }, icon: Icon(Icons.check))
          ],
    
        ),
        body: MyMap((locationSnapshot.data as MyLocation).latitude, (locationSnapshot.data as MyLocation).longitude, false,setDestination),
      ),
    );
  }
}