import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng _currentPosition = LatLng(30.0444, 31.2357); // Default Cairo
  final MapController _mapController = MapController();
  String _address = "ابحث أو حدد المكان";
  double _zoom = 15.0;
  final TextEditingController _searchController = TextEditingController();
  int? _locationId;

  Future<void> _searchPlace(String place) async {
    try {
      List<Location> locations = await locationFromAddress(place);
      if (locations.isNotEmpty) {
        setState(() {
          _currentPosition =
              LatLng(locations.first.latitude, locations.first.longitude);
          _mapController.move(_currentPosition, _zoom);
        });
        _getAddressAndLocationId(
            locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<void> _getAddressAndLocationId(double lat, double lng) async {
    try {
      final response = await http.get(Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _address = data['display_name'] ?? 'عنوان غير متوفر';
        });
      }

      // Call your backend to get locationId
      final locationRes = await http.post(
        Uri.parse("https://your-api.com/api/location-lookup"),
        body: jsonEncode({"latitude": lat, "longitude": lng}),
        headers: {"Content-Type": "application/json"},
      );
      if (locationRes.statusCode == 200) {
        final locData = json.decode(locationRes.body);
        _locationId = locData["id"];
      }
    } catch (e) {
      print("Error getting locationId or address: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختر مكان المهمة')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: _searchPlace,
              decoration: InputDecoration(
                labelText: 'ابحث عن المكان',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchPlace(_searchController.text),
                ),
              ),
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentPosition,
                initialZoom: _zoom,
                onTap: (tapPosition, point) {
                  setState(() {
                    _currentPosition = point;
                  });
                  _getAddressAndLocationId(point.latitude, point.longitude);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.yourapp',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition,
                      width: 40.0,
                      height: 40.0,
                      child: const Icon(Icons.location_pin,
                          color: Colors.red, size: 40),
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
                const Text("العنوان:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_address, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      "latitude": _currentPosition.latitude,
                      "longitude": _currentPosition.longitude,
                      "address": _address,
                      "locationId": _locationId,
                    });
                  },
                  child: const Text("تأكيد الموقع"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
