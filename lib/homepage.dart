import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   Position _currentPosition;

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
                _writeMyLocationToFile(_currentPosition.toString());
                _readMyLocationFromFile().then((location){
                  log("Written location to file"+ location);
                });

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




   Future<String> get _localPath async {
     final directory = await getApplicationDocumentsDirectory();
     return directory.path;
   }

   Future<File> get _localFile async {
     final path = await _localPath;
     return File('$path/mylocation.txt');
   }

   Future<File> _writeMyLocationToFile(String locationString) async {
     final file = await _localFile;
     // Write the file.
     return file.writeAsString('$locationString');
   }

   Future<String> _readMyLocationFromFile() async {
     try {
       final file = await _localFile;

       // Read the file.
       String contents = await file.readAsString();

       return contents;
     } catch (e) {
       // If encountering an error, return 0.
       return null;
     }
   }
}
