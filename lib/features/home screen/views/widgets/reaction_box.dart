// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:genix/core/utils/images.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';

import 'post types/post_item.dart';

// ignore: must_be_immutable
class ReactionBox extends StatefulWidget {
  final PostsModel postsModel;
  Reaction reaction;

  ReactionBox({
    Key? key,
    required this.postsModel,
    required this.reaction,
  }) : super(key: key);

  @override
  State<ReactionBox> createState() => _ReactionBoxState();
}

class _ReactionBoxState extends State<ReactionBox> {
  Widget _getReactionIcon(Reaction r) {
    final reactionByMe = widget.postsModel.reactions?.byMe;

    // Check the reaction type directly from `reactionByMe`
    if (reactionByMe == "sad" || r == Reaction.sad) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kSadReact), const Text('Sad')],
      );
    } else if (reactionByMe == "love" || r == Reaction.love) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kLove), const Text('Love')],
      );
    } else if (reactionByMe == "angry" || r == Reaction.angry) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kAngryReact), const Text('Angry')],
      );
    } else if (reactionByMe == "haha" || r == Reaction.laugh) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kLaughReact), const Text('HAHA')],
      );
    } else if (reactionByMe == "wow" || r == Reaction.surprise) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kWowReact), const Text('Wow')],
      );
    } else if (reactionByMe == "like" || r == Reaction.like) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kWinkReact), const Text('Like')],
      );
    } else {
      // Default fallback
      return const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(FontAwesomeIcons.solidHeart),
          Text('Like'),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 100.w,
      decoration: BoxDecoration(
        color:
            ThemeCubit().state == ThemeState.dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: _getReactionIcon(widget.reaction),
    );
  }
}
