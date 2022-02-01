import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/Model/place.dart';
import 'package:great_places/Model/place_manager.dart';
import 'package:great_places/Util/database_util.dart';
import 'package:great_places/View/Widget/image_field.dart';
import 'package:great_places/View/Widget/location_field.dart';
import 'package:provider/provider.dart';

class AddPlacePage extends StatelessWidget {
  static const NameRoute = '/addPlaces';
  var _controller = TextEditingController();
  File? imageFile;
  MyLocation? myLocation;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Place'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Title',
                  contentPadding: EdgeInsets.all(7),
                  icon: Icon(Icons.title),
                ),
              ),
              ImageField(setFile),
              LocationField(setLocation),
              ElevatedButton.icon(
                  onPressed: () =>_savePlace(context),
                  icon: Icon(Icons.save_alt),
                  label: Text('Save Place'),
                ),
              
            ],
          ),
        ),
      ),
    );
  }

  void _savePlace(BuildContext context) {
    if (imageFile == null || _controller.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An Error Occured')));
      return;
    }
    var place = Place(title: _controller.text, imageFile: imageFile!, location: myLocation!);
    DBHelper.insert(place).then((value) {
      place.id = value;
      Provider.of<PlaceManager>(context,listen: false).addPlace(place);
      Navigator.of(context).pop();
    });
  }

  void setLocation(MyLocation location){
    myLocation = location;
  }
  void setFile(File image) {
    imageFile = image;
  }
}
