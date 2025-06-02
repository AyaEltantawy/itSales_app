import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class CompleteTask extends StatefulWidget {
  final int taskId;
  final String locationId;
  final String title;
  final String description;
  final String assign_to;
  final String clientName;
  final String clientPhone;
  final String notes;
  final String due_date;
  final String link; // رابط Google Maps مع إحداثيات
  final String address;

  const CompleteTask({
    super.key,
    required this.taskId,
    required this.locationId,
    required this.title,
    required this.description,
    required this.assign_to,
    required this.clientName,
    required this.clientPhone,
    required this.notes,
    required this.due_date,
    required this.link,
    required this.address,
  });

  @override
  State<CompleteTask> createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
  Position? _currentPosition;
  String? _currentAddress;
  bool isLoadingLocation = false;
  bool isLocationMatched = false;

  File? selectedImage;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showMessage('يرجى تفعيل خدمات الموقع');
      return false;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showMessage('تم رفض صلاحية الموقع');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _showMessage(
          'تم رفض صلاحية الموقع نهائيًا، الرجاء تعديل الإعدادات يدويًا');
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    if (!await _checkLocationPermission()) return;

    setState(() {
      isLoadingLocation = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
      await _updateAddressAndCheckMatch(position);
    } catch (e) {
      _showMessage('فشل في الحصول على الموقع الحالي');
      log(e.toString());
    } finally {
      setState(() {
        isLoadingLocation = false;
      });
    }
  }

  /// تحلل إحداثيات من رابط Google Maps بالشكل:
  /// https://www.google.com/maps/search/?api=1&query=lat,lng
  LatLng? _parseLatLngFromGoogleMapsLink(String link) {
    try {
      Uri uri = Uri.parse(link);
      String? query = uri.queryParameters['query'];
      if (query == null) return null;
      List<String> parts = query.split(',');
      if (parts.length != 2) return null;
      return LatLng(double.parse(parts[0]), double.parse(parts[1]));
    } catch (e) {
      log('Failed to parse latlng: $e');
      return null;
    }
  }

  Future<void> _updateAddressAndCheckMatch(Position position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isEmpty) {
        _showMessage('لم يتم العثور على العنوان من الموقع الحالي');
        setState(() => isLocationMatched = false);
        return;
      }

      Placemark place = placemarks.first;
      String addressString =
      '${place.street ?? ''}, ${place.name ?? ''}, ${place.subLocality ?? ''}, ${place.subAdministrativeArea ?? ''}, ${place.country ?? ''}'
          .replaceAll(RegExp(r',\s*,*'), ',')
          .trim();

      setState(() {
        _currentAddress = addressString;
      });

      // احصل على إحداثيات المهمة من الرابط
      LatLng? taskLatLng = _parseLatLngFromGoogleMapsLink(widget.link);

      if (taskLatLng == null) {
        // fallback to textual matching (اختياري)
        bool textMatch = widget.address
            .toLowerCase()
            .contains(place.street?.toLowerCase() ?? '') ||
            widget.link.toLowerCase().contains(place.street?.toLowerCase() ?? '');

        setState(() {
          isLocationMatched = textMatch;
        });

        _showMessage(textMatch
            ? 'تم التحقق بنجاح من الموقع (مطابقة نصية)'
            : 'الموقع غير مطابق (مطابقة نصية)');
      } else {
        // حساب المسافة بالمتر
        double distance = Geolocator.distanceBetween(position.latitude,
            position.longitude, taskLatLng.latitude, taskLatLng.longitude);

        // ضبط حد المسافة (مثلاً 500 متر)
        const double maxDistanceMeters = 500;

        setState(() {
          isLocationMatched = distance <= maxDistanceMeters;
        });

        _showMessage(isLocationMatched
            ? 'تم التحقق بنجاح من الموقع (المسافة: ${distance.toStringAsFixed(0)} متر)'
            : 'الموقع غير مطابق (المسافة: ${distance.toStringAsFixed(0)} متر)');
      }
    } catch (e) {
      _showMessage('خطأ أثناء التحقق من الموقع');
      log(e.toString());
      setState(() {
        isLocationMatched = false;
        _currentAddress = null;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showMessage('فشل في اختيار الصورة');
      log(e.toString());
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    // هنا بإمكانك استدعاء Cubit الخاص بك مثلاً TasksCubit
    // final cubit = TasksCubit.get(context);

    return Scaffold(
      appBar: AppBar(title: const Text('إكمال المهمة')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1 - اضغط لتأكيد الموقع:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              if (_currentAddress != null) ...[
                Text('موقعك الحالي: $_currentAddress'),
                Row(
                  children: [
                    Icon(
                      isLocationMatched ? Icons.check_circle : Icons.cancel,
                      color: isLocationMatched ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(isLocationMatched
                        ? 'تم التحقق من الموقع'
                        : 'الموقع غير مطابق'),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: isLoadingLocation ? null : _getCurrentPosition,
                child: Text(isLoadingLocation ? 'جارٍ التحميل...' : 'تأكيد الموقع'),
              ),
              const Divider(height: 40),
              Text('2 - قم برفع صورة من مكان المهمة:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              if (selectedImage != null)
                Image.file(selectedImage!, height: 180)
              else
                const Text('لا توجد صورة مرفوعة'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('رفع صورة'),
              ),
              const Divider(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (!isLocationMatched) {
                      _showMessage('الرجاء تأكيد الموقع أولاً');
                      return;
                    }
                    if (selectedImage == null) {
                      _showMessage('الرجاء رفع صورة من مكان المهمة');
                      return;
                    }

                    // هنا يمكنك تنفيذ دالة إكمال المهمة ورفع الصورة من خلال Cubit أو Bloc
                    _showMessage('تم التحقق من جميع الشروط، يمكنك إكمال المهمة');
                  },
                  child: const Text('تأكيد اكتمال المهمة'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LatLng {
  final double latitude;
  final double longitude;
  LatLng(this.latitude, this.longitude);
}
