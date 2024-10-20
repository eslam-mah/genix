import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';

class PollPost extends StatefulWidget {
  final PostsModel postsModel;
  final bool? isNightMode;
  const PollPost({super.key, required this.postsModel, this.isNightMode});

  @override
  State<PollPost> createState() => _PollPostState();
}

class _PollPostState extends State<PollPost> {
  String? userVotedOptionId;
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
                style:
                    TextStyle(fontSize: 20.sp, color: AppColors.kPrimaryColor),
              )),
          Column(
            children: pollOptions.map((option) {
              double percentage = totalVotes == 0
                  ? 0
                  : (option.votesFromUsers?.length ?? 0) / totalVotes * 170;

              return InkWell(
                onTap: () {
                  setState(() {
                    if (userVotedOptionId == option.title) {
                      userVotedOptionId = null;
                      option.votesFromUsers?.remove(user?.id as int);
                    } else {
                      // Vote
                      if (userVotedOptionId != null) {
                        // Remove vote from the previous option
                        pollOptions
                            .firstWhere((opt) => opt.title == userVotedOptionId)
                            .votesFromUsers
                            ?.remove(user?.id as int);
                      }
                      userVotedOptionId = option.title;
                      option.votesFromUsers?.add(user?.id as int);
                    }
                  });
                },
                child: Container(
                  color: userVotedOptionId == option.title
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
                                    '${option.votesFromUsers?.length ?? 0} votes',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
