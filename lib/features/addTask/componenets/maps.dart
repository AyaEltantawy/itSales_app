import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:itsale/core/components/default_app_bar.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng _currentPosition = LatLng(30.0444, 31.2357); // Default to Cairo
  MapController _mapController = MapController();
  String _address = "ابحث او حدد المكان";
  double _zoom = 15.0; // Default zoom level
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //  _getCurrentLocation();

  }
  Future<void> _searchPlace(String place) async {
    try {
      List<Location> locations = await locationFromAddress(place);
      if (locations.isNotEmpty) {
        setState(() {
          _currentPosition = LatLng(locations.first.latitude, locations.first.longitude);
          _mapController.move(_currentPosition, _zoom);
          _getAddressFromLatLng(_currentPosition.latitude, _currentPosition.longitude);

        });
      }
    } catch (e) {
      print("Error fetching location: $e");
      // Handle error (e.g., show a message to the user)
    }
  }


  // Future<void> _getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   setState(() {
  //     _currentPosition = LatLng(position.latitude, position.longitude);
  //     _mapController.move(_currentPosition, _zoom);
  //     _getAddressFromLatLng(_currentPosition.latitude, _currentPosition.longitude);
  //
  //   });
  //    }

  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _address = data["display_name"] ?? "عنوان غير متوفر";
      });
    } else {
      setState(() {
        _address = "تعذر الحصول على العنوان";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 0.0,
          leading: Container(),
          title: const CustomAppBar(back: true, title: 'اختر مكان المهمة')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: (text)
              {
                _searchPlace(_searchController.text);

              },
              onEditingComplete: ()
              {
                _searchPlace(_searchController.text);

              },

              decoration: InputDecoration(
                labelText: 'Search for a place',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchPlace(_searchController.text);
                  },

                ),
              ),
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(

                // center: _currentPosition,
                // zoom: 15.0,
                initialCenter: _currentPosition ,
                initialZoom: _zoom,
                onTap: (tapPosition, point) {
                  setState(() {
                    _currentPosition = point;
                  });
                  _getAddressFromLatLng(point.latitude, point.longitude);
                },
              ),

              children : [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition,
                      width: 40.0,
                      height: 40.0,
                      child : const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "العنوان:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(_address, textAlign: TextAlign.center),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      "latitude": _currentPosition.latitude,
                      "longitude": _currentPosition.longitude,
                      "address": _address,
                    });
                  },
                  child: Text("تأكيد الموقع",style: AppFonts.style14normal,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}