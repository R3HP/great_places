import 'package:flutter/material.dart';
import 'package:great_places/Model/place_manager.dart';
import 'package:great_places/View/Screen/add_places.dart';
import 'package:great_places/View/Widget/place_list_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Great Places'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlacePage.NameRoute);
              },
              icon: Icon(Icons.add))
        ],
      ),
      // body: Consumer<PlaceManager>(
      //     builder: (ctx, placeManager, child) => placeManager.myPlaces.isEmpty
      //         ? child!
      //         : ListView.separated(
      //             separatorBuilder: (ctx, index) => Divider(),
      //             itemCount: placeManager.myPlaces.length,
      //             itemBuilder: (ctx, index) =>
      //                 PlaceListItemWidget(placeManager.myPlaces[index])),
      //     // builder: (ctx,placeManager,chi) => placeManager.myPlaces.isEmpty ? chi! : ListView(),
      //     child: Center(
      //       child: Text('nothing yet'),
      //     ),
      //   ),
      body: FutureBuilder(
        future: Provider.of<PlaceManager>(context, listen: false).initial(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlaceManager>(
                builder: (ctx, placeManager, child) => placeManager
                        .myPlaces.isEmpty
                    ? RefreshIndicator(
                      onRefresh: placeManager.initial,
                      child: child!)
                    : RefreshIndicator(
                      onRefresh: placeManager.initial,
                      child: ListView.separated(
                          separatorBuilder: (ctx, index) => Divider(),
                          itemCount: placeManager.myPlaces.length,
                          itemBuilder: (ctx, index) =>
                              PlaceListItemWidget(placeManager.myPlaces[index])),
                    ),
                // builder: (ctx,placeManager,chi) => placeManager.myPlaces.isEmpty ? chi! : ListView(),
                child: Center(
                  child: Text('nothing yet'),
                ),
              ),
      ),
    );
  }
}
