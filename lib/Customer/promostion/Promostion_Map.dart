import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Promostion_Map extends StatefulWidget {
  @override
  _Promostion_MapState createState() => _Promostion_MapState();
}

class _Promostion_MapState extends State<Promostion_Map> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(13.7563, 100.5018); // พิกัดของกรุงเทพ
  final LatLng _location =
      const LatLng(13.7563, 100.5018); // ตำแหน่งที่ต้องการแสดง
  late Marker _marker;

  @override
  void initState() {
    super.initState();
    _marker = Marker(
      markerId: MarkerId('location_marker'),
      position: _location,
      infoWindow: InfoWindow(
        title: 'ตำแหน่งที่ระบุ',
        snippet: 'คลิกเพื่อเปิดใน Google Maps',
      ),
      onTap: () => _launchMapsUrl(_location),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _launchMapsUrl(LatLng location) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 120,
      width: double.infinity,
      color: const Color.fromARGB(255, 21, 130, 144),
      child: Column(children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: {_marker},
              mapType: MapType.normal,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          ),
        ),
      ]),
    );
  }
}
