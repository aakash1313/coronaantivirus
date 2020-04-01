import 'package:coronaantivirus/filehandler.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as  bg;

class BackgroundLocation {

  void initializeBackgroundService() {

    FileHandler fileHandler = new FileHandler();
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
}