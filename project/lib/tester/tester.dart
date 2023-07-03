import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  Set<Marker> markers = Set<Marker>();
  Set<Polyline> polylines = Set<Polyline>();
  Marker? selectedMarker1;
  Marker? selectedMarker2;

  final LatLng initialLocation = LatLng(38.660992, -9.205782);

  LatLngBounds mapBounds = LatLngBounds(
    southwest: LatLng(38.655, -9.215), // Lower left corner of the desired bounds
    northeast: LatLng(38.665, -9.195), // Upper right corner of the desired bounds
  );

  @override
  void initState() {
    super.initState();
    _addMarkersAroundArea();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialLocation,
              zoom: 17,
            ),
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            markers: markers,
            polylines: polylines,
            onTap: (LatLng position) {
              _addMarker(position);
            },
            onCameraMove: (CameraPosition position) {
              // Check if the new camera target is within the desired bounds
              if (!mapBounds.contains(position.target)) {
                // Move the camera back to the last valid position within the bounds
                mapController?.animateCamera(
                  CameraUpdate.newLatLng(LatLng(38.660992, -9.205782)),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () {
                  _connectMarkers();
                },
                child: Icon(Icons.link),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addMarker(LatLng position) {
    if (selectedMarker1 == null) {
      final newMarker = Marker(
        markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
        position: position,
        infoWindow: InfoWindow(title: 'Marker ${markers.length + 1}'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );

      setState(() {
        selectedMarker1 = newMarker;
        markers.add(newMarker);
      });
    } else if (selectedMarker2 == null) {
      final newMarker = Marker(
        markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
        position: position,
        infoWindow: InfoWindow(title: 'Marker ${markers.length + 1}'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      setState(() {
        selectedMarker2 = newMarker;
        markers.add(newMarker);
      });
    }
  }

  void _connectMarkers() {
    if (selectedMarker1 != null && selectedMarker2 != null) {
      final selectedPosition1 = selectedMarker1!.position;
      final selectedPosition2 = selectedMarker2!.position;

      setState(() {
        polylines.clear();

        polylines.add(
          Polyline(
            polylineId: PolylineId('connection'),
            points: [selectedPosition1, selectedPosition2],
            color: Colors.blue,
            width: 3,
          ),
        );
      });
    }
  }

  void _addMarkersAroundArea() {
    final List<LatLng> markerPositions = [
      LatLng(38.657, -9.205),
      LatLng(38.663, -9.210),
      LatLng(38.661, -9.200),
    ];

    for (int i = 0; i < markerPositions.length; i++) {
      final newMarker = Marker(
        markerId: MarkerId('Marker $i'),
        position: markerPositions[i],
        infoWindow: InfoWindow(title: 'Marker $i'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      setState(() {
        markers.add(newMarker);
      });
    }
  }
}