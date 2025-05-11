import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/components/app_text_form_field.dart';
import 'package:itsale/core/components/default_app_bar.dart';
import 'package:itsale/core/components/network_image.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/utils/token.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/home/data/cubit.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/validators.dart';
import '../../../generated/l10n.dart';
import '../../auth/data/cubit.dart';

class MainSettingsPage extends StatefulWidget {
  const MainSettingsPage({super.key});

  @override
  State<MainSettingsPage> createState() => _MainSettingsPageState();
}

class _MainSettingsPageState extends State<MainSettingsPage> {
  final key = GlobalKey<FormState>();

  bool isPasswordShown = false;
  onPassShowClicked() {
    setState(()
    {
      isPasswordShown = !isPasswordShown;

    });
  }
  var passController = TextEditingController();
  var verifyPassController = TextEditingController();
  bool click = true ;

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var fName = TextEditingController();
    var lName = TextEditingController();
    var email = TextEditingController();
  //  var phone = TextEditingController();

    fName.text  = cubit.getInfo!.first_name.toString() ?? '';
    lName.text  = cubit.getInfo!.last_name.toString() ?? '';
    email.text  = cubit.getInfo!.email.toString() ?? '';
   // phone.text  = '${cubit.getInfo!.first_name.toString()} ${cubit.getInfo!.last_name.toString()}' ?? '';


    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  const  CustomAppBar(back: true, title: 'تعديل الحساب'),
                    SizedBox(height: 20.h),
                    ProfileHeader(),

                    SizedBox(height: 20.h),

