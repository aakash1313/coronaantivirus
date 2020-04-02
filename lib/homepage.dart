import 'dart:developer';

import 'package:coronaantivirus/background_location.dart';
import 'package:coronaantivirus/filehandler.dart';
import 'package:coronaantivirus/mapwidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   FileHandler fileHandler = new FileHandler();

   @override
   void initState() {
     super.initState();
     new BackgroundLocation().initializeBackgroundService();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
         child: Text("Corona Antivirus"),
      ),
      ),
      body: Builder(
        builder: (context) =>Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: new GoogleMapWidget(),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.red)),
                        child: Text("Start Scanning"),
                        onPressed: () {
                          // Get location here
                          fileHandler.readMyLocationFromFile().then((location){
                            print("Written location to file"+ location);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.red)),
                        child: Text("I got covid, save others"),
                        onPressed: () {
                          // Get location here
                          fileHandler.readMyLocationFromFile().then((location){
                            print("Written location to file"+ location);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Text("We will not share your location without your consent"),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
