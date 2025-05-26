import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itsale/core/components/network_image.dart';
import 'package:itsale/core/constants/app_animation.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/utils/token.dart';

import 'package:itsale/features/home/data/cubit.dart';
import 'package:itsale/features/home/data/states.dart';
import 'package:svg_flutter/svg.dart';

import '../../../core/app/app.dart';
import '../../../core/components/app_text_form_field.dart';
import '../../../core/components/default_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/navigation.dart';
import '../../../core/utils/snack_bar.dart';
import '../../../generated/l10n.dart';

class AddNewEmployee extends StatefulWidget {
  final int empId;
  final bool isEdit;

  const AddNewEmployee({super.key, required this.empId, required this.isEdit});

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  final List<String> _items = ['موظف', 'مدير'];
  final List<String> status = ['متوقف', 'نشط'];

  String _selectedItemRole = 'موظف';
  String _selectedItem2 = 'نشط';
  String avatar = '';

  int? avatarId;

  int? employeeId;

  int? employeeUserId;

  var fullName = TextEditingController();
  var email = TextEditingController();
  var emailEmp = TextEditingController();
  var password = TextEditingController();
  var verifyPassword = TextEditingController();
  var phone1 = TextEditingController();
  var phone2 = TextEditingController();
  var whatsApp = TextEditingController();
  var address = TextEditingController();
  var formKeyEmployee = GlobalKey<FormState>();

  File? selectedImage;

