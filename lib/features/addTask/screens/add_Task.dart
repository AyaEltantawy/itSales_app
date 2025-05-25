import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/constants/app_defaults.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/utils/snack_bar.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/states.dart';
import 'package:itsale/features/auth/data/cubit.dart';
import 'package:itsale/features/home/data/cubit.dart';

import '../../../core/components/app_text_form_field.dart';
import '../../../core/components/default_app_bar.dart';
import '../../../core/constants/app_animation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/token.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
import '../componenets/maps.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen(
      {super.key,
      required this.back,
      required this.isEdit,
      required this.taskId});

  final bool back;

  final bool isEdit;

  final int taskId;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var deadlineController = TextEditingController();
  var details = TextEditingController();
  var location = TextEditingController();
  var clientName = TextEditingController();
  var clientNumber = TextEditingController();
  var notes = TextEditingController();
  var taskTitle = TextEditingController();
  var address = TextEditingController();
  var formKeyTask = GlobalKey<FormState>();
  String selectedName = '      اختر اسم الموظف';
  String selectedStatus = '';
  String selectedId = '';

  List<Map<String, dynamic>> getUsers = [];

  Future<void> loadTaskData() async {
    for (int x = 0; x < TasksCubit.get(context).getAllTaskList!.length; x++) {
      if (widget.taskId == TasksCubit.get(context).getAllTaskList![x].id) {
        taskTitle.text =
            TasksCubit.get(context).getAllTaskList![x].title.toString();
        address.text =
            TasksCubit.get(context).getAllTaskList![x].location != null
                ? TasksCubit.get(context)
                    .getAllTaskList![x]
                    .location!
                    .address
                    .toString()
                : '';
        deadlineController.text =
            TasksCubit.get(context).getAllTaskList![x].due_date.toString();
        details.text =
            TasksCubit.get(context).getAllTaskList![x].description.toString();
        notes.text =
            TasksCubit.get(context).getAllTaskList![x].notes.toString();
        selectedName =
            '${TasksCubit.get(context).getAllTaskList![x].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getAllTaskList![x].assigned_to!.last_name.toString()}';
        _selectedFruit =
            '${TasksCubit.get(context).getAllTaskList![x].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getAllTaskList![x].assigned_to!.last_name.toString()}';
        selectedId = TasksCubit.get(context)
            .getAllTaskList![x]
            .assigned_to!
            .id
            .toString();
        selectedStatus =
            TasksCubit.get(context).getAllTaskList![x].task_status.toString();
        clientName.text =
            TasksCubit.get(context).getAllTaskList![x].client_name.toString();
        clientNumber.text =
            TasksCubit.get(context).getAllTaskList![x].client_phone.toString();
        location.text =
            TasksCubit.get(context).getAllTaskList![x].location != null
                ? TasksCubit.get(context)
                    .getAllTaskList![x]
                    .location!
                    .map_url
                    .toString()
                : '';
      }
      switch (selectedStatus) {
        case 'inbox':
          selectedStatus = 'قيد الانتظار';
        case 'completed':
          selectedStatus = 'مكتمل';
        case 'cancelled':
          selectedStatus = 'ملغي';
        case 'progress':
          selectedStatus = 'تم الاستلام';
      }
    }
  }

  List<String> status = ['قيد الانتظار', 'تم الاستلام', 'ملغي', 'مكتمل'];

  @override
  void initState() {
    widget.isEdit ? loadTaskData() : Container();
    for (int i = 0; i < EmployeeCubit.get(context).users!.length; i++) {
      var user = EmployeeCubit.get(context).users![i];
      getUsers.add({
        'id': user.id.toString(),
        'fName': user.first_name.toString(),
        'lName': user.last_name.toString()
      });
    }

    // TODO: implement initState
    super.initState();
  }

  DateTime? selectedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('en', 'US'), // Force English locale
    );

    if (pickedDate != null) {
      setState(() {
        selectedDateTime =
            DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
        deadlineController.text =
            DateFormat('yyyy-MM-dd').format(selectedDateTime!);
      });
    }
  }

  final TextEditingController _dropdownSearchFieldController =
      TextEditingController();

  String? _selectedFruit;

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  List<String> getSuggestions(String query) {
    return getUsers
        .where((user) => '${user['fName']} ${user['lName']}'
            .toLowerCase()
            .contains(query.toLowerCase()))
        .map((user) => '${user['fName']} ${user['lName']}')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocConsumer<TasksCubit, TasksStates>(
          listener: (context, state) {
            if (state is AddErrorUserTaskState ||
                state is EditErrorUserTaskState) {
             Utils.showSnackBar(context,  'عفوا حاول مرة اخرى');
            } else if (state is AddSuccessUserTaskState ||
                state is EditSuccessUserTaskState) {
              widget.isEdit
                  ? Utils.showSnackBar(context,  'تم تعديل المهمة بنجاح')
                  : Utils.showSnackBar(context,  'تم اضافة المهمة بنجاح');
              navigateTo(context, AppRoutes.entryPoint);
            }
          },
          builder: (context, state) {
            if (state is AddLoadingUserTaskState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: AppLottie.loader),
                ],
              );
            }
            return Form(
              key: formKeyTask,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          CustomAppBar(
                            back: widget.back,
                            title:
                                widget.isEdit ? ' تعديل المهمة' : 'إضافة مهمة',
                          ),
                          const Divider(),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SectionHeader(title: 'بيانات المهمة'),
                              widget.isEdit
                                  ? Container(
                                      width: 164.w,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 5.h),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.placeholder),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: DropdownButton<String>(
                                        dropdownColor: Colors.grey.shade50,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        isExpanded: true,
                                        underline: Container(),
                                        hint: Text(
                                          selectedStatus.isNotEmpty
                                              ? selectedStatus
                                              : 'حالة المهمة',
                                          style: AppFonts.style16Normal,
                                        ),
                                        value: null,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedStatus = value.toString();
                                          });
                                        },
                                        items: status
                                            .map(
                                              (state) =>
                                                  DropdownMenuItem<String>(
                                                enabled: true,
                                                value: state,
                                                child: Text(
                                                  state,
                                                  style:
                                                      AppFonts.style16semiBold,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          role == "1"
                              ? Container(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 16.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.placeholder),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: DropDownSearchFormField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      decoration: InputDecoration(
                                          labelStyle: AppFonts.style16Normal,
                                          labelText: 'اختر اسم الموظف'),
                                      controller:
                                          _dropdownSearchFieldController,
                                    ),
                                    suggestionsCallback: (pattern) {
                                      return getSuggestions(pattern);
                                    },
                                    itemBuilder: (context, String suggestion) {
                                      return ListTile(
                                        title: Text(suggestion),
                                      );
                                    },
                                    itemSeparatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                    transitionBuilder:
                                        (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected: (String suggestion) {
                                      _dropdownSearchFieldController.text =
                                          suggestion;
                                      var selectedUser = getUsers.firstWhere(
                                          (user) =>
                                              '${user['fName']} ${user['lName']}' ==
                                              suggestion);
                                      selectedId =
                                          selectedUser['id'].toString();
                                    },
                                    suggestionsBoxController:
                                        suggestionBoxController,
                                    validator: (value) => value!.isEmpty
                                        ? 'اختر اسم الموظف'
                                        : null,
                                    onSaved: (value) {
                                      _selectedFruit = value;
                                      var selectedUser = getUsers.firstWhere(
                                          (user) =>
                                              '${user['fName']} ${user['lName']}' ==
                                              value);
                                      selectedId =
                                          selectedUser['id'].toString();
                                    },
                                    displayAllSuggestionWhenTap: true,
                                  ),
                                )
                              // Container(
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal: 16.w, vertical: 5.h),
                              //         decoration: BoxDecoration(
                              //           border: Border.all(color: AppColors.placeholder),
                              //           borderRadius: BorderRadius.circular(8.r),
                              //         ),
                              //         child: DropdownButton<Map<String, dynamic>>(
                              //           dropdownColor: Colors.grey.shade50,
                              //
                              //           borderRadius: BorderRadius.circular(8.r),
                              //           isExpanded: true,
                              //           underline: Container(),
                              //           hint: Text(
                              //             selectedName.isNotEmpty
                              //                 ? selectedName
                              //                 : '    اختر اسم الموظف',
                              //             style: AppFonts.style16Normal,
                              //           ),
                              //           value: null,
                              //           onChanged: (value) {
                              //             setState(() {
                              //               selectedName =
                              //                   '${value!['fName'].toString()} ${value!['lName'].toString()}';
                              //               selectedId = value['id'];
                              //             });
                              //           },
                              //           items: getUsers
                              //               .map(
                              //                 (user) =>
                              //                     DropdownMenuItem<Map<String, dynamic>>(
                              //                   enabled: true,
                              //                   value: user,
                              //                   child: Text(
                              //                     '${user['fName'].toString()} ${user['lName'].toString()}',
                              //                     style: AppFonts.style16semiBold,
                              //                   ),
                              //                 ),
                              //               )
                              //               .toList(),
                              //         ),
                              //       )
                              : Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.placeholder),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 24.w,
                                      ),
                                      Text(
                                        '${AppCubit.get(context).getInfoLogin!.first_name.toString()} ${AppCubit.get(context).getInfoLogin!.last_name.toString()}',
                                        style: AppFonts.style16semiBold,
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: 16.h),
                          defaultTextFormFeild(
                            context,
                            controller: taskTitle,
                            keyboardType: TextInputType.text,
                            validate: (value) {
                              if (value == null || value == '') {
                                return 'لا تترك هذا الحقل فارغا';
                              }
                              return null;
                            },
                            label: 'اسم المهمة',
                            onTap: () {},
                            prefix: Icon(
                              Icons.task,
                              color: AppColors.placeholder,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          defaultTextFormFeild(
                            readOnly: true,
                            context,
                            controller: deadlineController,
                            keyboardType: TextInputType.datetime,
                            validate: (value) {
                              if (value == null || value == '') {
                                return 'لا تترك هذا الحقل فارغا';
                              }
                              return null;
                            },
                            label: 'تحديد مهلة المهمة',
                            onTap: () => _selectDateTime(context),
                            prefix: Icon(
                              Icons.timelapse,
                              color: AppColors.placeholder,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'لا تترك هذا الحقل فارغا';
                              }
                              return null;
                            },
                            controller: details,
                            keyboardType: TextInputType.multiline,
                            minLines: 4,
                            // Set this
                            maxLines: 6,
                            decoration: InputDecoration(
                              labelText: '        تفاصيل المهمة',

                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              border: OutlineInputBorder(
                                gapPadding: 2,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              labelStyle: AppFonts.style16Light,
                              focusColor: AppColors.placeholder,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: AppColors.placeholder,
                                    style: BorderStyle.solid,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    style: BorderStyle.solid,
                                    width: 2,
                                  )),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.errorColor,
                                    style: BorderStyle.solid,
                                  )),
                              fillColor: AppColors.primary,
                              errorStyle: const TextStyle(height: 1),

                              // constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 18 ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          const SectionHeader(title: 'الموقع الجغرافي'),
                          SizedBox(height: 8.h),
                          defaultTextFormFeild(
                            context,
                            keyboardType: TextInputType.text,
                            validate: (value) {
                              if (value == null || value == '') {
                                return 'لا تترك هذا الحقل فارغا';
                              }
                              return null;
                            },
                            label: 'عنوان المهمة',
                            onTap: () {},
                            controller: address,
                            prefix: Icon(
                              Icons.location_on,
                              color: AppColors.placeholder,
                            ),
                          ),
                          SizedBox(height: 16.h),

