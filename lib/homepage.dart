import 'dart:developer';

import 'package:coronaantivirus/filehandler.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   Position _currentPosition;
   FileHandler fileHandler = new FileHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if(_currentPosition != null)
              Text("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                // Get location here
                log("Write my location to file");
                _getCurrentLocation();
                fileHandler.writeMyLocationToFile(_currentPosition.toString());
                fileHandler.readMyLocationFromFile().then((location){
                  log("Written location to file"+ location);
                });

              },
            ),
            FlatButton(
              child: Text("Save file to server"),
              onPressed: () {
                // Save file to server
              },
            ),
          ],
        ),
      ),
    );
  }

   _getCurrentLocation() {
     final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

     geolocator
         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
         .then((Position position) {
       setState(() {
         _currentPosition = position;
       });
     }).catchError((e) {
       print(e);
     });
   }


}
