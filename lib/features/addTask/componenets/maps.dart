import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:itsale/core/components/default_app_bar.dart';
import 'package:itsale/core/constants/app_fonts.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng _currentPosition = LatLng(30.0444, 31.2357); // Default to Cairo
  final MapController _mapController = MapController();
  String _address = "ابحث او حدد المكان";
  double _zoom = 15.0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchPlace(String place) async {
    try {
      List<Location> locations = await locationFromAddress(place);
      if (locations.isNotEmpty) {
        final location = locations.first;
        final latLng = LatLng(location.latitude, location.longitude);
        if (!mounted) return;
        setState(() {
          _currentPosition = latLng;
        });
        _mapController.move(latLng, _zoom);
        await _getAddressFromLatLng(latLng.latitude, latLng.longitude);
      }
    } catch (e) {
      debugPrint("Error fetching location: $e");
      if (!mounted) return;
      setState(() {
        _address = "تعذر العثور على الموقع المدخل";
      });
    }
  }

  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'itsale-app/1.0 (your-email@example.com)',
          // REQUIRED by Nominatim
        },
      );

      if (!mounted) return;

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
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _address = "حدث خطأ أثناء جلب العنوان";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0.0,
        leading: Container(),
        title: const CustomAppBar(back: true, title: 'اختر مكان المهمة'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: _searchPlace,
              decoration: InputDecoration(
                labelText: 'ابحث عن مكان',
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
                onTap: (tapPosition, point) async {
                  if (!mounted) return;
                  setState(() {
                    _currentPosition = point;
                  });
                  await _getAddressFromLatLng(point.latitude, point.longitude);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.itsale',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition,
                      width: 40.0,
                      height: 40.0,
                      child: const Icon(
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
                const Text(
                  "العنوان:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(_address, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      "latitude": _currentPosition.latitude,
                      "longitude": _currentPosition.longitude,
                      "address": _address,
                    });
                  },
                  child: Text("تأكيد الموقع", style: AppFonts.style14normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
