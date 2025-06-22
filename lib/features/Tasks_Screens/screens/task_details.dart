import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/utils/token.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/Tasks_Screens/screens/end_task/end_task.dart';
import 'package:itsale/features/addTask/screens/add_Task.dart';
import 'package:itsale/generated/l10n.dart';

import '../../../core/components/default_app_bar.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/localization/app_localizations.dart' show AppLocalizations;
import '../../../core/utils/snack_bar.dart';
import '../../../core/utils/transition.dart';
import '../../addEmployee/data/models/add_employee_model.dart';
import '../components/details_screen_widget.dart';
import '../data/models/get_task_model.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String nameEmployee;

  final String nameTask;

  final String description;

  final String deadline;

  final String nameClient;

  final String notes;

  final String phoneClient;

  final String address;

  final String locationId;

  final String link;

  final String task_status;

  final List<dynamic>? file;
  final int id;

  const TaskDetailsScreen(
      {super.key,
      required this.locationId,
      required this.nameEmployee,
      required this.nameTask,
      required this.description,
      required this.deadline,
      required this.nameClient,
      required this.notes,
      required this.phoneClient,
      required this.address,
      required this.link,
      required this.id,
      required this.task_status,
      required this.file});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  void initState() {
    TasksCubit.get(context).getAllTasksFun();

    super.initState();
  }

  List<Files> filesIdReady = [];
  int? filesId;
  File? selectedImage;

  Future<void> _pickImage() async {
    final pickedFile;

    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(16.h),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              CustomAppBar(
                title: 'تفاصيل المهمة',
                back: true,
                actions: [
                  role == '3'
                      ? Container()
                      : PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.more_vert,
                          ),
                          onSelected: (String result) {
                            if (result == 'edit') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTaskScreen(
                                        isEdit: true,
                                        taskId: widget.id,
                                        back: true),
                                  ));
                            } else if (result == 'delete') {
                              TasksCubit.get(context)
                                  .editTaskFun(
                                      company: companyId,
                                      taskId: widget.id.toString())
                                  .then((value) {
                                Utils.showSnackBar(
                                    context, 'تم حذف المهمة بنجاح');
                              });
                              navigateTo(context, AppRoutes.entryPoint);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text("تعديل المهمة"),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text(
                                "حذف المهمة",
                              ),
                            ),
                          ],
                        ),
                ],
              ),
              SizedBox(height: 20.h),
              TaskDetailsSection(
                nameEmployee: widget.nameEmployee,
                nameTask: widget.nameTask,
                description: widget.description,
                deadline: widget.deadline,
              ),
              SizedBox(height: 16.h),
              LocationSection(
                address: widget.address,
                link: widget.link,
              ),
              SizedBox(height: 16.h),
              ClientSection(
                nameClient: widget.nameClient,
                notes: widget.notes,
                phoneClient: widget.phoneClient,
              ),
              SizedBox(height: 20.h),
              role == '3'
                  ? (widget.task_status == 'completed'
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDefaults.padding.w / 6),
                          child: defaultButton(
                              context: context,
                              text: 'إكمال المهمة',
                              width: 160.w,
                              height: 48.h,
                              isColor: true,
                              textSize: 18.sp,
                              toPage: () {
                                Navigator.push(
                                  context,
                                  loginTransition(
                                    CompleteTask(
                                      taskId: widget.id,
                                      address: widget.address,
                                      link: widget.link,
                                      title: widget.nameTask,
                                      description: widget.description,
                                      due_date: widget.deadline,
                                      locationId:
                                          (widget.locationId !=AppLocalizations.of(context)!.translate("not_available") &&
                                                  widget.locationId != '')
                                              ? widget.locationId.toString()
                                              : '10',
                                      notes: widget.notes,
                                      clientName: widget.nameClient,
                                      clientPhone: widget.phoneClient,
                                      assign_to: userId.toString(),
                                    ),
                                  ),
                                );
                                print(
                                    'Navigating with locationId: ${widget.locationId}');
                              }),
                        ))
                  : Container(),
              widget.task_status != 'completed'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'يمكنك إضافة ملف',
                          style: AppFonts.style16semiBold,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _pickImage().then((onValue) async {
                              if (selectedImage != null) {
                                filesId = await TasksCubit.get(context)
                                    .uploadFileInTasks(selectedImage!);
                                filesIdReady.add(Files(
                                    directus_files_id:
                                        DirectusFilesIdRequest(id: filesId)));
                              }
                            });
                          },
                          child: Text(
                            "اضافه",
                            style: AppFonts.style14normalWhite,
                          ),
                        ),
                      ],
                    )
                  : Container(),
              selectedImage != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: SizedBox(
                            height: 180.h,
                            child: Image.file(selectedImage!),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: defaultButton(
                              context: context,
                              text: 'رفع',
                              width: 100.w,
                              height: 40.h,
                              isColor: true,
                              textSize: 16.sp,
                              toPage: () {
                                String? x = TasksCubit.get(context)
                                    .getAllTaskList!
                                    .firstWhere((task) => task.id == widget.id)
                                    .assigned_to
                                    ?.id
                                    .toString();
                                TasksCubit.get(context)
                                    .editTaskFun(
                                  company: companyId,
                                  status: 'published',
                                  files: filesIdReady,
                                  title: widget.nameTask,
                                  description: widget.description,
                                  client_phone: widget.phoneClient,
                                  notes: widget.notes,
                                  assigned_to: int.parse(x!),
                                  client_name: widget.nameClient,
                                  due_date: widget.deadline,
                                  task_status: widget.task_status,
                                  locationId: widget.locationId == AppLocalizations.of(context)!.translate("not_available") ||
                                          widget.locationId == ''
                                      ? 10
                                      : int.tryParse(widget.locationId),
                                  taskId: widget.id.toString(),
                                )
                                    .then((onValue) {
                                  Navigator.pop(context);
                                  Utils.showSnackBar(
                                    context,
                                    'تم رفع الملف بنجاح',
                                  );
                                });
                              }),
                        ),
                      ],
                    )
                  : Container(),
              widget.file!.isEmpty
                  ? Container()
                  : AttachmentsSection(
                      files: widget.file,
                    ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
