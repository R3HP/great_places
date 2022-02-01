import 'package:flutter/material.dart';
import 'package:great_places/Model/place.dart';
import 'package:great_places/Model/place_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceListItemWidget extends StatelessWidget {
  final Place place;
  PlaceListItemWidget(this.place);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.title),
      leading: CircleAvatar(backgroundImage: FileImage(place.imageFile),),
      subtitle: Text(place.location.address),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: () async {
              final response = await Provider.of<PlaceManager>(context,listen: false).deletePlace(place);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$response item\'s got deleted')));
            }, icon: Icon(Icons.delete)),
            IconButton(onPressed: () async {
              if(await canLaunch('geo:${place.location.latitude},${place.location.longitude}')){
              await launch('geo:${place.location.latitude},${place.location.longitude}');
              }else{
                throw 'errrr';
              }
              
            }, icon: Icon(Icons.navigation)),],
        ),
      ),
    );  
  }
}