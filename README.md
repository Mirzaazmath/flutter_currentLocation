# current_location

<img src="https://github.com/Mirzaazmath/flutter_currentLocation/blob/main/assets/rsult.png" height="400">

A new Flutter project.

Readme
Changelog
Example
Installing
Versions
Scores
Flutter Geolocator Plugin
pub package Build status style: effective dart codecov

A Flutter geolocation plugin which provides easy access to platform specific location services (FusedLocationProviderClient or if not available the LocationManager on Android and CLLocationManager on iOS).

Features
Get the last known location;
Get the current location of the device;
Get continuous location updates;
Check if location services are enabled on the device;
Calculate the distance (in meters) between two geocoordinates;
Calculate the bearing between two geocoordinates;
IMPORTANT:

Version 7.0.0 of the geolocator plugin contains several breaking changes, for a complete overview please have a look at the Breaking changes in 7.0.0 wiki page.

Starting from version 6.0.0 the geocoding features (placemarkFromAddress and placemarkFromCoordinates) are no longer part of the geolocator plugin. We have moved these features to their own plugin: geocoding. This new plugin is an improved version of the old methods.

Usage
To add the geolocator to your Flutter application read the install instructions. Below are some Android and iOS specifics that are required for the geolocator to work correctly.

Android
Upgrade pre 1.12 Android projects

Since version 5.0.0 this plugin is implemented using the Flutter 1.12 Android plugin APIs. Unfortunately this means App developers also need to migrate their Apps to support the new Android infrastructure. You can do so by following the Upgrading pre 1.12 Android projects migration guide. Failing to do so might result in unexpected behaviour.

AndroidX

The geolocator plugin requires the AndroidX version of the Android Support Libraries. This means you need to make sure your Android project supports AndroidX. Detailed instructions can be found here.

The TL;DR version is:

Add the following to your "gradle.properties" file:
android.useAndroidX=true
android.enableJetifier=true
Make sure you set the compileSdkVersion in your "android/app/build.gradle" file to 33:
android {
compileSdkVersion 33

...
}
Make sure you replace all the android. dependencies to their AndroidX counterparts (a full list can be found here: Migrating to AndroidX).
Permissions

On Android you'll need to add either the ACCESS_COARSE_LOCATION or the ACCESS_FINE_LOCATION permission to your Android Manifest. To do so open the AndroidManifest.xml file (located under android/app/src/main) and add one of the following two lines as direct children of the <manifest> tag (when you configure both permissions the ACCESS_FINE_LOCATION will be used by the geolocator plugin):

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
Starting from Android 10 you need to add the ACCESS_BACKGROUND_LOCATION permission (next to the ACCESS_COARSE_LOCATION or the ACCESS_FINE_LOCATION permission) if you want to continue receiving updates even when your App is running in the background (note that the geolocator plugin doesn't support receiving and processing location updates while running in the background):

<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
NOTE: Specifying the ACCESS_COARSE_LOCATION permission results in location updates with an accuracy approximately equivalent to a city block. It might take a long time (minutes) before you will get your first locations fix as ACCESS_COARSE_LOCATION will only use the network services to calculate the position of the device. More information can be found here.




iOS
On iOS you'll need to add the following entries to your Info.plist file (located under ios/Runner) in order to access the device's location. Simply open your Info.plist file and add the following (make sure you update the description so it is meaningfull in the context of your App):

<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location when in the background.</string>
If you would like to receive updates when your App is in the background, you'll also need to add the Background Modes capability to your XCode project (Project > Signing and Capabilities > "+ Capability" button) and select Location Updates. Be careful with this, you will need to explain in detail to Apple why your App needs this when submitting your App to the AppStore. If Apple isn't satisfied with the explanation your App will be rejected.

When using the requestTemporaryFullAccuracy({purposeKey: "YourPurposeKey"}) method, a dictionary should be added to the Info.plist file.

<key>NSLocationTemporaryUsageDescriptionDictionary</key>
<dict>
<key>YourPurposeKey</key>
<string>The example App requires temporary access to the device&apos;s precise location.</string>
</dict>
The second key (in this example called YourPurposeKey) should match the purposeKey that is passed in the requestTemporaryFullAccuracy() method. It is possible to define multiple keys for different features in your app. More information can be found in Apple's documentation.
