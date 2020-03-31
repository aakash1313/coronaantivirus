import 'dart:developer';

import 'package:coronaantivirus/filehandler.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as  bg;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   Position _currentPosition;
   FileHandler fileHandler = new FileHandler();

   @override
   void initState() {
     super.initState();

     ////
     // 1. Listen to events.
     //

     // Fired whenever a location is recorded
    bg.BackgroundGeolocation.onLocation((bg.Location location){
       print('[location] - $location');
       fileHandler.writeMyLocationToFile(location.toString());
     });

    // Fired whenever the plugin changes motion-state (stationary -> moving and vice versa)
     bg.BackgroundGeolocation.onMotionChange((bg.Location location){
       print('[motionchange] - $location');
       fileHandler.writeMyLocationToFile(location.toString());
     });

     // Fired whenever the state of location-services changes. Always fired at boot
     bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event){
         print('[providechange] - $event');
         });

     //Let's configure the plugin

     bg.BackgroundGeolocation.ready(bg.Config(
       desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
       distanceFilter: 5.0,
       stopOnTerminate: false,
       heartbeatInterval: 300,
       startOnBoot: true,
       debug: true,
       logLevel: bg.Config.LOG_LEVEL_VERBOSE
     )).then((bg.State state) {
         if(!state.enabled){
            bg.BackgroundGeolocation.start();
         }

     });

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Builder(
        builder: (context) =>Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if(_currentPosition != null)
                Text("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
              FlatButton(
                child: Text("Get location"),
                onPressed: () {
                  // Get location here
                  fileHandler.readMyLocationFromFile().then((location){
                    print("Written location to file"+ location);
                  });
                },
              ),
              FlatButton(
                child: Text("Save file to server"),
                onPressed: () {
                  // Save file to server
                  fileHandler.uploadInfectedFileToServer(context);
                },
              ),
            ],
          ),
        ),
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