// Inside your build method
              defaultTextFormFeild(
              context,
              keyboardType: TextInputType.text,
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return 'لا تترك هذا الحقل فارغا';
                }

                final uri = Uri.tryParse(value);
                if (uri == null || !uri.isAbsolute) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
              label: 'الصق رابط Google Map الخاص بموقع المهمة',
              onTap: () {},
              controller: location,
              prefix: Icon(
                Icons.link,
                color: AppColors.placeholder,
              ),
            ),

            SizedBox(height: 10.h),

// Copy Button
            Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
            onPressed: () {
            if (location.text.isNotEmpty) {
            Clipboard.setData(ClipboardData(text: location.text));
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم نسخ الرابط')),
            );
            }
            },
            icon: Icon(Icons.copy, size: 18, color: AppColors.primary),
            label: Text(
            'نسخ الرابط',
            style: TextStyle(color: AppColors.primary),
            ),
            ),
            ),

            SizedBox(height: 16.h),

// Location Picker Button
            Center(
            child: InkWell(
            onTap: () async {
            final result = await Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => const LocationPickerScreen(),
            ),
            );

            if (result != null) {
            final latitude = result['latitude'];
            final longitude = result['longitude'];

            setState(() {
            address.text = result['address'];
            location.text =
            'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
            });
            }
            },
            child: Container(
            height: 40.h,
            width: 180.w,
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
            borderRadius: AppDefaults.borderRadius,
            color: globalDark ? AppColors.cardColorDark : AppColors.textWhite,
            border: Border.all(color: AppColors.primary),
            ),
            child: Text(
            AppLocalizations.of(context)!.translate("location_on_map"),
            style: TextStyle(
            color: globalDark ? AppColors.textWhite : AppColors.textBlack,
            fontSize: 14.sp,
            ),
            ),
            ),
            ),
            ),

            SizedBox(height: 24.h),
                          const SectionHeader(title: 'بيانات العميل'),
                          SizedBox(height: 16.h),
                          defaultTextFormFeild(
                            context,
                            keyboardType: TextInputType.name,
                            validate: (value) {
                              if (value == null || value == '') {
                                return 'لا تترك هذا الحقل فارغا';
                              }
                              return null;
                            },
                            label: 'أكتب اسم العميل',
                            controller: clientName,
                            onTap: () {},
                            prefix: Icon(
                              Icons.person,
                              color: AppColors.placeholder,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          defaultTextFormFeild(
                            context,
                            keyboardType: TextInputType.phone,
                            validate: (value) {
                              if (value == null || value == '') {
                                return 'لا تترك هذا الحقل فارغا';
                              }
                              return null;
                            },
                            label: 'أكتب رقم العميل',
                            controller: clientNumber,
                            onTap: () {},
                            prefix: Icon(
                              Icons.phone_outlined,
                              color: AppColors.placeholder,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'لا تترك هذا الحقل فارغا';
                              }
                            },
                            controller: notes,
                            keyboardType: TextInputType.multiline,
                            minLines: 4,
                            // Set this
                            maxLines: 6,
                            decoration: InputDecoration(
                              labelText: '       ملاحظات',

                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              border: OutlineInputBorder(
                                gapPadding: 2,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              labelStyle: AppFonts.style16Light,
                              focusColor: AppColors.placeholder,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: AppColors.placeholder,
                                    style: BorderStyle.solid,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    style: BorderStyle.solid,
                                    width: 2,
                                  )),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.errorColor,
                                    style: BorderStyle.solid,
                                  )),
                              fillColor: AppColors.primary,
                              errorStyle: const TextStyle(height: 1),

                              // constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 18 ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  InkWell(
                      onTap: () {
                        role == '1'
                            ? selectedId = selectedId
                            : selectedId = userId.toString();
                        if (formKeyTask.currentState!.validate() &&
                            selectedId != '' &&
                            deadlineController.text != '' &&
                            !widget.isEdit) {
                          TasksCubit.get(context).addTaskFun(
                            status: 'published',
                            assigned_to:
                                role == '1' ? selectedId : userId.toString(),
                            due_date: deadlineController.text,
                            description: details.text,
                            mapUrl: location.text,
                            client_name: clientName.text,
                            client_phone: clientNumber.text,
                            task_status: 'inbox',
                            notes: notes.text,
                            title: taskTitle.text,
                            address: address.text,
                          );
                        }

                        if (widget.isEdit) {
                          switch (selectedStatus) {
                            case 'قيد الانتظار':
                              selectedStatus = 'inbox';
                            case 'مكتمل':
                              selectedStatus = 'completed';
                            case 'ملغي':
                              selectedStatus = 'cancelled';
                            case 'تم الاستلام':
                              selectedStatus = 'progress';
                          }
                          TasksCubit.get(context).getLocationFun(
                            taskId: widget.taskId.toString(),
                            assigned_to: selectedId,
                            due_date: deadlineController.text,
                            description: details.text,
                            map_url: location.text,
                            client_name: clientName.text,
                            client_phone: clientNumber.text,
                            task_status: selectedStatus,
                            notes: notes.text,
                            title: taskTitle.text,
                            address: address.text,
                          );
                        }
                      },
                      child: _buildSubmitButton()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'إضافة مهمة ',
          style: AppFonts.style20Normal,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            widget.isEdit ? 'تعديل المهمة' : 'إنشاء المهمة',
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppFonts.style20Normal,
    );
  }
}

class EmployeeInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;

  const EmployeeInputField(
      {super.key, required this.hintText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Color(0xff686e73)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Color(0xff848a90),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff848a90),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
