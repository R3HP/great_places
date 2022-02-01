import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;

class MyMap extends StatefulWidget {
  late double initialLat;
  late double initialLong;
  bool _isUsedAsPic;
  Function? setter;
  MyMap(this.initialLat, this.initialLong, this._isUsedAsPic, [this.setter]);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  latlong.LatLng? destiantion;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          allowPanning: widget._isUsedAsPic ? false : true,
          onTap: (latlng) {
            if (!widget._isUsedAsPic) {

              setState(() {
                destiantion = latlng;
              });
              widget.setter!(latlng.latitude,latlng.longitude);
            }
          },
          center: latlong.LatLng(widget.initialLat, widget.initialLong),
          zoom: 12),
      layers: [
        TileLayerOptions(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/r3zahp/cksn7avd6119t18lkyvfydz84/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicjN6YWhwIiwiYSI6ImNrYnhmc2JhbzA1bTAyc3Fubm5paHZqd2sifQ.kiQxWPBep95bN00r41U7Rg',
            additionalOptions: {
              'access_token':
                  'pk.eyJ1IjoicjN6YWhwIiwiYSI6ImNrYnhmc2JhbzA1bTAyc3Fubm5paHZqd2sifQ.kiQxWPBep95bN00r41U7Rg',
              'id': 'mapbox.mapbox-streets-v8'
            }),
        MarkerLayerOptions(markers: [
          Marker(
              point: latlong.LatLng(widget.initialLat, widget.initialLong),
              builder: (ctx) => Icon(
                    Icons.stay_current_portrait,
                    color: Colors.blue,
                  )),
          if (!widget._isUsedAsPic && destiantion != null)
            Marker(
                point: destiantion!,
                builder: (ctx) => Icon(
                      Icons.place,
                      color: Colors.red,
                    ))
        ])
      ],
    );
  }
}