                    defaultTextFormFeild
                      (context,
                        prefix: Icon(Icons.perm_identity_sharp),
                        controller: fName,

                        keyboardType: TextInputType.name,
                        validate: (v) {}, label: 'الاسم الاول'),
                    SizedBox(height: 15.h),
                    defaultTextFormFeild
                      (context,
                        prefix: const Icon(Icons.person_2_outlined),
                        keyboardType: TextInputType.name,
                        controller: lName,
                        validate: (v) {}, label: 'الاسم الاخير'),
                    SizedBox(height: 15.h),
                    defaultTextFormFeild
                      (context,
                        prefix: const Icon(Icons.email_outlined),
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validate: (v) {}, label: 'البريد الالكتروني'),
                    // SizedBox(height: 15.h),
                    // defaultTextFormFeild
                    //   (context,
                    //
                    //     keyboardType: TextInputType.phone,
                    //     validate: (v) {}, label: 'رقم الهاتف'),


SizedBox(height: 20.h,),
                   InkWell(
                     onTap: ()
                     {
setState(() {
  click = ! click ;
});
                     },
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(S.of(context).change_password,style: AppFonts.style16semiBold,),
                       const  Icon(Icons.keyboard_arrow_down),
                       ],
                     ),
                   ),

                click ?  Container() : Form(
                  key: key,
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          defaultTextFormFeild(
                            context,

                            keyboardType: TextInputType.text,

                            controller: passController,

                            validate: Validators.password.call,

                            secure: !isPasswordShown,

                            prefix: const Icon(AppIcons.lock),
                            label: ' كلمة المرور الجديدة',
                            suffix: IconButton(
                              onPressed: onPassShowClicked,
                              icon: Icon(
                                isPasswordShown ? AppIcons.eye :
                                AppIcons.eyeNonVisible,
                                size: 24,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          defaultTextFormFeild(
                            context,

                            keyboardType: TextInputType.text,

                            controller: verifyPassController,
                  onChanged: (v)
                  {
                  if(key.currentState!.validate())
                  {

                  }
                  },
                            validate: (v)
                            {
                              if(v != passController.text) {
                                return 'كلمة السر غير متطابقة';
                              }
                              return null ;
                            },


                            secure: !isPasswordShown,

                            prefix: const Icon(AppIcons.lock),
                            label: ' تأكيد كلمة المرور الجديدة',
                            suffix: IconButton(
                              onPressed: onPassShowClicked,
                              icon: Icon(
                                isPasswordShown ? AppIcons.eye :
                                AppIcons.eyeNonVisible,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                ) ,
                    SizedBox(height: 40.h),

                    defaultButton(
                        context: context,
                        text: 'حفظ التغييرات',
                        width: 250.w, height: 48.h, isColor: true,
                        textSize: 18.sp, toPage: ()
                        {
                          if(cubit.getInfo!.avatar == null && selectedImageForSetting == null)
                          {
                            EmployeeCubit.get(context).editUserFun
                              (
                              password: passController.text,
                              idUser: userId.toString(),
                              firstName: fName.text,


                              phone1: role == '1' ?
                              EmployeeCubit
                                  .get(context)
                                  .users![int.parse(userId.toString())]
                                  .employee_info![0].phone_1.toString() : '',
                              employeeId: '0',
                              role: cubit.getInfo!.role!.id.toString(),
                              email: email.text,
                              lastName: lName.text,

                              status: 'active',

                            ).then((onValue) {
                              cubit.getUserDataFun(context);
                              log('done');
                            navigateTo(context, AppRoutes.entryPoint);
                            });
                          } else {
                            selectedImageForSetting != null ?
                            EmployeeCubit.get(context).uploadFile
                              (


                              selectedImageForSetting!,
                              idUser: userId.toString(),
                              firstName: fName.text,
                              phone1: role == '1' ? EmployeeCubit
                                  .get(context)
                                  .users![int.parse(userId.toString())]
                                  .employee_info![0].phone_1.toString() : '',
                              employeeId: '0',
                              role: cubit.getInfo!.role!.id.toString(),
                              email: email.text,
                              lastName: lName.text,
                              edit: true,
                              status: 'active',
                              password: '1235689',
                            ).then((onValue) {
                              cubit.getUserDataFun(context);
                              log('done 1');
                             navigateTo(context, AppRoutes.entryPoint);
                            }) :
                            EmployeeCubit.get(context).editUserFun
                              (
                              password: passController.text,
                              idUser: userId.toString(),
                              firstName: fName.text,
                              avatar: cubit.getInfo!.avatar?.id,
                              phone1: role == '1' ?
                              EmployeeCubit
                                  .get(context)
                                  .users![int.parse(userId.toString())]
                                  .employee_info![0].phone_1.toString() : '',
                              employeeId: '0',
                              role: cubit.getInfo!.role!.id.toString(),
                              email: email.text,
                              lastName: lName.text,

                              status: 'active',

                            ).then((onValue) {
                              cubit.getUserDataFun(context);
                              log('done 2');
                             navigateTo(context, AppRoutes.entryPoint);
                            });
                          }}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
File? selectedImageForSetting ;
class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
@override
  void initState() {
  selectedImageForSetting = null;
    // TODO: implement initState
    super.initState();
  }

  Future<void> pickImage() async {
    final pickedFile;

    pickedFile = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImageForSetting = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        selectedImageForSetting != null ? Stack(
          children: [
            Container(
                height: 90.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Image.file(selectedImageForSetting!)),
            Positioned(
              top: 5.h,
              right: 5.w,
              child: InkWell(onTap: ()
              {
                setState(() {
                  selectedImageForSetting = null ;
                });
              },
              child: const Icon( Icons.cancel)),
            ),
          ],
        ) :    AppCubit.get(context).getInfo!.avatar != null  ?
        SizedBox(
            height: 90.h,
            width: 90.w,
            child: NetworkImageWithLoader(
                AppCubit.get(context).getInfo!.avatar!.data!.full_url.toString()))

       :  Padding(
      padding:  EdgeInsets.only(right: 2.0.w,left: 10.0.w),
      child: Container(
        height: 90.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    ),

        SizedBox(height: 20.h),
        InkWell(
          onTap: () {pickImage();},
          child: Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(

              border: Border.all(color:  AppColors.placeholder,),
              borderRadius: BorderRadius.circular(8.r),
              color: globalDark ?  AppColors.textBlack : AppColors.textWhite,
            ),
            child: Text(
              'اختر صورة',
              style: AppFonts.style14normal,
            ),
          ),
        ),
      ],
    );
  }
}

