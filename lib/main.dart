import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Current location'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool ispressed=false;
  var longitude="longitude";
  var latitude="latitude";
  var address="address";
  late StreamSubscription<Position> streamSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getcurrentlocation();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child:Text(address),
      ), );
  }
// here we are call get current location method
  void _getcurrentlocation()async{
    // here we are create a bool to check the service
    bool serviceEnabled;
    LocationPermission permission;
    // here we are checking service is on or not
    serviceEnabled= await Geolocator.isLocationServiceEnabled();
    // if not then ask user for permission
    if(!serviceEnabled){
      await Geolocator.openLocationSettings();
      return Future.error("Location Services are disabled");
    }
    permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission== LocationPermission.denied){
        return Future.error("Location permission are denied");
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error("Location permissions are permanently denied");
    }
    streamSubscription=Geolocator.getPositionStream().listen((Position position) {
      latitude="latitude ${position.latitude}";
      longitude="longitude${position.longitude}";
      getaddressfromlanlong(position);
    });


  }
  getaddressfromlanlong(Position position)async{


    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
    Placemark place=placemarks[0];
    setState(() {
      address='locality: ${place.locality},\n country:${place.country},\n name : ${place.name},\n admistrative area: ${place.administrativeArea}, \n isocountrycode; ${place.isoCountryCode},\nstreet: ${place.street},\n postalcode: ${place.postalCode},\n subAdministrativeArea : ${place.subAdministrativeArea},\n subLocality : ${place.subLocality},\n  thoroughfare : ${place.thoroughfare}';
    });
  }
}
