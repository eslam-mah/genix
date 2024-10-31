import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';

import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customiconbutton.dart';
import 'package:genix/core/widgets/customtextfield.dart';
import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:genix/features/register%20screen/view%20model/register_cubit/register_cubit.dart';
import 'package:genix/features/register%20screen/views/verification_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterBody extends StatefulWidget {
  static const String route = '/register_screen';
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  String? selectedCountry;
  bool isCountrySelected = false;
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.kPrimaryColor,
        ),
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              setState(() {
                isLoading = false;
              });
              GoRouter.of(context).go(VerificationScreen.routeName);
            }
            if (state is RegisterError) {
              setState(() {
                isLoading = false;
              });
              if (state.message == "Unprocessable Content") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          'These credentials do not match or user already exists.')),
                );
                print(state.message);
              } else if (state.message == "Accepted") {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please Verify Your Email'),
                  backgroundColor: Colors.red,
                ));
                print(state.message);
                GoRouter.of(context).push(VerificationScreen.routeName);
              } else {
                GoRouter.of(context)
                    .push(LoginScreen.route, extra: const LogInScreenArgs());
              }
            }
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(
                      child: SizedBox(
                          width: 80.w,
                          height: 80.h,
                          child: Image.asset(AppImages.kLogo))),
                  SizedBox(
                    height: 60.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30.w,
                      ),
                      Icon(
                        FontAwesomeIcons.penRuler,
                        size: 30.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                      isObscure: false,
                      hintText: 'Your name',
                      readOnly: false,
                      onTap: () {},
                      controller: nameController),
                  SizedBox(
                    height: 26.h,
                  ),
                  CustomTextField(
                      isObscure: false,
                      hintText: 'Username',
                      readOnly: false,
                      onTap: () {},
                      controller: userNameController),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                      isObscure: false,
                      hintText: 'E-mail',
                      readOnly: false,
                      onTap: () {},
                      controller: emailController),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                      isObscure: true,
                      hintText: 'password',
                      readOnly: false,
                      onTap: () {},
                      controller: passwordController),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    isObscure: true,
                    hintText: 'Retype password',
                    readOnly: false,
                    onTap: () {},
                    controller: retypePasswordController,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    isObscure: false,
                    controller: dateController,
                    hintText: 'Date',
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy/MM/dd').format(pickedDate);
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          isCountrySelected = !isCountrySelected;
                        });
                        showCountryPicker(
                          context: context,
                          onSelect: (Country country) {
                            setState(() {
                              selectedCountry = country.countryCode;
                            });
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 29.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                              color: isCountrySelected
                                  ? AppColors.kPrimaryColor2
                                  : Colors.white,
                              width: 1,
                            )),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedCountry ?? 'Select your country',
                                style: TextStyle(
                                  fontSize: 16.sp, // Adjust size as needed
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.chevronDown,
                                size: 18.r,
                              ),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 20.w,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        'Remember me',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      SizedBox(
                        width: 160.w,
                      ),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        activeTrackColor: AppColors.kPrimaryColor2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  CustomButton(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          isLoading = true;
                        });
                        context.read<RegisterCubit>().register(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            showName: nameController.text.trim(),
                            userName: userNameController.text.trim(),
                            passwordConfirmation:
                                passwordController.text.trim(),
                            country: selectedCountry!,
                            locale: 'english',
                            dateOfBirth: dateController.text.trim());
                      }
                    },
                    color: AppColors.kPrimaryColor2,
                    width: 320.w,
                    height: 40.w,
                    buttonText: 'Signup',
                    borderRadius: 50.r,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        onTap: () {
                          GoRouter.of(context).pop();
                        },
                        width: 100.w,
                        height: 33.h,
                        icon: FontAwesomeIcons.key,
                        borderRadius: 50.r,
                        buttonText: 'Sign in',
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      CustomIconButton(
                        onTap: () {},
                        width: 100.w,
                        height: 33.h,
                        icon: FontAwesomeIcons.penRuler,
                        borderRadius: 50.r,
                        buttonText: 'Sign up',
                        color: AppColors.kPrimaryColor2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
