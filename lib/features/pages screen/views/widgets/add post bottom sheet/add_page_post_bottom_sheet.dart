import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/bigtextfield.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/view%20model/add%20post/add_post_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

Future<dynamic> addPagePostModalBottomSheet(
    BuildContext context, Function() refresh, int pageID) {
  bool isPoll = false;
  bool isCheckIn = false;
  bool isLive = false;
  int isPost = 1;
  bool isCloseFriend = false;
  List<Widget> textFields = [];
  TextEditingController contentController = TextEditingController();
  List<TextEditingController> pollsController = [];
  List<TextEditingController> pollOptionsControllers = [];
  TextEditingController pollQuestionController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();
  FilePickerResult? result;
  List<File> selectedFiles = []; // To hold selected image and video files
  List<String> filePaths = [];
  List<VideoPlayerController?> videoControllers = [];
  bool isLoading = false;

  return showModalBottomSheet(
      backgroundColor: ThemeCubit().state == ThemeState.dark
          ? DarkModeColors.kItemColorDark2
          : AppColors.kAppBar2Color,
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: !isLoading,
      context: context,
      builder: (context) {
        return BlocProvider<AddPostCubit>(
          create: (context) => AddPostCubit(),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            AddPostCubit addPostCubit = BlocProvider.of<AddPostCubit>(context);

            // Function to add poll option text field
            void addPollOption() {
              pollOptionsControllers.add(TextEditingController());
            }

            // Function to remove the last poll option text field
            void removePollOption() {
              if (pollOptionsControllers.isNotEmpty) {
                pollOptionsControllers.removeLast();
              }
            }

            bool isVideo(String fileName) {
              // Common video file extensions
              final videoExtensions = [
                'mp4',
                'avi',
                'mov',
                'wmv',
                'flv',
                'mkv',
                'webm'
              ];
              final fileExtension = fileName.split('.').last.toLowerCase();
              return videoExtensions.contains(fileExtension);
            }

            bool isImage(String fileName) {
              // Check file extension
              final extensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
              final fileExtension = fileName.split('.').last.toLowerCase();
              return extensions.contains(fileExtension);
            }

            void pickFile() async {
              try {
                result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: [
                    'jpg',
                    'jpeg',
                    'png',
                    'gif',
                    'webp',
                    'mp4',
                    'mov',
                    'webm',
                    'mov',
                    'heic'
                  ],
                  allowMultiple: true,
                );
                if (result != null) {
                  for (var file in result!.files) {
                    selectedFiles.add(File(file.path!));
                    filePaths.add(file.path!);

                    if (isVideo(file.name)) {
                      final controller =
                          VideoPlayerController.file(File(file.path!))
                            ..initialize().then((_) {
                              setState(() {});
                            });
                      videoControllers.add(controller);
                    } else {
                      videoControllers.add(null); // For non-video files
                    }
                  }
                  setState(() {});
                }
              } catch (e) {
                print(e);
              }
            }

            void removeTextField() {
              if (textFields.isNotEmpty) {
                textFields.removeLast();
                setState(() {});
              }
            }

            // void pickCurrentLocation() async {
            //   bool serviceEnabled;
            //   LocationPermission permission;

            //   // Check if location services are enabled
            //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
            //   if (!serviceEnabled) {
            //     // Location services are not enabled, request the user to enable it
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //           content: Text('Location services are disabled.')),
            //     );
            //     return;
            //   }

            //   // Check for location permissions
            //   permission = await Geolocator.checkPermission();
            //   if (permission == LocationPermission.denied) {
            //     permission = await Geolocator.requestPermission();
            //     if (permission == LocationPermission.denied) {
            //       // Permissions are denied
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //             content: Text('Location permissions are denied.')),
            //       );
            //       return;
            //     }
            //   }

            //   if (permission == LocationPermission.deniedForever) {
            //     // Permissions are permanently denied
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //         content:
            //             Text('Location permissions are permanently denied.'),
            //       ),
            //     );
            //     return;
            //   }

            //   // If permissions are granted, get the current position
            //   Position position = await Geolocator.getCurrentPosition(
            //       desiredAccuracy: LocationAccuracy.high);

            //   // Update the location text field with the current location
            //   setState(() {
            //     currentLocationController.text =
            //         '${position.latitude}, ${position.longitude}';
            //   });
            // }

            @override
            void dispose() {
              // Dispose all video controllers when the widget is destroyed
              for (var controller in videoControllers) {
                controller?.dispose();
              }
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Create post', style: TextStyle(fontSize: 20.sp)),
                        if (result != null && result!.files.isNotEmpty) ...[
                          SizedBox(
                            height: 15.h,
                          ),
                          SizedBox(
                            height: result!.files.length > 3
                                ? result!.files.length / 3 * 100.h
                                : 100.h, // Adjust this based on your needs
                            width: double.infinity,
                            child: GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    3, // Adjust the number of columns
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                              ),
                              itemCount: result!.files.length,
                              itemBuilder: (context, index) {
                                final file = result!.files[index];
                                // Check if the file is an image or a video and display accordingly
                                if (isImage(file.name)) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(File(file.path!)),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  );
                                } else if (isVideo(file.name)) {
                                  final controller = videoControllers[index];
                                  return controller != null &&
                                          controller.value.isInitialized
                                      ? AspectRatio(
                                          aspectRatio:
                                              controller.value.aspectRatio,
                                          child: VideoPlayer(controller),
                                        )
                                      : const SizedBox(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.kPrimaryColor,
                                            ),
                                          ),
                                        );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                        ],
                        SizedBox(
                          height: 15.h,
                        ),
                        Visibility(
                          visible: isPost == 3 || isPost == 1,
                          child: BigTextField(
                            hintText: ' Write something...',
                            controller: contentController,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 50.h,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPoll = false;
                                  });
                                  pickFile();
                                },
                                icon: CircleAvatar(
                                  backgroundColor:
                                      ThemeCubit().state == ThemeState.dark
                                          ? DarkModeColors.kBackGroundDark
                                          : AppColors.kTextFieldColor,
                                  radius: 20.r,
                                  child: Icon(
                                    FontAwesomeIcons.image,
                                    color: ThemeCubit().state == ThemeState.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              // IconButton(
                              //   onPressed: () {
                              //     setState(() {
                              //       isPost = isPost == 3 ? 0 : 3;
                              //     });
                              //   },
                              //   icon: CircleAvatar(
                              //     backgroundColor:
                              //         ThemeCubit().state == ThemeState.dark
                              //             ? DarkModeColors.kBackGroundDark
                              //             : AppColors.kTextFieldColor,
                              //     radius: 20.r,
                              //     child: Icon(
                              //       FontAwesomeIcons.ellipsis,
                              //       color: ThemeCubit().state == ThemeState.dark
                              //           ? Colors.white
                              //           : Colors.black,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Visibility(
                              visible: isPost == 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isPoll = !isPoll;
                                    });
                                  },
                                  child: Container(
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          isPoll
                                              ? BoxShadow(
                                                  color: AppColors
                                                      .kPrimaryColor2
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: const Offset(0, 3),
                                                )
                                              : const BoxShadow(
                                                  blurRadius: 0,
                                                  spreadRadius: 0)
                                        ],
                                        color: isPoll
                                            ? AppColors.kPrimaryColor2
                                            : ThemeCubit().state ==
                                                    ThemeState.dark
                                                ? DarkModeColors.kBackGroundDark
                                                : AppColors.kTextFieldColor,
                                        borderRadius:
                                            BorderRadius.circular(6.r)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: SizedBox(
                                              height: 17.h,
                                              child: Image.asset(
                                                AppImages.kPoll,
                                              )),
                                        ),
                                        Text(
                                          'Create a poll',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: isPoll
                                                ? Colors.white
                                                : ThemeCubit().state ==
                                                        ThemeState.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: isPoll,
                                child: Column(
                                  children: [
                                    CustomTextField2(
                                      hintText: 'Poll Question',
                                      controller: pollQuestionController,
                                      readOnly: false,
                                      icon: const Text(''),
                                    ),
                                    SizedBox(height: 8.h),
                                    for (int i = 0;
                                        i < pollOptionsControllers.length;
                                        i++)
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13.r),
                                        ),
                                        child: CustomTextField2(
                                          hintText: 'Poll option ${i + 1}',
                                          controller: pollOptionsControllers[i],
                                          readOnly: false,
                                          icon: const Text(''),
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomButton(
                                          color: AppColors.kPrimaryColor,
                                          buttonText: '+ Add Option',
                                          width: 150.w,
                                          height: 40.h,
                                          onTap: () {
                                            setState(() {
                                              addPollOption();
                                            });
                                          },
                                          borderRadius: 8.r,
                                        ),
                                        if (pollOptionsControllers.isNotEmpty)
                                          IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.trash,
                                              color: Colors.red,
                                              size: 16.sp,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                removePollOption();
                                              });
                                            },
                                          ),
                                      ],
                                    ),
                                  ],
                                )),
                            Visibility(
                              visible: isPost == 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isCheckIn = !isCheckIn;
                                    });
                                  },
                                  child: Container(
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          isCheckIn
                                              ? BoxShadow(
                                                  color: AppColors
                                                      .kPrimaryColor2
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: const Offset(0, 3),
                                                )
                                              : const BoxShadow(
                                                  blurRadius: 0,
                                                  spreadRadius: 0)
                                        ],
                                        color: isCheckIn
                                            ? AppColors.kPrimaryColor2
                                            : ThemeCubit().state ==
                                                    ThemeState.dark
                                                ? DarkModeColors.kBackGroundDark
                                                : AppColors.kTextFieldColor,
                                        borderRadius:
                                            BorderRadius.circular(6.r)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: SizedBox(
                                              height: 17.h,
                                              child: Image.asset(
                                                AppImages.kLocation,
                                              )),
                                        ),
                                        Text(
                                          'Check in',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: isCheckIn
                                                ? Colors.white
                                                : ThemeCubit().state ==
                                                        ThemeState.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isCheckIn,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 100.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.locationCrosshairs,
                                            size: 13.sp,
                                          ),
                                          Text(
                                            'Current',
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13.r)),
                                      child: CustomTextField2(
                                          readOnly: false,
                                          hintText: 'Custom location',
                                          controller: currentLocationController,
                                          icon: const SizedBox.shrink()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: isPost == 1,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isCloseFriend = !isCloseFriend;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.check_circle,
                                      size: 15.sp,
                                      color: isCloseFriend
                                          ? AppColors.kPrimaryColor2
                                          : ThemeCubit().state ==
                                                  ThemeState.dark
                                              ? AppColors.kTextFieldColor
                                              : Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.userGroup,
                                    size: 16.sp,
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    'Only for close friends?',
                                    style: TextStyle(fontSize: 14.sp),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPost = 1;
                                      });
                                    },
                                    icon: SizedBox(
                                        height: 16.h,
                                        child: CircleAvatar(
                                          backgroundColor: isPost == 1
                                              ? AppColors.kPrimaryColor2
                                              : ThemeCubit().state ==
                                                      ThemeState.dark
                                                  ? AppColors.kTextFieldColor
                                                  : Colors.black
                                                      .withOpacity(0.2),
                                        ))),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidSquarePlus,
                                  color: null,
                                  size: 35.sp,
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                Text(
                                  'News feed',
                                  style: TextStyle(fontSize: 14.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPost = 2;
                                      });
                                    },
                                    icon: SizedBox(
                                        height: 16.h,
                                        child: CircleAvatar(
                                          backgroundColor: isPost == 2
                                              ? AppColors.kPrimaryColor2
                                              : ThemeCubit().state ==
                                                      ThemeState.dark
                                                  ? AppColors.kTextFieldColor
                                                  : Colors.black
                                                      .withOpacity(0.2),
                                        ))),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Icon(
                                  FontAwesomeIcons.circlePlus,
                                  color: null,
                                  size: 35.sp,
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                Text(
                                  'Story',
                                  style: TextStyle(fontSize: 14.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomButton(
                              color: AppColors.kPrimaryColor,
                              buttonText: 'Create post',
                              width: double.infinity,
                              height: 37.h,
                              borderRadius: 8.r,
                              onTap: () async {
                                String contentText =
                                    contentController.text.trim();

                                // Check if content is empty and no files are selected
                                if (contentText.isEmpty &&
                                    selectedFiles.isEmpty &&
                                    isPoll == false &&
                                    isCheckIn == false) {
                                  GoRouter.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Content must be filled',
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                      backgroundColor:
                                          ThemeCubit().state == ThemeState.dark
                                              ? Colors.white
                                              : Colors.black,
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    isLoading = true; // Show loading indicator
                                  });

                                  try {
                                    // Collect poll options from pollOptionsControllers
                                    List<String> pollOptions =
                                        pollOptionsControllers
                                            .map((controller) =>
                                                controller.text.trim())
                                            .where((text) => text.isNotEmpty)
                                            .toList();

                                    // Debugging: Print poll question and options
                                    print(
                                        'Poll Question: ${pollQuestionController.text}');
                                    print('Poll Options: $pollOptions');

                                    // Poll validation: Ensure question and at least two options are provided
                                    bool isPollValid = !isPoll ||
                                        (pollQuestionController
                                                .text.isNotEmpty &&
                                            pollOptions.length >= 2);

                                    if (isPoll && !isPollValid) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Poll must have a question and at least two options',
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                          backgroundColor: ThemeCubit().state ==
                                                  ThemeState.dark
                                              ? Colors.white
                                              : Colors.black,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      setState(() {
                                        isLoading = false;
                                      });
                                      return;
                                    }

                                    // Submit the post with poll details
                                    await addPostCubit
                                        .addPost(
                                      content: contentText,
                                      pageId: pageID.toString(),
                                      groupId: '',
                                      postingIn:
                                          isPost == 1 ? 'newsfeed' : 'story',
                                      files: selectedFiles,
                                      checkInLocation: isCheckIn
                                          ? currentLocationController.text
                                              .trim()
                                          : 'a',
                                      isLive: isLive,
                                      cameraMirror: false,
                                      cameraId: '',
                                      deviceType: 'mobile',
                                      microphoneId: '',
                                      checkIn: isCheckIn,
                                      toCloseFriends: isCloseFriend,
                                      pollOptions: isPoll
                                          ? pollOptions
                                          : ['a'], // Poll options submitted
                                      poll: isPoll,
                                      pollQuestion: isPoll
                                          ? pollQuestionController.text.trim()
                                          : 'a', // Poll question submitted
                                      event: isCheckIn,
                                      eventTimeStamp: DateTime.now().toString(),
                                    )
                                        .then((onValue) {
                                      print('Post submitted successfully');
                                    });
                                  } catch (e) {
                                    print('Error adding post: $e');
                                  } finally {
                                    setState(() {
                                      isLoading =
                                          false; // Hide loading indicator
                                    });
                                    GoRouter.of(context).pop();
                                    refresh();
                                  }
                                }
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                if (isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
              ],
            );
          }),
        );
      });
}
