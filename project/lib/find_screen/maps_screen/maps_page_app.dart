
import 'package:UniVerse/find_screen/maps_screen/maps_for_web.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:UniVerse/utils/locations/locations.dart' as locations;

import '../../bars/app_bar.dart';
import '../../consts/color_consts.dart';
import 'maps_body_app.dart';

class MapsPageApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
          children: <Widget>[
            MapApp(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:1),
            )
          ],
        );
  }

  /*@override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target:  LatLng(38.660992, -9.205782),
            zoom: 16,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }*/
}