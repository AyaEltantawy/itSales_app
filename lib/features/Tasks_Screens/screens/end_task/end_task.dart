// complete_task.dart
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart' show DefaultHttpClientAdapter;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/token.dart'; // تأكد من وجود companyId هنا
import '../../../addEmployee/data/models/add_employee_model.dart';
import '../../data/cubit/cubit.dart';
import '../../data/models/get_task_model.dart';

bool isSubmitting = false;

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
  final String link;
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
      Placemark place = placemarks.first;
      String addressString =
          '${place.street ?? ''}, ${place.name ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}'
              .replaceAll(RegExp(r',\s*,*'), ',')
              .trim();

      setState(() {
        _currentAddress = addressString;
      });

      LatLng? taskLatLng = _parseLatLngFromGoogleMapsLink(widget.link);

      if (taskLatLng != null) {
        double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          taskLatLng.latitude,
          taskLatLng.longitude,
        );

        const double maxDistanceMeters = 500;

        setState(() {
          isLocationMatched = distance <= maxDistanceMeters;
        });

        _showMessage(isLocationMatched
            ? '✅ تم التحقق من الموقع (المسافة: ${distance.toStringAsFixed(0)} م)'
            : '❌ الموقع خارج النطاق (المسافة: ${distance.toStringAsFixed(0)} م)');
      } else {
        setState(() {
          isLocationMatched = false;
        });
        _showMessage('تعذر التحقق من موقع المهمة (رابط غير صالح)');
      }
    } catch (e) {
      _showMessage('حدث خطأ أثناء تحديد الموقع');
      log(e.toString());
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

  Future<String?> uploadImageToDirectus(File file) async {
    try {
      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 180),  // 3 دقائق
        receiveTimeout: const Duration(seconds: 180),
        sendTimeout: const Duration(seconds: 180),
      ));

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      final response = await dio.post(
        'https://eby-itsales.guessitt.com/public/itsales/files',
        data: formData,
        options: Options(
          headers: {
            'Authorization': '$token',
            'Content-Type': 'multipart/form-data',
          },
          sendTimeout: const Duration(seconds: 180),
          receiveTimeout: const Duration(seconds: 180),
        ),
        onSendProgress: (sent, total) {
          final progress = (sent / total * 100).toInt();
          print("📤 Uploading: $progress%");
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Upload success: ${response.data}");
        final id = response.data['data']['id']?.toString();
        return id;
      } else {
        print("❌ Upload failed with status code: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e, stack) {
      print("❌ DioException: ${e.message}");
      print("Stack: $stack");
      return null;
    } catch (e, stack) {
      print("❌ Unexpected error: $e");
      print("Stack: $stack");
      return null;
    }
  }


  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إكمال المهمة')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('1 - اضغط لتأكيد الموقع:',
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              if (_currentAddress != null) ...[
                Text('📍 موقعك الحالي: $_currentAddress'),
                Row(
                  children: [
                    Icon(
                      isLocationMatched ? Icons.check_circle : Icons.cancel,
                      color: isLocationMatched ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(isLocationMatched
                        ? 'داخل النطاق المسموح به'
                        : 'خارج النطاق (500م)'),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: isLoadingLocation ? null : _getCurrentPosition,
                child: Text(
                    isLoadingLocation ? 'جارٍ التحقق...' : 'تحقق من الموقع'),
              ),
              const Divider(height: 40),
              const Text('2 - قم برفع صورة من مكان المهمة:',
                  style: TextStyle(fontSize: 18)),
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
                child: isSubmitting
                    ? const CircularProgressIndicator() // عرض مؤشر تحميل
                    : ElevatedButton(
                        onPressed: () async {
                          if (!isLocationMatched) {
                            _showMessage(
                                '❌ يجب أن تكون ضمن النطاق المحدد (500م)');
                            return;
                          }

                          if (selectedImage == null) {
                            _showMessage('❌ يرجى رفع صورة من موقع المهمة');
                            return;
                          }

                          setState(() {
                            isSubmitting = true;
                          });

                          try {
                            String? fileId =
                                await uploadImageToDirectus(selectedImage!);
                            if (fileId == null) {
                              _showMessage('❌ فشل رفع الصورة');
                              setState(() {
                                isSubmitting = false;
                              });
                              return;
                            }

                            await TasksCubit.get(context).editTaskFun(
                              complete_date: DateFormat("yyyy-MM-dd").format(DateTime.now()),

                              company: companyId,
                              taskId: widget.taskId.toString(),
                              task_status: 'completed',
                              status: 'published',
                              title: widget.title,
                              notes: widget.notes,
                              assigned_to: int.parse(widget.assign_to),
                              description: widget.description,
                              locationId: int.parse(widget.locationId),
                              client_phone: widget.clientPhone,
                              client_name: widget.clientName,
                              due_date: widget.due_date,
                              start_date: widget.due_date,
                              files: [
                                Files(
                                  directus_files_id: DirectusFilesIdRequest(
                                      id: int.parse(fileId)),
                                ),
                              ],
                            );

                            _showMessage('✅ تم اكتمال المهمة بنجاح');
                            // يمكنك هنا عمل pop للرجوع أو تحديث الصفحة
                          } catch (e) {
                            _showMessage('❌ فشل في إرسال المهمة');
                            debugPrint('Error: $e');
                          } finally {
                            setState(() {
                              isSubmitting = false;
                            });
                          }
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
