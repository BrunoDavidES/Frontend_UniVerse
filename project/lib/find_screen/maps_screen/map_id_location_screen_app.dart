import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:UniVerse/utils/locations/locations.dart' as locations;

import '../../consts/color_consts.dart';

class MapIdLocationApp extends StatefulWidget {
  final String? id;

  const MapIdLocationApp({super.key, this.id});

  @override
  State<MapIdLocationApp> createState() => _MapsAppState();
}

class _MapsAppState extends State<MapIdLocationApp> {
  final Map<String, Marker> _markers = {};
  GoogleMapController? controller;
  LatLngBounds mapBounds = LatLngBounds(
    southwest: LatLng(38.655, -9.215),
    northeast: LatLng(38.665, -9.195),
  );

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final fctplaces = await locations.getFCTplaces();
    setState(() {
      _markers.clear();
        var place = fctplaces.places.where((element) => element.id == widget.id!).first;
        var marker = Marker(
          //icon: markerIcon,
          markerId: MarkerId(place.name),
          position: LatLng(place.lat, place.lng),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.address,
          ),
        );
        _markers[place.name] = marker;
    });
    this.controller = controller;
  }

  void _checkBoundaries(LatLng target) {
    if (!mapBounds.contains(target)) {
      controller?.animateCamera(
        CameraUpdate.newLatLng(LatLng(38.660992, -9.205782)),
      );
    }
  }

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  @override
  void initState() {
    //addCustomIcon();
    super.initState();
  }

  /*void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(20, 30)), "assets/images/marker.png")
        .then(
          (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
        extendBodyBehindAppBar: true,
        body:GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(38.660992, -9.205782),
            zoom: 17,
          ),
          markers: _markers.values.toSet(),
          onCameraMove: (CameraPosition position) {
            _checkBoundaries(position.target);
          },
          minMaxZoomPreference: const MinMaxZoomPreference(12, 18),
        ),
      ),
      IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {Navigator.pop(context);},
          color: cDarkBlueColor)
      ]
    );
  }
}