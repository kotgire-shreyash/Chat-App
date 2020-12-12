import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Geolocation_page extends StatefulWidget {
  @override
  _Geolocation_pageState createState() => _Geolocation_pageState();
}

class _Geolocation_pageState extends State<Geolocation_page> {
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController _controller;
    var la;
    var lo;

    gpstrial() async {
      print("hii 1");
      Position position = await Geolocator.getCurrentPosition();
      la = position.latitude;
      lo = position.longitude;
      print("hii");
      print(position);
    }

    void _onMapCreated(GoogleMapController controller) {
      if (_controller == null) _controller = controller;
    }

    return Scaffold(
      appBar: AppBar(title: Text("GPS ")),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(250.0, 150.0),
          zoom: 14.55,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: gpstrial,
        child: Icon(Icons.add),
      ),
    );
  }
}
