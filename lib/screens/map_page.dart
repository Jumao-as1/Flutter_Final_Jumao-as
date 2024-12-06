import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Directors Map')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(34.0522, -118.2437), // Los Angeles
          zoom: 10,
        ),
        markers: {
          Marker(markerId: MarkerId('tarantino'), position: LatLng(34.0522, -118.2437)),
        },
      ),
    );
  }
}
