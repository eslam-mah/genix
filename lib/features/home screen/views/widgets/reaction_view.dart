import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/view%20model/add%20react/add_react_cubit.dart';
import 'package:lottie/lottie.dart';

import 'post types/post_item.dart';

// ignore: must_be_immutable
class ReactionView extends StatefulWidget {
  final PostsModel postsModel;
  final AddReactCubit addReactCubit;
  Reaction reaction;
  final Function() onClose;
  final ValueNotifier<String> userReactionNotifier; // New

  final ValueNotifier<int> totalReactionsNotifier; // Receive ValueNotifier

  ReactionView({
    super.key,
    required this.postsModel,
    required this.addReactCubit,
    required this.reaction,
    required this.onClose,
    required this.totalReactionsNotifier,
    required this.userReactionNotifier,
  });

  @override
  State<ReactionView> createState() => _ReactionViewState();
}

class _ReactionViewState extends State<ReactionView> {
  bool isUpdatingReaction = false;

  final List<dynamic> reactions = [
    ReactionElement(
        Lottie.asset(AppLottie.kWinkReact, width: 50.w, height: 50.w),
        Reaction.like),
    ReactionElement(Lottie.asset(AppLottie.kLove, width: 50.w, height: 50.w),
        Reaction.love),
    ReactionElement(
        Lottie.asset(AppLottie.kLaughReact, width: 50.w, height: 50.w),
        Reaction.laugh),
    ReactionElement(
        Lottie.asset(AppLottie.kWowReact, width: 50.w, height: 50.w),
        Reaction.surprise),
    ReactionElement(
        Lottie.asset(AppLottie.kSadReact, width: 50.w, height: 50.w),
        Reaction.sad),
    ReactionElement(
        Lottie.asset(AppLottie.kAngryReact, width: 50.w, height: 50.w),
        Reaction.angry),
  ];

  String _getReactionType(Reaction reaction) {
    switch (reaction) {
      case Reaction.love:
        return 'love';
      case Reaction.surprise:
        return 'wow';
      case Reaction.laugh:
        return 'haha';
      case Reaction.angry:
        return 'angry';
      case Reaction.sad:
        return 'sad';
      case Reaction.like:
        return 'like';
      default:
        return '';
    }
  }

  void _handleReactionPress(Reaction selectedReaction) {
    if (isUpdatingReaction) return;

    String reactionType = _getReactionType(selectedReaction);

    setState(() {
      isUpdatingReaction = true;
    });

    widget.addReactCubit
        .addReactions(
      reactionType: reactionType,
      postId: widget.postsModel.id!.toInt(),
    )
        .then((_) {
      setState(() {
        // Check if user already reacted
        String? currentUserReaction = widget.postsModel.reactions?.byMe;

        // Update the user's reaction
        widget.userReactionNotifier.value = reactionType;

        // Update total reactions count only if the reaction changes
        if (currentUserReaction == null) {
          widget.totalReactionsNotifier.value += 1; // New reaction
        } else if (currentUserReaction != reactionType) {
          widget.totalReactionsNotifier.value =
              widget.totalReactionsNotifier.value; // Reaction changed
        }

        // Mark the reaction change in the model
        widget.postsModel.reactions?.byMe = reactionType;
        widget.onClose();
      });
    }).catchError((error) {
      setState(() {
        isUpdatingReaction = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 300.w,
      decoration: BoxDecoration(
        color: ThemeCubit().state == ThemeState.dark
            ? Colors.black.withOpacity(0.8)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: reactions.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 15 + index + 15,
              child: FadeInAnimation(
                child: InkWell(
                  borderRadius: BorderRadius.circular(200.r),
                  onTap: () {
                    setState(() {
                      if (widget.reaction != reactions[index].reaction) {
                        widget.reaction = reactions[index].reaction;
                        _handleReactionPress(widget.reaction);
                      }
                    });
                  },
                  child: reactions[index].image,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ReactionElement {
  final Reaction reaction;
  final LottieBuilder image;
  ReactionElement(this.image, this.reaction);
}
