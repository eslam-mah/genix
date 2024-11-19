import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';

import '../../../../../core/localization/all_app_strings.dart';

class CustomDropdownMenu extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final TextEditingController categoryController;

  const CustomDropdownMenu({
    super.key,
    this.onChanged,
    required this.categoryController,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? selectedCategory;


  @override
  Widget build(BuildContext context) {

    // List of categories
    final List<String> categories = [
      '${AppStrings.artAndCulture.getString(context)}',
      '${AppStrings.scienceAndTechnology.getString(context)}',
      '${AppStrings.sport.getString(context)}',
      '${AppStrings.music.getString(context)}',
      '${AppStrings.gastronomy.getString(context)}',
      '${AppStrings.fashionAndStyle.getString(context)}',
      '${AppStrings.travelAndPlaces.getString(context)}',
      '${AppStrings.education.getString(context)}',
      '${AppStrings.career.getString(context)}',
      '${AppStrings.businessAndFinance.getString(context)}',
      '${AppStrings.entertainment.getString(context)}',
      '${AppStrings.environmentAndEcology.getString(context)}',
      '${AppStrings.agricultureAndHorticulture.getString(context)}',
      '${AppStrings.languagesAndCommunication.getString(context)}',
      '${AppStrings.technologyAndDigital.getString(context)}',
      '${AppStrings.architectureAndDesign.getString(context)}',
      '${AppStrings.mediaAndJournalism.getString(context)}',
      '${AppStrings.buyAndSell.getString(context)}',
    ];
    return DropdownButton<String>(
      itemHeight: 50.h,
      value: selectedCategory, // The selected category
      hint:
           Text('${AppStrings.selectacategory.getString(context)}'), // Hint text when nothing is selected
      icon: const Icon(Icons.arrow_drop_down), // The drop-down arrow icon
      iconSize: 24.sp,
      elevation: 16.sp.toInt(),
      style: TextStyle(fontSize: 16.sp),

      underline: Container(
        height: 2.h,
        color: AppColors.kPrimaryColor,
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue; // Update the selected value
          widget.categoryController.text = newValue!; // Update controller
        });
        if (widget.onChanged != null) {
          widget
              .onChanged!(newValue); // Trigger the callback with selected value
        }
      },
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
