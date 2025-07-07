import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itsale/core/components/network_image.dart';
import 'package:itsale/core/constants/app_animation.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/features/addEmployee/data/models/add_employee_model.dart';
import 'package:itsale/features/home/data/cubit.dart';
import 'package:itsale/features/home/data/states.dart';
import 'package:itsale/main.dart';
import 'package:svg_flutter/svg.dart';
import '../../../core/components/app_text_form_field.dart';
import '../../../core/components/default_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/navigation.dart';
import '../../../core/localization/localization_service.dart';
import '../../../core/utils/snack_bar.dart';
import '../../../core/utils/token.dart';

class AddNewEmployee extends StatefulWidget {
  final int empId;
  final bool isEdit;

  const AddNewEmployee({
    super.key,
    required this.empId,
    required this.isEdit,
  });

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  List<String> _items = [];
  List<String> status = [];
  String _selectedItem2='';
  String _selectedItemRole='';
  void didChangeDependencies() {
    super.didChangeDependencies();
    LocalizationService.init(context);
    _selectedItemRole = LocalizationService.tr("employee");
    _items = [
      LocalizationService.tr("manager"),
      LocalizationService.tr("employee")
    ];
    status = [
      LocalizationService.tr("inactive"),
      LocalizationService.tr("active")
    ];
   _selectedItem2 = LocalizationService.tr("active");
  }



  dynamic? avatarUrl;
  int? avatarId;
  int? employeeId;
  int? employeeUserId;

  final fullName = TextEditingController();
  final email = TextEditingController();
  final emailEmp = TextEditingController();
  final password = TextEditingController();
  final verifyPassword = TextEditingController();
  final phone1 = TextEditingController();
  final phone2 = TextEditingController();
  final whatsApp = TextEditingController();
  final address = TextEditingController();
  final formKeyEmployee = GlobalKey<FormState>();

