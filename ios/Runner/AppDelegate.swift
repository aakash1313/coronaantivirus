import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    //For google maps
    [GMSServices provideAPIKey: @"AIzaSyADKK2bxntJ5TRRla6MpyTdPudCxaBcnLg"];
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
