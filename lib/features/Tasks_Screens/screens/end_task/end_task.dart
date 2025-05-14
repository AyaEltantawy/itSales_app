import 'dart:developer';
import 'dart:io';
import 'package:intl/src/intl/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/components/default_app_bar.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/states.dart';

import '../../../../core/constants/app_animation.dart';
import '../../../../core/utils/snack_bar.dart';
import '../../data/models/get_task_model.dart';

class CompleteTask extends StatefulWidget {
  const CompleteTask(
      {super.key,
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
      required this.address});

  final int taskId;
  final String locationId;
  final String title;
  final String description;
  final String assign_to;
  final String link;
  final String address;

  final String clientName;
  final String clientPhone;
  final String notes;
  final String due_date;

  @override
  State<CompleteTask> createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
  String? _currentAddress;
  String? address;
  Position? _currentPosition;
  bool check = false;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    print('true');
    return true;
  }

  Future<void> _getCurrentPosition() async {
    print('enter');
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      // Handle case when permission is not granted
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Location permission is required to access the current location')),
      );
      return;
    }

    try {
      setState(() {
        check = true;
      });
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')),
          );
          return;
        }
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('Location services are disabled');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled')),
        );
        return;
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('enter 2222');

      setState(() {
        _currentPosition = position;
      });

      print('enter 4');
      _getAddressFromLatLng(_currentPosition!);
      print('enter 5');
    } catch (e) {
      print('Error getting current position: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get the current location')),
      );
    }

    print('enter ...');
  }

  bool isLocationMatched = false;

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.name}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.country}';
      });

      Utils.showSnackBar(
        context,
        _currentAddress.toString(),
      );

      isLocationMatched = widget.address.contains(place.street ?? '') ||
          widget.link.contains(place.street ?? '') ||
          widget.address.contains(place.name ?? '') ||
          widget.link.contains(place.name ?? '');

      if (isLocationMatched) {
        Utils.showSnackBar(
          context,
          ' الموقع مطابق${place.street}',
        );
      } else {
        Utils.showSnackBar(
          context,
          ' ${place.street} الموقع غير مطابق ',
        );
      }

      setState(() {
        check = false;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  File? selectedImage;
  int? filesId;
  List<Files> filesIdReady = [];

  Future<void> _pickImage() async {
    final pickedFile;

    pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDefaults.padding.w),
          child: SingleChildScrollView(
            child: BlocConsumer<TasksCubit, TasksStates>(
              listener: (context, state) {
                if (state is EditErrorUserTaskState) {
                  Utils.showSnackBar(context, 'error ');
                }

                if (state is EditSuccessUserTaskState) {
                  Utils.showSnackBar(context, 'تم اكتمال المهمة بنجاح');
                  navigateTo(context, AppRoutes.entryPoint);
                }
              },
              builder: (context, state) {
                if (state is EditLoadingUserTaskState) {
                  return AppLottie.loader;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(back: true, title: 'اكمال المهمة'),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Text(S.of(context)!._1_-_قم_بكتابة_موقعك_الحالي_:) , style: AppFonts.style16semiBold,),
                    // SizedBox(height: 20.h,),
                    // defaultTextFormFeild(context,
                    //     keyboardType: TextInputType.text,
                    //     controller: location,
                    //     validate: (v)
                    //     {
                    //       if (v != null )
                    //       {
                    //         return 'املأ الحقل';
                    //       }
                    //       return null ;
                    //     }, label: 'الموقع الحالي' ),
                    // SizedBox(height: 20.h,),
                    Text(
                      ' 1 - قم بالضغط على زر تأكيد الموقع : ',
                      style: AppFonts.style16semiBold,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _currentAddress != null
                        ? Text(
                            ' موقعك : ${_currentAddress.toString()}',
                            style: AppFonts.style14normal,
                          )
                        : Container(),
                    SizedBox(
                      height: 10.h,
                    ),
                    _currentAddress != null
                        ? Row(
                            children: [
                              isLocationMatched
                                  ? Icon(
                                      Icons.check_circle,
                                      color: AppColors.greenColor,
                                    )
                                  : Icon(
                                      Icons.cancel,
                                      color: AppColors.errorColor,
                                    ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                !isLocationMatched
                                    ? 'موقعك لا يطابق موقع المهمة'
                                    : 'تم التحقق بنجاح من الموقع',
                                style: AppFonts.style14normal,
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: defaultButton(
                          context: context,
                          text: check ? 'انتظر قليلا ....' : 'تأكيد الموقع',
                          width: 200.w,
                          height: 48.h,
                          isColor: true,
                          textSize: 16.sp,
                          toPage: () {
                            _getCurrentPosition();
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      ' 2 - قم برفع صور من وجودك في مكان المهمة: ',
                      style: AppFonts.style16semiBold,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: defaultButton(
                          context: context,
                          text: 'اضغط لرفع صور',
                          width: 200.w,
                          height: 48.h,
                          isColor: false,
                          textSize: 16.sp,
                          toPage: () {
                            _pickImage().then((onValue) async {
                              if (selectedImage != null) {
                                filesId = await cubit
                                    .uploadFileInTasks(selectedImage!);
                                filesIdReady.add(Files(
                                    directus_files_id:
                                        DirectusFilesIdRequest(id: filesId)));
                              }
                            });
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    selectedImage != null
                        ? Center(
                            child: SizedBox(
                              height: 180.h,
                              child: Image.file(selectedImage!),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 20.h,
                    ),

                    isLocationMatched
                        ? Center(
                            child: defaultButton(
                                context: context,
                                text: 'اكمال المهمة',
                                width: 200.w,
                                height: 48.h,
                                isColor: true,
                                textSize: 16.sp,
                                toPage: () {
                                  // launchUrl(Uri.parse(
                                  //      log('https://www.google.com/maps/search/?api=1&query=${_currentAddress.toString()}');
                                  //
                                  log(DateTime.now()
                                      .toUtc()
                                      .toIso8601String()
                                      .replaceFirst('Z', '+00:00'));
                                  if (_currentAddress != null &&
                                      selectedImage != null) {
                                    cubit.updateLocationFun(
                                        files: filesIdReady,
                                        title: widget.title,
                                        description: widget.description,
                                        client_phone: widget.clientPhone,
                                        notes: widget.notes,
                                        assigned_to: widget.assign_to,
                                        client_name: widget.clientName,
                                        complete_date:
                                            DateFormat('yyyy-MM-dd', 'en')
                                                .format(DateTime.now()),
                                        due_date: widget.due_date,
                                        task_status: 'completed',
                                        locationId:
                                            widget.locationId == 'لا يوجد' ||
                                                    widget.locationId == ''
                                                ? '10'
                                                : widget.locationId,
                                        taskId: widget.taskId.toString(),
                                        address: _currentAddress.toString(),
                                        map_url:
                                            'https://www.google.com/maps/search/?api=1&query=${_currentAddress.toString()}');
                                  }
                                }),
                          )
                        : Container(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
