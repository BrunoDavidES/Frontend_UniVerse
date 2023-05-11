import 'package:UniVerse/find_screen/services_screen/services_body_app.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../consts.dart';

class MapsPageApp extends StatefulWidget {

  const MapsPageApp({super.key});

  @override
  State<MapsPageApp> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPageApp> {

  late GoogleMapController mapController;
  final LatLng center = const LatLng(38.661079, -9.205108);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: cDirtyWhiteColor,
        ),
        child: GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: CameraPosition(
            target: center,
            zoom:11.0
          ),
        )
      ),
    );
  }
}