import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/view%20model/add%20poll/add_poll_cubit.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';

import '../../../../../core/localization/all_app_strings.dart';

class PollPost extends StatefulWidget {
  final PostsModel postsModel;
  final SettingsModel me;
  final bool? isNightMode;

  const PollPost({
    super.key,
    required this.postsModel,
    this.isNightMode,
    required this.me,
  });

  @override
  State<PollPost> createState() => _PollPostState();
}

class _PollPostState extends State<PollPost> {
  int? userVotedOptionIndex;

  @override
  void initState() {
    super.initState();
    // Check if user has already voted and set the userVotedOptionIndex accordingly
    final pollOptions = widget.postsModel.misc?.poll?.options;
    if (pollOptions != null) {
      for (int i = 0; i < pollOptions.length; i++) {
        if (pollOptions[i].votesFromUsers?.contains(widget.me.data?.id) ??
            false) {
          userVotedOptionIndex = i;
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.postsModel.user;
    final poll = widget.postsModel.misc?.poll;
    final pollOptions = poll?.options;
    int totalVotes = pollOptions!
        .fold(0, (sum, option) => sum + (option.votesFromUsers?.length ?? 0));

    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              poll?.question ?? "",
              style: TextStyle(fontSize: 20.sp, color: AppColors.kPrimaryColor),
            ),
          ),
          Column(
            children: List.generate(pollOptions.length, (index) {
              final option = pollOptions[index];
              double percentage = totalVotes == 0
                  ? 0
                  : (option.votesFromUsers?.length ?? 0) / totalVotes * 170;

              return InkWell(
                onTap: () {
                  setState(() {
                    if (userVotedOptionIndex == index) {
                      // Unvote the current option
                      userVotedOptionIndex = null;
                      option.votesFromUsers?.remove(widget.me.data?.id);
                      // Call the Cubit to update the vote status
                      context.read<AddPollCubit>().addPollPost(
                            postId: widget.postsModel.id?.toInt() ?? 0,
                            option: index,
                          );
                    } else {
                      // Vote for the selected option
                      if (userVotedOptionIndex != null) {
                        // Remove vote from the previous option
                        pollOptions[userVotedOptionIndex!]
                            .votesFromUsers
                            ?.remove(widget.me.data?.id);
                      }
                      userVotedOptionIndex = index;
                      option.votesFromUsers?.add(widget.me.data?.id ?? 0);
                      // Call the Cubit to update the vote status
                      context.read<AddPollCubit>().addPollPost(
                            postId: widget.postsModel.id?.toInt() ?? 0,
                            option: index,
                          );
                    }
                  });
                },
                child: Container(
                  color: userVotedOptionIndex == index &&
                          widget.postsModel.misc!.poll!.options![index]
                              .votesFromUsers!
                              .contains(widget.me.data?.id)
                      ? AppColors.kPrimaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option.title ?? '',
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 20.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: Colors.grey[300],
                              ),
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 600),
                              height: 20.h,
                              width: percentage.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.kPrimaryColor,
                              ),
                            ),
                            Center(
                              child: CustomTextWidget(
                                textSize: 14.sp,
                                fontFamily: 'fontFamily',
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                text:
                                    '${option.votesFromUsers?.length ?? 0}' '${AppStrings.votes.getString(context)}',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