  File? selectedImage;
  bool isLoading = false;

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);

          avatarUrl = null;
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      Utils.showSnackBar(context, "Failed to pick image");
    }
  }

  Future<void> loadEmployeeData() async {
    setState(() => isLoading = true);

    try {
      final users = EmployeeCubit.get(context).users;
      if (users == null || users.isEmpty) return;

      final user = users.firstWhere((u) => widget.empId == u.id);

      // استخراج الدور بشكل آمن
      final roleId = user.role is int
          ? user.role
          : (user.role is Map && user.role['id'] is int)
              ? user.role['id']
              : null;

      final isEmployee = roleId == 3;

      _selectedItemRole = roleId == 1
          ? LocalizationService.tr("manager")
          : LocalizationService.tr("employee");
      _selectedItem2 = user.status == 'active'
          ? LocalizationService.tr("active")
          : LocalizationService.tr("inactive");

      fullName.text = '${user.first_name ?? ''} ${user.last_name ?? ''}'.trim();
      email.text = user.email ?? '';
      password.text = password.text;

      print("📦 password.text: ${password.text}");
      print("🟡 user.role: ${user.role}");
      print("🔵 type: ${user.role.runtimeType}");

      final employeeInfo = user.employee_info?.firstOrNull;
      if (employeeInfo != null) {
        emailEmp.text = employeeInfo.email ?? '';
        phone1.text = employeeInfo.phone_1 ?? '';
        phone2.text = employeeInfo.phone_2 ?? '';
        whatsApp.text = employeeInfo.whatsapp ?? '';
        address.text = employeeInfo.address ?? '';
        employeeId = employeeInfo.id;
      } else {
        employeeId = isEmployee ? null : 0;
        debugPrint(
            "⚠️ employeeInfo is null → setting employeeId = ${employeeId ?? 'null'}");
      }

      if (user.avatar?.data?.full_url != null) {
        avatarUrl = user.avatar!.data!.full_url;
        debugPrint("✅ Avatar URL loaded: $avatarUrl");
      } else {
        debugPrint("⚠️ No avatar found for this employee.");
      }

      avatarId = user.avatar?.id;
      employeeUserId = user.id;

      debugPrint(
          "✅ Loaded employee data - ID: $employeeId, Avatar: $avatarUrl");
    } catch (e, stackTrace) {
      debugPrint("❌ Error loading employee data: $e");
      print("stackTrace: $stackTrace");
      Utils.showSnackBar(context, "فشل تحميل بيانات الموظف");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) loadEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: formKeyEmployee,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      CustomAppBar(
                        title: widget.isEdit
                            ? AppLocalizations.of(context)!
                                .translate("edit_data_of_employee")
                            : AppLocalizations.of(context)!
                                .translate("add_new_employee"),
                        back: true,
                      ),
                      const Divider(),
                      SizedBox(height: 10.h),
                      BlocConsumer<EmployeeCubit, EmployeeStates>(
                        listener: (context, state) {
                          if (state is AddErrorEmployeeInfoState ||
                              state is EditErrorEmployeeInfoState ||
                              state is ErrorEditUserState) {
                            Utils.showSnackBar(
                                context,
                                AppLocalizations.of(context)!
                                    .translate("something_went_wrong"));
                          }
                          if (state is AddSuccessEmployeeInfoState ||
                              state is EditSuccessEmployeeInfoState ||
                              state is SuccessEditUserState) {
                            if (widget.isEdit) {
                              navigateTo(context, AppRoutes.entryPoint);
                              Utils.showSnackBar(
                                  context,
                                  AppLocalizations.of(context)!
                                      .translate("edit_done_successfuly"));
                            } else {
                              Utils.showSnackBar(
                                  context,
                                  AppLocalizations.of(context)!
                                      .translate("added_successfully"));
                            }
                          }
                        },
                        builder: (context, state) {
                          if (isLoading ||
                              state is AddLoadingUserState ||
                              state is AddLoadingEmployeeInfoState ||
                              state is PostLoadingFileState ||
                              state is LoadingEditUserState ||
                              state is EditLoadingEmployeeInfoState) {
                            return Center(child: AppLottie.loader);
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Login Data Section
                              SectionHeader(
                                  title: AppLocalizations.of(context)!
                                      .translate("login_data")),
                              SizedBox(height: 16.h),
                              _buildNameField(),
                              SizedBox(height: 16.h),
                              _buildEmailField(),
                              if (!widget.isEdit) ...[
                                SizedBox(height: 16.h),
                                _buildPasswordField(),
                                SizedBox(height: 16.h),
                                _buildVerifyPasswordField(),
                              ],
                              SizedBox(height: 16.h),
                              _buildRoleAndStatusDropdowns(),
                              SizedBox(height: 24.h),

                              // Employee Data Section
                              SectionHeader(
                                  title: AppLocalizations.of(context)!
                                      .translate("employee_data")),
                              SizedBox(height: 8.h),
                              _buildAvatarSection(),
                              SizedBox(height: 16.h),
                              _buildPhone1Field(),
                              SizedBox(height: 16.h),
                              _buildPhone2Field(),
                              SizedBox(height: 16.h),
                              _buildWhatsAppField(),
                              SizedBox(height: 16.h),
                              _buildEmployeeEmailField(),
                              SizedBox(height: 16.h),
                              _buildAddressField(),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return defaultTextFormFeild(
      textDirection: TextDirection.rtl,
      context,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppLocalizations.of(context)!
              .translate("Do not leave this field blank.");
        }
        List<String> parts = value.trim().split(' ');
        if (parts.length < 2 || parts.any((part) => part.isEmpty)) {
          return AppLocalizations.of(context)!.translate("enter_full_name");
        }
        return null;
      },
      controller: fullName,
      label: AppLocalizations.of(context)!.translate("choose_employee_name"),
      prefix: Icon(
        Icons.person,
        color: AppColors.placeholder,
      ),
    );
  }

  Widget _buildEmailField() {
    return defaultTextFormFeild(
      controller: email,
      context,
      keyboardType: TextInputType.emailAddress,
      textDirection: TextDirection.rtl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Do not leave this field blank.";
        }
        return null;
      },
      label: AppLocalizations.of(context)?.translate("write_email"),
      prefix: Icon(
        Icons.email,
        color: AppColors.placeholder,
      ),
    );
  }

  Widget _buildPasswordField() {
    return defaultTextFormFeild(
      controller: password,
      context,
      textDirection: TextDirection.rtl,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!
              .translate("Do not leave this field blank.");
        }
        return null;
      },
      label: AppLocalizations.of(context)!.translate("write_password"),
      prefix: Icon(
        Icons.lock,
        color: AppColors.placeholder,
      ),
    );
  }

  Widget _buildVerifyPasswordField() {
    return defaultTextFormFeild(
      textDirection: TextDirection.rtl,
      controller: verifyPassword,
      context,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)
              ?.translate("Do not leave this field blank.");
        }
        if (password.text != value) {
          return AppLocalizations.of(context)
              ?.translate("Password does not match");
        }
        return null;
      },
      label: AppLocalizations.of(context)?.translate("password_confirmation"),
      prefix: Icon(
        Icons.lock_outline_rounded,
        color: AppColors.placeholder,
      ),
    );
  }

  Widget _buildRoleAndStatusDropdowns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDropdown(
          value: _selectedItemRole,
          items: _items,
          label: "role",
          onChanged: (newValue) =>
              setState(() => _selectedItemRole = newValue!),
        ),
        _buildDropdown(
          value: _selectedItem2,
          items: status,
          label: "status",
          onChanged: (newValue) => setState(() => _selectedItem2 = newValue!),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required String label,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 50.h,
      width: 140.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.placeholder),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.translate(label),
          labelStyle: TextStyle(color: AppColors.placeholder),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
          ),
        ),
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        isExpanded: true,
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              if (selectedImage != null)
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: FileImage(selectedImage!),
                )
              else if (avatarUrl != null && avatarUrl! != "")
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: NetworkImage(avatarUrl! as String),
                )
              else
                Icon(
                  Icons.add_photo_alternate_outlined,
                  color: AppColors.placeholder,
                  size: 40.r,
                ),
              SizedBox(width: 8.w),
              Text(
                AppLocalizations.of(context)!.translate("employee_photo"),
                style: AppFonts.style14normal,
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        InkWell(
          onTap: _pickImage,
          child: Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.placeholder),
              borderRadius: BorderRadius.circular(8.r),
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.cardColorDark
                  : AppColors.textWhite,
            ),
            child: Text(
              AppLocalizations.of(context)!.translate("pick_image"),
              style: AppFonts.style14normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhone1Field() {
    return defaultTextFormFeild(
      context,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!
              .translate("Do not leave this field blank.");
        }
        return null;
      },
      label: AppLocalizations.of(context)!.translate("enter_phone_number"),
      textDirection: TextDirection.rtl,
      controller: phone1,
      prefix: Icon(
        Icons.phone_outlined,
        color: AppColors.placeholder,
      ),
    );
  }

  Widget _buildPhone2Field() {
    return defaultTextFormFeild(
      textDirection: TextDirection.rtl,
      context,
      keyboardType: TextInputType.phone,
      controller: phone2,
      label: AppLocalizations.of(context)!.translate("enter_alternative_phone"),
      prefix: Icon(
        Icons.phone_outlined,
        color: AppColors.placeholder,
      ),
    );
  }

  Widget _buildWhatsAppField() {
    return defaultTextFormFeild(
      textDirection: TextDirection.rtl,
      controller: whatsApp,
      context,
      keyboardType: TextInputType.phone,
      label: AppLocalizations.of(context)!.translate("enter_whatsapp_number"),
      prefix: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 14.h,
          width: 14.w,
          child: SvgPicture.asset(
            AppIcons.whatsAap,
            colorFilter:
                ColorFilter.mode(AppColors.placeholder, BlendMode.saturation),
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeEmailField() {
    return defaultTextFormFeild(
      textDirection: TextDirection.rtl,
      context,
      controller: emailEmp,
      keyboardType: TextInputType.emailAddress,
      label: AppLocalizations.of(context)!.translate("enter_private_email"),
      prefix: Icon(
        Icons.email_outlined,
        color: AppColors.placeholder,
      ),
    );
  }

  Widget _buildAddressField() {
    return defaultTextFormFeild(
      textDirection: TextDirection.rtl,
      context,
      keyboardType: TextInputType.text,
      controller: address,
      label: AppLocalizations.of(context)!.translate("enter_current_address"),
      prefix: Icon(
        Icons.home,
        color: AppColors.placeholder,
      ),
    );
  }

  void _submitForm() {
    if (!formKeyEmployee.currentState!.validate()) return;
    if (_selectedItem2 == null || _selectedItemRole == null) {
      Utils.showSnackBar(context, "Please select role and status");
      return;
    }

    final nameParts = fullName.text.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    final statusValue =
        _selectedItem2 == LocalizationService.tr("active") ? 'active' : 'draft';
    final roleValue =
        _selectedItemRole == LocalizationService.tr("employee") ? '3' : '1';

    if (widget.isEdit) {
      _handleEditEmployee(firstName, lastName, statusValue, roleValue);
    } else {
      _handleAddEmployee(firstName, lastName, statusValue, roleValue);
    }
  }

  void _handleEditEmployee(
      String firstName, String lastName, String statusValue, String roleValue) {
    if (selectedImage != null) {
      EmployeeCubit.get(context).uploadFile(
        selectedImage!,
        companyId: companyId,
        idUser: employeeUserId.toString(),
        employeeId: employeeId.toString(),
        edit: true,
        firstName: firstName,
        password: password.text,
        lastName: lastName,
        status: statusValue,
        email: email.text,
        role: roleValue,
        emailEmp: emailEmp.text,
        address: address.text,
        phone1: phone1.text,
        phone2: phone2.text,
        whatsapp: whatsApp.text,
      );
    } else {
      EmployeeCubit.get(context).editUserFun(
        password: password.text,
        companies: companyId,
        firstName: firstName,
        idUser: employeeUserId.toString(),
        avatar: avatarId,
        employeeId: employeeId.toString(),
        lastName: lastName,
        status: statusValue,
        email: email.text,
        role: roleValue,
        phone1: phone1.text,
        address: address.text,
        phone2: phone2.text,
        whatsapp: whatsApp.text,
        emailEmp: emailEmp.text,
      );
    }
  }

  void _handleAddEmployee(
      String firstName, String lastName, String statusValue, String roleValue) {
    if (selectedImage != null) {
      EmployeeCubit.get(context).uploadFile(
        selectedImage!,
        edit: false,
        companyId: companyId,
        idUser: employeeUserId?.toString() ?? '',
        employeeId: employeeId?.toString() ?? '',
        firstName: firstName,
        lastName: lastName,
        status: statusValue,
        email: email.text,
        role: roleValue,
        password: password.text,
        emailEmp: emailEmp.text,
        address: address.text,
        phone1: phone1.text,
        phone2: phone2.text,
        whatsapp: whatsApp.text,
      );
    } else {
      EmployeeCubit.get(context).addUserFun(
        companies: companyId,
        firstName: firstName,
        lastName: lastName,
        status: statusValue,
        email: email.text,
        role: roleValue,
        password: password.text,
        address: address.text,
        phone2: phone2.text,
        whatsapp: whatsApp.text,
        emailEmp: emailEmp.text,
        phone1: phone1.text,
      );
    }
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: _submitForm,
        child: Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              widget.isEdit
                  ? AppLocalizations.of(context)!.translate("edit_employee")
                  : AppLocalizations.of(context)!.translate("create_account"),
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
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
