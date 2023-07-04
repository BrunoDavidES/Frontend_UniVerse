import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:UniVerse/utils/locations/locations.dart' as locations;

class MapsPageWeb extends StatefulWidget {

  const MapsPageWeb({super.key});

  @override
  State<MapsPageWeb> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPageWeb> {
  final Map<String, Marker> _markers = {};
  GoogleMapController? controller;
  Future<void> _onMapCreated(controller) async {
    final fctplaces = await locations.getFCTplaces();
    setState(() {
      _markers.clear();
      for (final place in fctplaces.places) {
        final marker = Marker(
          markerId: MarkerId(place.name),
          position: LatLng(place.lat, place.lng),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.address,
          ),
        );
        _markers[place.name] = marker;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target:  LatLng(38.660992, -9.205782),
            zoom: 16,
          ),
          markers: _markers.values.toSet(),
          onCameraMove: (CameraPosition position) {
            // Check if the new camera target is within the desired bounds
            if (!mapBounds.contains(position.target)) {
              // Move the camera back to the last valid position within the bounds
              controller?.animateCamera(
                CameraUpdate.newLatLng(LatLng(38.660992, -9.205782)),
              );
            }
          },
        ),
      ),
    );
  }
  LatLngBounds mapBounds = LatLngBounds(
    southwest: LatLng(38.655, -9.215), // Lower left corner of the desired bounds
    northeast: LatLng(38.665, -9.195), // Upper right corner of the desired bounds
  );
  }