  Future<void> _pickImage() async {
    final pickedFile;

    pickedFile = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> loadEmployeeData() async {
    for (int x = 0; x < EmployeeCubit.get(context).users!.length; x++) {
      if (widget.empId == EmployeeCubit.get(context).users![x].id) {
        _selectedItemRole = EmployeeCubit.get(context).users![x].role!.id == 3
            ? 'موظف'
            : 'مدير';
        _selectedItem2 = EmployeeCubit.get(context).users![x].status == 'active'
            ? 'نشط'
            : 'متوقف';

        password.text = '1234568';
        fullName.text =
            '${EmployeeCubit.get(context).users![x].first_name.toString()} ${EmployeeCubit.get(context).users![x].last_name.toString()}';
        email.text = EmployeeCubit.get(context).users![x].email.toString();
        email.text = EmployeeCubit.get(context).users![x].email.toString();
        emailEmp.text =
            EmployeeCubit.get(context).users![x].employee_info![0].email != null
                ? EmployeeCubit.get(context)
                    .users![x]
                    .employee_info![0]
                    .email
                    .toString()
                : '';
        phone1.text = EmployeeCubit.get(context)
            .users![x]
            .employee_info![0]
            .phone_1
            .toString();
        phone2.text =
            EmployeeCubit.get(context).users![x].employee_info![0].phone_2 !=
                    null
                ? EmployeeCubit.get(context)
                    .users![x]
                    .employee_info![0]
                    .phone_2
                    .toString()
                : '';
        whatsApp.text =
            EmployeeCubit.get(context).users![x].employee_info![0].whatsapp !=
                    null
                ? EmployeeCubit.get(context)
                    .users![x]
                    .employee_info![0]
                    .whatsapp
                    .toString()
                : '';
        address.text =
            EmployeeCubit.get(context).users![x].employee_info![0].address !=
                    null
                ? EmployeeCubit.get(context)
                    .users![x]
                    .employee_info![0]
                    .address
                    .toString()
                : '';
        avatar = EmployeeCubit.get(context).users![x].avatar != null
            ? EmployeeCubit.get(context)
                .users![x]
                .avatar!
                .data!
                .full_url
                .toString()
            : '';
        avatarId = EmployeeCubit.get(context).users![x].avatar?.id;
        employeeId = EmployeeCubit.get(context).users![x].employee_info![0].id;
        employeeUserId = EmployeeCubit.get(context).users![x].id;
      }
    }
  }

  @override
  void initState() {
    widget.isEdit ? loadEmployeeData() : Container();
    // TODO: implement initState
    super.initState();
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
                            : 'إضافة موظف جديد',
                        back: true,
                      ),
                      const Divider(),
                      SizedBox(height: 10.h),
                      BlocConsumer<EmployeeCubit, EmployeeStates>(
                        listener: (context, state) {
                          if (state is AddErrorEmployeeInfoState ||
                              state is EditErrorEmployeeInfoState ||
                              state is ErrorEditUserState) {
                            return Utils.showSnackBar(
                                context, 'حدثت مشكلة حاول مرة اخرى');
                          }
                          if (state is AddSuccessEmployeeInfoState ||
                              state is EditSuccessEmployeeInfoState ||
                              state is SuccessEditUserState) {
                            if (widget.isEdit) {
                              navigateTo(context, AppRoutes.entryPoint);
                              return Utils.showSnackBar(
                                  context,
                                  AppLocalizations.of(context)!
                                      .translate("edit_done_successfuly"));
                            } else {
                              return Utils.showSnackBar(
                                  context, 'تمت الاضافة بنجاح');
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is AddLoadingUserState ||
                              state is AddLoadingEmployeeInfoState ||
                              state is PostLoadingFileState ||
                              state is LoadingEditUserState ||
                              state is EditLoadingEmployeeInfoState) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: AppLottie.loader),
                              ],
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionHeader(title: AppLocalizations.of(context)!.translate("login_data")),
                              SizedBox(height: 16.h),
                              defaultTextFormFeild(
                                context,
                                keyboardType: TextInputType.text,
                                validate: (value) {
                                  if (value == null || value == '') {
                                    return AppLocalizations.of(context)!.translate("Do not leave this field blank.");
                                  }
                                  return null;
                                },
                                controller: fullName,
                                label: AppLocalizations.of(context)!.translate("choose_employee_name"),
                                onTap: () {},
                                prefix: Icon(
                                  Icons.person,
                                  color: AppColors.placeholder,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              defaultTextFormFeild(
                                controller: email,
                                context,
                                keyboardType: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value == null || value == '') {
                                    return AppLocalizations.of(context)!.translate("Do not leave this field blank.");
                                  }
                                  return null;
                                },
                                label: AppLocalizations.of(context)!.translate("write_email"),
                                onTap: () {},
                                prefix: Icon(
                                  Icons.email,
                                  color: AppColors.placeholder,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              !widget.isEdit
                                  ? defaultTextFormFeild(
                                      controller: password,
                                      context,
                                      keyboardType: TextInputType.text,
                                      validate: (value) {
                                        if (value == null || value == '') {
                                          return AppLocalizations.of(context)!.translate("Do not leave this field blank.");
                                        }
                                        return null;
                                      },
                                      label: AppLocalizations.of(context)!.translate("write_password"),
                                      onTap: () {},
                                      prefix: Icon(
                                        Icons.lock,
                                        color: AppColors.placeholder,
                                      ),
                                    )
                                  : Container(),
                              SizedBox(height: 16.h),
                              !widget.isEdit
                                  ? defaultTextFormFeild(
                                      controller: verifyPassword,
                                      context,
                                      keyboardType: TextInputType.text,
                                      validate: (value) {
                                        if (value == null || value == '') {
                                          return AppLocalizations.of(context)!.translate("Do not leave this field blank.");
                                        }
                                        if (password.text !=
                                            verifyPassword.text) {
                                          return AppLocalizations.of(context)!.translate("Password does not match");
                                        }
                                        return null;
                                      },
                                      label: AppLocalizations.of(context)!.translate("password_confirmation"),
                                      onTap: () {},
                                      prefix: Icon(
                                        Icons.lock_outline_rounded,
                                        color: AppColors.placeholder,
                                      ),
                                    )
                                  : Container(),
                              !widget.isEdit
                                  ? SizedBox(height: 16.h)
                                  : Container(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.placeholder),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!.translate("active"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0.r),
                                        ),
                                      ),
                                      value: _selectedItemRole,
                                      // Current value in the dropdown
                                      items: _items.map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedItemRole =
                                              newValue ?? _selectedItemRole;
                                        });
                                      },
                                      hint: Text(AppLocalizations.of(context)!
                                          .translate("employee")),
                                      isExpanded:
                                          true, // Makes the dropdown expand to fit the screen width
                                    ),
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.placeholder),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'نشط',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0.r),
                                        ),
                                      ),
                                      value: _selectedItem2,
                                      // Current value in the dropdown
                                      items: status.map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedItem2 =
                                              newValue ?? _selectedItem2;
                                        });
                                      },
                                      hint: Text(AppLocalizations.of(context)!.translate("active")),
                                      isExpanded:
                                          true, // Makes the dropdown expand to fit the screen width
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                               SectionHeader(title: AppLocalizations.of(context)!.translate("employee_data")),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        (widget.isEdit && avatar != '')
                                            ? SizedBox(
                                                height: 40.h,
                                                width: 40.w,
                                                child: NetworkImageWithLoader(
                                                    avatar))
                                            : selectedImage != null
                                                ? Image.file(
                                                    selectedImage!,
                                                    height: 16.h,
                                                    width: 16.w,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .add_photo_alternate_outlined,
                                                    color:
                                                        AppColors.placeholder,
                                                  ),
                                        SizedBox(width: 5.w),
                                        Text(
                                         AppLocalizations.of(context)!.translate("employee_photo"),
                                          style: AppFonts.style14normal,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  InkWell(
                                    onTap: () {
                                      _pickImage();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8.h),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.placeholder,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: globalDark
                                            ? AppColors.cardColorDark
                                            : AppColors.textWhite,
                                      ),
                                      child: Text(
                                        'اختر الصورة',
                                        style: AppFonts.style14normal,
                                      ),
                                    ),
                                  ),
                                ],
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
                                label: 'أكتب رقم الهاتف',
                                onTap: () {},
                                controller: phone1,
                                prefix: Icon(
                                  Icons.phone_outlined,
                                  color: AppColors.placeholder,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              defaultTextFormFeild(
                                context,
                                keyboardType: TextInputType.phone,
                                validate: (value) {},
                                controller: phone2,
                                label: 'أكتب رقم الهاتف البديل',
                                onTap: () {},
                                prefix: Icon(
                                  Icons.phone_outlined,
                                  color: AppColors.placeholder,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              defaultTextFormFeild(
                                controller: whatsApp,
                                context,
                                keyboardType: TextInputType.phone,
                                validate: (value) {},
                                label: 'أكتب رقم الواتساب',
                                onTap: () {},
                                prefix: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 14.h,
                                    width: 14.w,
                                    child: SvgPicture.asset(
                                      AppIcons.whatsAap,
                                      colorFilter: ColorFilter.mode(
                                          AppColors.placeholder,
                                          BlendMode.saturation),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              defaultTextFormFeild(
                                context,
                                controller: emailEmp,
                                keyboardType: TextInputType.emailAddress,
                                validate: (value) {},
                                label: 'أكتب البريد الالكترونى الخاص',
                                onTap: () {},
                                prefix: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.placeholder,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              defaultTextFormFeild(
                                context,
                                keyboardType: TextInputType.text,
                                validate: (value) {},
                                controller: address,
                                label: 'أكتب عنوان الأقامة الحالى',
                                onTap: () {},
                                prefix: Icon(
                                  Icons.home,
                                  color: AppColors.placeholder,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              widget.isEdit
                  ? InkWell(
                      onTap: () {
                        List<String> nameParts = fullName.text.split(' ');
                        String firstName =
                            nameParts.isNotEmpty ? nameParts[0] : '';
                        String lastName = nameParts.length > 1
                            ? nameParts.sublist(1).join(' ')
                            : '';

                        if (formKeyEmployee.currentState!.validate() &&
                            selectedImage != null &&
                            _selectedItem2 != null &&
                            _selectedItemRole != null) {
                          EmployeeCubit.get(context).uploadFile(
                              idUser: employeeUserId.toString(),
                              selectedImage!,
                              employeeId: employeeId.toString(),
                              edit: widget.isEdit,
                              firstName: firstName,
                              password: password.text,
                              lastName: lastName,
                              status:
                                  _selectedItem2 == 'نشط' ? 'active' : 'hold',
                              email: email.text,
                              role: _selectedItemRole == 'موظف' ? '3' : '1',
                              emailEmp: emailEmp.text,
                              address: address.text,
                              phone1: phone1.text,
                              phone2: phone2.text,
                              whatsapp: whatsApp.text);
                        } else if (formKeyEmployee.currentState!.validate() &&
                            selectedImage == null &&
                            _selectedItem2 != null &&
                            _selectedItemRole != null) {
                          EmployeeCubit.get(context).editUserFun(
                            firstName: firstName,
                            idUser: employeeUserId.toString(),
                            avatar: avatarId,
                            employeeId: employeeId.toString(),
                            lastName: lastName,
                            status: _selectedItem2 == 'نشط' ? 'active' : 'hold',
                            email: email.text,
                            role: _selectedItemRole == 'موظف' ? '3' : '1',
                            phone1: phone1.text,
                            address: address.text,
                            phone2: phone2.text,
                            whatsapp: whatsApp.text,
                            emailEmp: emailEmp.text,
                          );
                        }
                      },
                      child: _buildSubmitButton())
                  : InkWell(
                      onTap: () {
                        List<String> nameParts = fullName.text.split(' ');

                        String firstName =
                            nameParts.isNotEmpty ? nameParts[0] : '';
                        String lastName = nameParts.length > 1
                            ? nameParts.sublist(1).join(' ')
                            : '';

                        if (formKeyEmployee.currentState!.validate() &&
                            selectedImage != null &&
                            _selectedItem2 != null &&
                            _selectedItemRole != null) {
                          EmployeeCubit.get(context).uploadFile(selectedImage!,
                              edit: false,
                              companyId: companyId,
                              idUser: employeeUserId.toString(),
                              employeeId: employeeId.toString(),
                              firstName: firstName,
                              lastName: lastName,
                              status:
                                  _selectedItem2 == 'نشط' ? 'active' : 'hold',
                              email: email.text,
                              role: _selectedItemRole == 'موظف' ? '3' : '1',
                              password: password.text,
                              emailEmp: emailEmp.text,
                              address: address.text,
                              phone1: phone1.text,
                              phone2: phone2.text,
                              whatsapp: whatsApp.text);
                        } else if (formKeyEmployee.currentState!.validate() &&
                            selectedImage == null &&
                            _selectedItem2 != null &&
                            _selectedItemRole != null) {
                          EmployeeCubit.get(context).adduserFun(
                            firstName: firstName,
                            lastName: lastName,
                            status: _selectedItem2 == 'نشط' ? 'active' : 'hold',
                            email: email.text,
                            role: _selectedItemRole == 'موظف' ? '3' : '1',
                            password: password.text,
                            address: address.text,
                            phone2: phone2.text,
                            whatsapp: whatsApp.text,
                            emailEmp: emailEmp.text,
                            phone1: phone1.text,
                          );
                        }
                      },
                      child: _buildSubmitButton()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'إضافة موظف جديد ',
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
            widget.isEdit ? 'تعديل الموظف' : 'إنشاء الحساب',
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
