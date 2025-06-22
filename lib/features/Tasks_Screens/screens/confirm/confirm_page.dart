import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/default_app_bar.dart';
import 'package:itsale/core/constants/app_defaults.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/states.dart';
import 'package:itsale/features/Tasks_Screens/screens/confirm/confirm_task_for_employee.dart';
import 'package:itsale/features/addEmployee/components/no_data_screen.dart';

import '../../../../core/constants/app_animation.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/snack_bar.dart';
import '../../../../core/utils/token.dart';

class ConfirmTaskListPage extends StatefulWidget {
  const ConfirmTaskListPage({super.key});

  @override
  State<ConfirmTaskListPage> createState() => _ConfirmTaskListPageState();
}

class _ConfirmTaskListPageState extends State<ConfirmTaskListPage> {
  @override
  void initState() {
    TasksCubit.get(context)
        .getUserTaskFun(userId: userId.toString(), status: 'inbox');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 2),
          child: Column(
            children: [
              SizedBox(
                height: 14.h,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppDefaults.padding.w / 2),
                child:
                    const CustomAppBar(back: false, title: 'المهمات الواردة'),
              ),
              BlocConsumer<TasksCubit, TasksStates>(
                builder: (context, state) {
                  if (state is EditErrorUserTaskState) {
                    return Text("للاسف حدث خطأ");
                  }
                  if (state is EditLoadingUserTaskState) {
                    return AppLottie.loader;
                  }

                  return TasksCubit.get(context)
                          .getUserTaskListWithStatus!
                          .isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: TasksCubit.get(context)
                              .getUserTaskListWithStatus!
                              .length,
                          itemBuilder: (context, index) => ConfirmTaskCardList(
                            statusColor: Colors.orange,
                            index: index,
                            id: TasksCubit.get(context)
                                .getUserTaskListWithStatus![index]
                                .id!
                                .toInt(),
                            statusText: TasksCubit.get(context)
                                .getUserTaskListWithStatus![index]
                                .task_status
                                .toString(),
                            taskName: TasksCubit.get(context)
                                .getUserTaskListWithStatus![index]
                                .title
                                .toString(),
                            taskNotes: TasksCubit.get(context)
                                .getUserTaskListWithStatus![index]
                                .notes
                                .toString(),
                            date: TasksCubit.get(context)
                                .getUserTaskListWithStatus![index]
                                .created_on
                                .toString()
                                .substring(0, 10),
                            textDate: 'تاريخ الانشاء',
                            location: TasksCubit.get(context).getUserTaskListWithStatus![index].loc != null &&
                                TasksCubit.get(context).getUserTaskListWithStatus![index].loc!.isNotEmpty
                                ? TasksCubit.get(context)
                                .getUserTaskListWithStatus![index]
                                .loc![0]
                                .address
                                .toString()
                                : AppLocalizations.of(context)!.translate("not_available"),
                          ),
                        )
                      : nothing(context,
                          text: 'لا يوجد مهمات واردة حتى الان',
                          route: AppRoutes.addTask,
                          button: 'مهمة ');
                },
                listener: (context, state) {
                  if (state is EditSuccessUserTaskState) {
                    Utils.showSnackBar(context, 'تم استلام المهمة بنجاح');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
