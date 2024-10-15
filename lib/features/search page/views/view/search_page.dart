import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/search%20page/view%20model/search/search_cubit.dart';
import 'package:genix/features/search%20page/views/view/searched_list_page.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const String route = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _selectedValue = '1'; // Default to 'Users'
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.circleXmark,
                size: 22.sp, color: AppColors.kPrimaryColor),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: const CustomHeaderWidget2(text: 'Search by'),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextField2(
                hintText: 'Search people, groups or pages',
                readOnly: false,
                controller: _searchController,
                icon: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 15.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Radio button rows with updated groupValue and onChanged logic
            _RadioButtonRow(
              icon: FontAwesomeIcons.userGroup,
              title: 'Users',
              value: '1',
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value!;
                });
              },
            ),
            SizedBox(height: 6.h),
            _RadioButtonRow(
              icon: FontAwesomeIcons.peopleGroup,
              title: 'Groups',
              value: '2',
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value!;
                });
              },
            ),
            SizedBox(height: 6.h),
            _RadioButtonRow(
              icon: Icons.text_snippet,
              title: 'Pages',
              value: '3',
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value!;
                });
              },
            ),
            SizedBox(height: 25.h),
            CustomButton(
                buttonText: 'Find',
                height: 40.h,
                width: 330.w,
                borderRadius: 20.r,
                onTap: () {
                  // Pass the selected value and search query to SearchedListPage
                  GoRouter.of(context).push(
                    SearchedListPage.route,
                    extra: {
                      'query': _searchController.text.trim(),
                      'type': _selectedValue
                    },
                  );
                },
                color: AppColors.kPrimaryColor),
          ],
        ),
      ),
    );
  }
}

class _RadioButtonRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String groupValue;
  final Function(String?)? onChanged;

  const _RadioButtonRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      child: Row(
        children: [
          SizedBox(width: 15.w),
          Icon(
            icon,
            size: 18.sp,
          ),
          SizedBox(width: 15.w),
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            focusColor: AppColors.kPrimaryColor,
            activeColor: AppColors.kPrimaryColor,
          ),
          CustomTextWidget(
            textSize: 16.sp,
            fontFamily: '',
            fontWeight: FontWeight.normal,
            text: title,
          ),
        ],
      ),
    );
  }
}
