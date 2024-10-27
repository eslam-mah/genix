import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';

class CustomPageDropdownMenu extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final TextEditingController categoryController;

  const CustomPageDropdownMenu({
    super.key,
    this.onChanged,
    required this.categoryController,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomPageDropdownMenuState createState() => _CustomPageDropdownMenuState();
}

class _CustomPageDropdownMenuState extends State<CustomPageDropdownMenu> {
  String? selectedCategory;

  // List of categories
  final List<String> categories = [
    'art and culture',
    'science and technology',
    'sport',
    'music',
    'gastronomy',
    'fashion and style',
    'travel and places',
    'education',
    'career',
    'business and finance',
    'entertainment',
    'environment and ecology',
    'agriculture and horticulture',
    'languages and communication',
    'technology and digital',
    'architecture and design',
    'media and journalism',
    'buy & sell',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      itemHeight: 50.h,
      value: selectedCategory, // The selected category
      hint:
          const Text('Select a category'), // Hint text when nothing is selected
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
