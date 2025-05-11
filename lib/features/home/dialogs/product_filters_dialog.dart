import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/features/home/data/cubit.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/token.dart';
import '../../../generated/l10n.dart';
import '../../Tasks_Screens/data/cubit/cubit.dart';


int theRole   = 0;

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  int _selectedTabIndex = 0; // To track the selected tab
  String? selectedState;
  String? selectedEmployee;
  String? selectedLocation;
  DateTime? selectedDate;

  List<String> states = [];
  List<String> employees = [];
  List<String> locations = [];
  Set<String> locationSet = {};
  Set<String> employeeSet = {};


  Map<String, String> employeeMap = {};

  @override
  Widget build(BuildContext context) {
    states =['قيد الانتظار','ملغي','مكتمل','تم الاستلام'];

    for(int i = 0 ; i < TasksCubit.get(context).getUserTaskList!.length ; i ++) {
      for (int i = 0; i < TasksCubit
          .get(context)
          .getUserTaskList!
          .length; i++) {
        var taskLocation = TasksCubit
            .get(context)
            .getUserTaskList![i].location?.address;
        if (taskLocation != null) {
          locationSet.add(taskLocation);
          print('taskLocation ,,,,,,,,,,,,,,,,, $taskLocation');
        }
      }

      locations = locationSet.toList();
    }
      for(int i = 0 ; i < TasksCubit.get(context).getAllTaskList!.length ; i ++)
    {
      for (int i = 0; i < TasksCubit.get(context).getAllTaskList!.length; i++) {
        var taskLocation = TasksCubit.get(context).getAllTaskList![i].location?.address;
        if (taskLocation != null) {
          locationSet.add(taskLocation);
        }
      }

      locations = locationSet.toList();

      for (int i = 0; i < EmployeeCubit.get(context).users!.length; i++) {
        var user = EmployeeCubit.get(context).users![i];
        String fullName = '${user.first_name} ${user.last_name}';  // Combine first and last name
        employeeSet.add(fullName);  // Avoid duplicates

        employeeMap[user.id!.toString()] = fullName;
      }

      employees = employeeSet.toList();

    }
    return Dialog(
      backgroundColor:
      globalDark ? AppColors.cardColorDark : AppColors.textWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Container(
        padding:  EdgeInsets.all(10.h),
        height: 340.h,

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: ()
              {

                role == '3' ? TasksCubit.get(context).getUserTaskFun(userId: userId.toString())  :  TasksCubit.get(context).getAllTasksFun();
                Navigator.pop(context);
              }, child: Row(
                children: [
                 const Icon(Icons.cancel_presentation_outlined, size: 20,),
                  SizedBox(width: 8.w,),
                   Text(S.of(context).cancel_filter, style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),),
                ],
              )),
            ),
            Center(child: Text(S.of(context).filter_options,style: AppFonts.style20BoldColored,)),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton(context, "الحالة", 0),
                  Container(),
                _buildTabButton(context, "التاريخ", 1),
             role == '1' ?   _buildTabButton(context, "الموظف", 2)
                 : Container(),
                _buildTabButton(context, "الموقع", 3),
              ],
            ),
            SizedBox(height: 16.h),

            // Tab Content
           _buildTabContent(),

            SizedBox(height: 20.h),
            // Accept Button
            Center(
              child: defaultButton(
                width: 243.w ,
                height: 48.h,
                text: 'موافق',
                toPage: (){
              switch(selectedState)
              {
                case 'قيد الانتظار' :
                  selectedState = 'inbox';
                case 'مكتمل' :
                  selectedState = 'completed';
                case 'تم الاستلام' :
                  selectedState = 'progress';
                case 'ملغي' :
                  selectedState = 'cancelled';
                default:
                  selectedState = null;

              }
                  String? employee = selectedEmployee;
                  String? location = selectedLocation;
                  String? date = selectedDate != null ? selectedDate!.toLocal().toString().split(' ')[0] : null;

                  TasksCubit.get(context).getAllTasksFunWithFilter(
                    status: selectedState,
                    employee: role == '3' ?
                    userId :(selectedEmployee != null ? employeeMap.keys.firstWhere((id) => employeeMap[id] == employee) : null),
                    location: location,
                    date: date,
                  );

                  Navigator.pop(context);
                },
                textSize: 18.sp,
                context: context,
                isColor: true,

              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build tab buttons
  Widget _buildTabButton(BuildContext context, String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedTabIndex == index ? AppColors.primary :  globalDark ? AppColors.darkBackground : AppColors.textWhite,
          border: Border.all(
            color: _selectedTabIndex == index ? AppColors.primary : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: _selectedTabIndex == index ? AppColors.textWhite :  globalDark ? AppColors.gray : AppColors.textBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Helper function to build tab content
  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildDropdown(
          title: 'الحالة',
          value: selectedState,
          items: states,
          onChanged: (value) {
            setState(() {
              selectedState = value;
            });
          },
        );
      case 1:
        return _buildDatePicker();
      case 2:
        return _buildDropdown(
          title: 'الموظف',
          value: selectedEmployee,
          items: employees,
          onChanged: (value) {
            setState(() {
              selectedEmployee = value;
            });
          },
        );
      case 3:
        return _buildDropdown(
          title: 'الموقع',
          value: selectedLocation,
          items: locations,
          onChanged: (value) {
            setState(() {
              selectedLocation = value;
            });
          },
        );
      default:
        return Container();
    }
  }


  // Widget for Dropdown Fields
  Widget _buildDropdown({
    required String title,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style:  TextStyle(fontSize: 16.sp)),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal:  10.h),
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.placeholder),
              borderRadius: BorderRadius.circular(8.h),

            ),
            child: DropdownButton<String>(

              borderRadius: BorderRadius.circular(8.h),
              isExpanded: true,
              underline: Container(),
              value: value,
              hint: Text(S.of(context).choose_title),
              items: items.map((String item) {
                return DropdownMenuItem<String>(

                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
              // underline: Container(
              //   height: 1,
              //   color: Colors.grey,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  // Date Picker Field
  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).date, style: TextStyle(fontSize: 16)),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
            child: Container(
              width:  double.infinity,
              padding:const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedDate != null
                    ? "${selectedDate!.toLocal()}".split(' ')[0]
                    : 'حدد التاريخ',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class RoleDialog extends StatefulWidget {
  @override
  _RoleDialogState createState() => _RoleDialogState();
}

class _RoleDialogState extends State<RoleDialog> {
  int _selectedTabIndex = 0; // To track the selected tab
  String? selectedState;


  List<String> states = ['مدير' , 'موظف'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:  globalDark ? AppColors.cardColorDark : AppColors.textWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Container(

        padding:  EdgeInsets.all(20.h),
        height: 300.h,

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: ()
                  {

                    EmployeeCubit.get(context).getAllSales();
                    Navigator.pop(context);
                    theRole = 0;
                  }, child: Row(
                children: [
                  const Icon(Icons.cancel_presentation_outlined, size: 20,),
                  SizedBox(width: 8.w,),
                   Text(S.of(context).cancel_filter, style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),),
                ],
              )),
            ),
            SizedBox(height: 10.h),
            Center(child: Text(S.of(context).choose_role,style: AppFonts.style20BoldColored,)),

            _buildTabContent(),
            SizedBox(height: 20.h),
            // Accept Button
            Center(
              child: defaultButton(
                width: 243.w ,
                height: 48.h,
                text: 'موافق',
                toPage: (){
                 if(selectedState == 'مدير')
                 {
                   EmployeeCubit.get(context).getAdmins(role: 1);
                   theRole = 1;
                 } else if (selectedState == 'موظف')
                 {
                   EmployeeCubit.get(context).getAdmins(role: 3);
                   theRole = 3;
                 } else
                 {
                   EmployeeCubit.get(context).getAllSales();
                   theRole = 0;
                 }


               Navigator.pop(context);
                },
                textSize: 18.sp,
                context: context,
                isColor: true,

              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build tab buttons
  Widget _buildTabButton(BuildContext context, String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedTabIndex == index ? AppColors.primary : Colors.white,
          border: Border.all(
            color: _selectedTabIndex == index ? AppColors.primary : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _selectedTabIndex == index ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Helper function to build tab content
  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildDropdown(
          title: 'الدور',
          value: selectedState,
          items: states,
          onChanged: (value) {
            setState(() {
              selectedState = value;
            });
          },
        );
      case 1:
        return Container();
      case 2:
        return Container();

      default:
        return Container();
    }
  }

  // Widget for Dropdown Fields
  Widget _buildDropdown({
    required String title,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal:  10.h),
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.placeholder),
              borderRadius: BorderRadius.circular(8.h),

            ),
            child: DropdownButton<String>(

              borderRadius: BorderRadius.circular(8.h),
              isExpanded: true,
              underline: Container(),
              value: value,
              hint: Text(S.of(context).choose_title),
              items: items.map((String item) {
                return DropdownMenuItem<String>(

                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
              // underline: Container(
              //   height: 1,
              //   color: Colors.grey,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  // Date Picker Field
  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(S.of(context).date, style: TextStyle(fontSize: 16)),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                //  selectedDate = pickedDate;
                });
              }
            },
            child: Container(
              width:  double.infinity,
              padding:const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                 'حدد التاريخ',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ProductFiltersDialog extends StatelessWidget {
//   const ProductFiltersDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(AppDefaults.padding),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 56,
//               height: 3,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: AppDefaults.borderRadius,
//               ),
//               margin: const EdgeInsets.all(8),
//             ),
//             const _FilterHeader(),
//             const _SortBy(),
//             const _PriceRange(),
//             const _CategoriesSelector(),
//             const _BrandSelector(),
//             _RatingStar(
//               totalStarsSelected: 4,
//               onStarSelect: (v) {
//                 debugPrint('Star selected $v');
//               },
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.all(AppDefaults.padding),
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Apply Filter'),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _RatingStar extends StatelessWidget {
//   const _RatingStar({
//     required this.totalStarsSelected,
//     required this.onStarSelect,
//   });
//
//   final int totalStarsSelected;
//   final void Function(int) onStarSelect;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(AppDefaults.padding),
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Rating Star',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: List.generate(
//               /// You cannot add more than 5 star or less than 0 star
//               5,
//               (index) {
//                 if (index < totalStarsSelected) {
//                   return InkWell(
//                     onTap: () => onStarSelect(index + 1),
//                     child: const Icon(
//                       Icons.star_rounded,
//                       color: Color(0xFFFFC107),
//                       size: 32,
//                     ),
//                   );
//                 } else {
//                   return InkWell(
//                     onTap: () => onStarSelect(index + 1),
//                     child: const Icon(
//                       Icons.star_rounded,
//                       color: Colors.grey,
//                       size: 32,
//                     ),
//                   );
//                 }
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class _BrandSelector extends StatelessWidget {
//   const _BrandSelector();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(AppDefaults.padding),
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Brand',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             child: Wrap(
//               alignment: WrapAlignment.start,
//               spacing: 16,
//               runSpacing: 16,
//               children: [
//
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class _CategoriesSelector extends StatelessWidget {
//   const _CategoriesSelector();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(AppDefaults.padding),
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Categories',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             child: Wrap(
//               alignment: WrapAlignment.start,
//               runAlignment: WrapAlignment.spaceAround,
//               crossAxisAlignment: WrapCrossAlignment.start,
//               spacing: 16,
//               runSpacing: 16,
//               children: [
//
//
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class _PriceRange extends StatefulWidget {
//   const _PriceRange();
//
//   @override
//   State<_PriceRange> createState() => _PriceRangeState();
// }
//
// class _PriceRangeState extends State<_PriceRange> {
//   RangeValues _currentRangeValues = const RangeValues(40, 80);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(AppDefaults.padding),
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Price Range',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//             ),
//           ),
//           RangeSlider(
//             max: 100,
//             min: 0,
//             labels: RangeLabels(
//               _currentRangeValues.start.round().toString(),
//               _currentRangeValues.end.round().toString(),
//             ),
//             onChanged: (RangeValues values) {
//               setState(() {
//                 _currentRangeValues = values;
//               });
//             },
//             activeColor: AppColors.primary,
//             inactiveColor: AppColors.gray,
//             values: _currentRangeValues,
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('\$0'),
//                 Text('\$50'),
//                 Text('\$100'),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class _SortBy extends StatelessWidget {
//   const _SortBy();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(AppDefaults.padding),
//       child: Row(
//         children: [
//           Text(
//             'Sort By',
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//           ),
//           const Spacer(),
//           DropdownButton(
//             value: 'Popularity',
//             underline: const SizedBox(),
//             icon: const Icon(
//               Icons.arrow_drop_down,
//               color: AppColors.primary,
//             ),
//             items: const [
//               DropdownMenuItem(
//                 value: 'Popularity',
//                 child: Text('Popularity'),
//               ),
//               DropdownMenuItem(
//                 value: 'Price',
//                 child: Text('Price'),
//               ),
//             ],
//             onChanged: (v) {},
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class _FilterHeader extends StatelessWidget {
//   const _FilterHeader();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           width: 56,
//           alignment: Alignment.centerLeft,
//           child: SizedBox(
//             height: 40,
//             width: 40,
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.zero,
//                 backgroundColor: AppColors.scaffoldWithBoxBackground,
//               ),
//               child: const Icon(
//                 Icons.close,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//         Text(
//           'Filter',
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//         ),
//         SizedBox(
//           width: 56,
//           child: TextButton(
//             onPressed: () {},
//             child: Text(
//               'Reset',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: Colors.black,
//                   ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
