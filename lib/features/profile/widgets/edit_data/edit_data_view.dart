import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/app/app.dart';
import '../../../../core/components/app_buttons.dart';
import '../../../../core/components/app_text_form_field.dart';
import '../../../../core/components/default_app_bar.dart';
import '../../../../core/components/network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/navigation.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/token.dart';
import '../../../auth/data/cubit.dart';
import '../../../home/data/cubit.dart';
import 'edit_data_cubit.dart';
import 'edit_data_state.dart';

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app/app.dart';
import '../../../../core/components/app_buttons.dart';
import '../../../../core/components/app_text_form_field.dart';
import '../../../../core/components/default_app_bar.dart';
import '../../../../core/components/network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/navigation.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../auth/data/cubit.dart';
import '../../../home/data/cubit.dart';
import 'edit_data_cubit.dart';
import 'edit_data_state.dart';

class EditDataPage extends StatefulWidget {
  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool isPasswordShown = false;
  File? selectedImageForSetting;

  @override
  void initState() {
    super.initState();
    final cubit = AppCubit.get(context);
    fNameController =
        TextEditingController(text: cubit.getInfoLogin?.first_name ?? '');
    lNameController =
        TextEditingController(text: cubit.getInfoLogin?.last_name ?? '');
    emailController =
        TextEditingController(text: cubit.getInfoLogin?.email ?? '');
    passwordController = TextEditingController(text: ''); // or some default

    selectedImageForSetting = null;
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordShown = !isPasswordShown;
    });
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImageForSetting = File(pickedFile.path);
      });
    }
  }

  void onSavePressed() async {
    final cubit = AppCubit.get(context);
    final employeeCubit = EmployeeCubit.get(context);

    final firstName = fNameController.text.trim();
    final lastName = lNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Example variables, replace with actual values or fetch from cubits/global
    final userId = cubit.getInfoLogin?.id ?? 0;
    final roleId = cubit.getInfoLogin?.role?.id?.toString() ?? 'defaultRole';
    final avatarId = cubit.getInfoLogin?.avatar?.id;

    final phone1 = roleId == '1' &&
            employeeCubit.users != null &&
            employeeCubit.users!.isNotEmpty
        ? (employeeCubit.users![0].employee_info?.isNotEmpty == true
            ? employeeCubit.users![0].employee_info![0].phone_1 ?? ''
            : '')
        : '';

    try {
      if (cubit.getInfoLogin?.avatar == null &&
          selectedImageForSetting == null) {
        // No avatar change, simple edit
        await employeeCubit.editUserFun(
          companies: companyId,
          password: password,
          idUser: userId.toString(),
          firstName: firstName,
          phone1: phone1,
          employeeId: '0',
          role: roleId,
          email: email,
          lastName: lastName,
          status: 'active',
        );
      } else {
        if (selectedImageForSetting != null) {
          await employeeCubit.uploadFile(
            companyId: companyId,
            selectedImageForSetting!,
            idUser: userId.toString(),
            firstName: firstName,
            phone1: phone1,
            employeeId: '0',
            role: roleId,
            email: email,
            lastName: lastName,
            edit: true,
            status: 'active',
            password: password,
          );
        } else {
          await employeeCubit.editUserFun(
            companies: companyId,
            password: password,
            idUser: userId.toString(),
            firstName: firstName,
            avatar: avatarId,
            phone1: phone1,
            employeeId: '0',
            role: roleId,
            email: email,
            lastName: lastName,
            status: 'active',
          );
        }
      }
      await cubit.getUserDataFun(context);
      log('User data updated successfully');
      navigateTo(context, AppRoutes.entryPoint);
    } catch (e) {
      log('Error updating user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء حفظ التغييرات')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditDataCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const CustomAppBar(back: true, title: 'تعديل الحساب'),
                SizedBox(height: 20.h),
                ProfileHeader(
                  selectedImage: selectedImageForSetting,
                  onPickImage: pickImage,
                  onRemoveImage: () {
                    setState(() {
                      selectedImageForSetting = null;
                    });
                  },
                ),
                SizedBox(height: 20.h),
                defaultTextFormFeild(
                  context,
                  prefix: const Icon(Icons.perm_identity_sharp),
                  controller: fNameController,
                  keyboardType: TextInputType.name,
                  validator: (v) => null,
                  label: 'الاسم الاول',
                ),
                SizedBox(height: 15.h),
                defaultTextFormFeild(
                  context,
                  prefix: const Icon(Icons.person_2_outlined),
                  keyboardType: TextInputType.name,
                  controller: lNameController,
                  validator: (v) => null,
                  label: 'الاسم الاخير',
                ),
                SizedBox(height: 15.h),
                defaultTextFormFeild(
                  context,
                  prefix: const Icon(Icons.email_outlined),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => null,
                  label: 'البريد الالكتروني',
                ),

                SizedBox(height: 40.h),
                defaultButton(
                  context: context,
                  text: 'حفظ التغييرات',
                  width: 250.w,
                  height: 48.h,
                  isColor: true,
                  textSize: 18.sp,
                  toPage: onSavePressed,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onRemoveImage;
  final VoidCallback onPickImage;

  const ProfileHeader({
    Key? key,
    required this.selectedImage,
    required this.onRemoveImage,
    required this.onPickImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    final avatarUrl = cubit.getInfoLogin?.avatar?.data?.full_url;

    return Column(
      children: [
        if (selectedImage != null)
          Stack(
            children: [
              Container(
                height: 90.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Image.file(selectedImage!, fit: BoxFit.cover),
              ),
              Positioned(
                top: 5.h,
                right: 5.w,
                child: InkWell(
                  onTap: onRemoveImage,
                  child: const Icon(Icons.cancel, color: Colors.red),
                ),
              ),
            ],
          )
        else if (avatarUrl != null && avatarUrl.isNotEmpty)
          SizedBox(
            height: 90.h,
            width: 90.w,
            child: NetworkImageWithLoader(avatarUrl),
          )
        else
          Container(
            height: 90.h,
            width: 90.w,
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
        SizedBox(height: 20.h),
        InkWell(
          onTap: onPickImage,
          child: Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.placeholder),
              borderRadius: BorderRadius.circular(8.r),
              color: globalDark ? AppColors.textBlack : AppColors.textWhite,
            ),
            child: Text('اختر صورة', style: AppFonts.style14normal),
          ),
        ),
      ],
    );
  }
}
