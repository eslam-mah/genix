import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/summary.dart';
import 'package:genix/features/home%20screen/view%20model/add%20react/add_react_cubit.dart';
import 'package:lottie/lottie.dart';

class ReactsList extends StatelessWidget {
  final PostsModel postsModel;
  final ValueNotifier<int> totalReactionsNotifier;
  final ValueNotifier<String> userReactionNotifier;

  const ReactsList({
    super.key,
    required this.postsModel,
    required this.totalReactionsNotifier,
    required this.userReactionNotifier,
  });

  // Helper method to build reaction icons based on the reaction type
  Widget _buildReactionIcon(String reactionType) {
    String lottieFile;

    switch (reactionType) {
      case 'love':
        lottieFile = AppLottie.kLove;
        break;
      case 'wow':
        lottieFile = AppLottie.kWowReact;
        break;
      case 'haha':
        lottieFile = AppLottie.kLaughReact;
        break;
      case 'angry':
        lottieFile = AppLottie.kAngryReact;
        break;
      case 'sad':
        lottieFile = AppLottie.kSadReact;
        break;
      case 'like':
        lottieFile = AppLottie.kWinkReact;
        break;
      default:
        lottieFile = AppLottie.kWinkReact; // Default reaction icon
        break;
    }

    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 20.r,
      child: Lottie.asset(
        lottieFile,
        width: 40.r,
        fit: BoxFit.cover,
      ),
    );
  }

  // Build the row showing both the user's reaction and a summary of other reactions
  Widget _buildReactionRow(String userReaction, Summary summary) {
    List<Widget> reactionWidgets = [];
    List<String> addedReactions = [];
    bool isUserReactionPresent = postsModel.reactions!.byMe != null;

    // Check and add reactions to the row from the summary
    if (summary.love != null && summary.love! > 0) {
      reactionWidgets.add(_buildReactionIcon('love'));
      addedReactions.add('love');
      if (userReaction == 'love') isUserReactionPresent = true;
    }
    if (summary.wow != null && summary.wow! > 0) {
      reactionWidgets.add(_buildReactionIcon('wow'));
      addedReactions.add('wow');
      if (userReaction == 'wow') isUserReactionPresent = true;
    }
    if (summary.haha != null && summary.haha! > 0) {
      reactionWidgets.add(_buildReactionIcon('haha'));
      addedReactions.add('haha');
      if (userReaction == 'haha') isUserReactionPresent = true;
    }
    if (summary.angry != null && summary.angry! > 0) {
      reactionWidgets.add(_buildReactionIcon('angry'));
      addedReactions.add('angry');
      if (userReaction == 'angry') isUserReactionPresent = true;
    }
    if (summary.sad != null && summary.sad! > 0) {
      reactionWidgets.add(_buildReactionIcon('sad'));
      addedReactions.add('sad');
      if (userReaction == 'sad') isUserReactionPresent = true;
    }
    if (summary.like != null && summary.like! > 0) {
      reactionWidgets.add(_buildReactionIcon('like'));
      addedReactions.add('like');
      if (userReaction == 'like') isUserReactionPresent = true;
    }

    // If the user's reaction is not already present in the list, add it
    if (!isUserReactionPresent && userReaction.isNotEmpty) {
      reactionWidgets.insert(0, _buildReactionIcon(userReaction));
    }

    // Limit the number of reactions to 3 (including the user's reaction)
    if (reactionWidgets.length > 3) {
      reactionWidgets = reactionWidgets.sublist(0, 3);
    }

    return SizedBox(
      width: reactionWidgets.isEmpty
          ? 1
          : reactionWidgets.length == 1
              ? 40.r
              : reactionWidgets.length == 2
                  ? 60.r
                  : 80.r,
      height: 40.r,
      child: Stack(
        children: List.generate(reactionWidgets.length, (index) {
          return Positioned(
            left: index * 20.r,
            child: reactionWidgets[index],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddReactCubit, AddReactState>(
      listener: (context, state) {
        if (state is AddReactSuccess) {
          // Update the reaction notifiers after a successful reaction
          if (state.reactionType.id == postsModel.id) {
            // Update user reaction
            userReactionNotifier.value =
                state.reactionType.reactions?.byMe ?? '';

            // Update total reactions (you may want to adjust logic based on adding/removing reactions)
            totalReactionsNotifier.value +=
                1; // For simplicity, assuming adding a new reaction
          }
        }
      },
      child: Row(
        children: [
          ValueListenableBuilder<String>(
            valueListenable: userReactionNotifier,
            builder: (context, userReaction, _) {
              return _buildReactionRow(
                userReaction,
                postsModel.reactions?.summary ?? Summary(),
              );
            },
          ),
          SizedBox(width: 3.w),
          ValueListenableBuilder<int>(
            valueListenable: totalReactionsNotifier,
            builder: (context, totalReactions, _) {
              return SizedBox(
                width: 30.w,
                child: Text(
                  ' $totalReactions',
                  style: TextStyle(fontSize: 13.sp),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
