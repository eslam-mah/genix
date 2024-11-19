import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';

import '../../../../core/localization/all_app_strings.dart';

class ReplyingTextField extends StatelessWidget {
  final PostsModel postsModel;
  final Function() onPressed;
  final TextEditingController textEditingController;
  const ReplyingTextField(
      {super.key,
      required this.postsModel,
      required this.onPressed,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13.r)),
      child: TextField(
        controller: textEditingController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: const BorderSide(
              width: 2,
              style: BorderStyle.solid,
              color: AppColors.kPrimaryColor2,
            ),
          ),
          hintText:
          '${AppStrings.replyto.getString(context)}' '${postsModel.comments?.first.user?.showname}' '${AppStrings.comment.getString(context)}',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
            gapPadding: 0,
            borderRadius: BorderRadius.circular(15.r),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(15.r),
          ),
          disabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(15.r),
          ),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: const Icon(FontAwesomeIcons.solidPaperPlane),
          ),
        ),
      ),
    );
  }
}
