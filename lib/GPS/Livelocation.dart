import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'staticVars.dart';

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
      Position position = await Geolocator().getCurrentPosition();
      la = position.latitude;
      lo = position.longitude;
      print("hii");
      print(position);
      await staticVars.fsconnect
          .collection("user")
          .doc("ids")
          .collection("user-ids")
          .doc("${staticVars.username}")
          .update({"latitude": la, "longitude": lo});
    }

    void _onMapCreated(GoogleMapController controller) {
      if (_controller == null) _controller = controller;
    }

    return Scaffold(
      appBar: AppBar(title: Text("GPS ")),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(staticVars.lat, staticVars.long),
          zoom: 14.55,
          tilt: 50,
        ),
        mapType: MapType.hybrid,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: gpstrial,
        child: Icon(Icons.add),
      ),
    );
  }
}
