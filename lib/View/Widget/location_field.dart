import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:great_places/Model/place.dart';
import 'package:great_places/Util/location_util.dart';
import 'package:great_places/View/Screen/map_screen.dart';
import 'package:great_places/View/Widget/my_map.dart';
import 'package:latlong2/latlong.dart' as latlong;

class LocationField extends StatefulWidget {
  Function setloc;

  LocationField(this.setloc);

  @override
  _LocationFieldState createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  latlong.LatLng? _currentLocation;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey),
          ),
          child: _currentLocation == null
              ? Center(
                  child: Text.rich(TextSpan(text: 'No Location Yet')),
                )
              // : Image.network(
              //     _currentLocationImageUrl!,
              //     fit: BoxFit.cover,
              //   ),
              : MyMap(_currentLocation!.latitude, _currentLocation!.longitude,
                  true),
        ),
        Row(
          children: [
            TextButton.icon(
                onPressed: () async {
                  final myLocation = await LocationHelper.getLocationData();
                  if (myLocation == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('my location is null')));
                    return;
                  }
                  print(
                      '${myLocation.latitude},${myLocation.longitude},${myLocation.address}');
                  _currentLocation =
                      latlong.LatLng(myLocation.latitude, myLocation.longitude);
                  setState(() {});
                  widget.setloc(myLocation);
                },
                icon: Icon(Icons.gps_fixed),
                label: Text('Use Current Location')),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => MapScreen()))
                      .then((value) async {
                    final adresses = await Geocoder.local
                        .findAddressesFromCoordinates(Coordinates(
                            (value as latlong.LatLng).latitude,
                            (value as latlong.LatLng).longitude));
                    final myAddress = adresses.first.addressLine;
                    setState(() {
                      _currentLocation = (value as latlong.LatLng);
                    });
                    widget.setloc(MyLocation(latitude: _currentLocation!.latitude, longitude: _currentLocation!.longitude,address: myAddress!));
                  });
                },
                icon: Icon(Icons.map),
                label: Text('Select On Map')),
          ],
        )
      ],
    );
  }
}
