import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:UniVerse/utils/locations/locations.dart' as locations;

import '../../consts/color_consts.dart';

class MapApp extends StatefulWidget {

  const MapApp({super.key});

  @override
  State<MapApp> createState() => _MapsAppState();
}

class _MapsAppState extends State<MapApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
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
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          leadingWidth: 20,
          leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: cDarkBlueColorTransparent);
              }
          ),
          title: Image.asset("assets/app/map.png", scale: 6),
          backgroundColor: cDirtyWhiteColorNoOps,
        ),
        body: GoogleMap(
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(38.660992, -9.205782),
            zoom: 16,
          ),
          markers: _markers.values.toSet(),
        ),
      );
    }
  }