import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/features/home%20screen/view%20model/add%20react/add_react_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/data/models/shorts_model.dart';

class LikeButton extends StatefulWidget {
  final ShortsModel short;
  const LikeButton({
    super.key,
    required this.short,
  });

  @override
  State<LikeButton> createState() => LikeButtonState();
}

class LikeButtonState extends State<LikeButton> {
  late ValueNotifier<int> totalReactionsNotifier;
  late ValueNotifier<bool> reactionNotifier;

  @override
  void initState() {
    super.initState();
    totalReactionsNotifier =
        ValueNotifier(widget.short.reactions?.summary?.love ?? 0);
    reactionNotifier = ValueNotifier(widget.short.reactions?.byMe == true);
  }

  @override
  void dispose() {
    totalReactionsNotifier.dispose();
    reactionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: reactionNotifier,
          builder: (context, isLikedByMe, _) {
            return IconButton(
              onPressed: () {
                if (isLikedByMe && widget.short.reactions?.byMe == true) {
                  context.read<AddReactCubit>().addReactions(
                      postId: widget.short.id, reactionType: 'love');

                  totalReactionsNotifier.value -= 1;
                  reactionNotifier.value = false;
                } else {
                  context.read<AddReactCubit>().addReactions(
                      reactionType: 'love', postId: widget.short.id);

                  totalReactionsNotifier.value += 1;
                  reactionNotifier.value = true;
                }
              },
              icon: Icon(
                FontAwesomeIcons.solidHeart,
                color: isLikedByMe ? Colors.red : Colors.white,
                size: 30.r,
              ),
            );
          },
        ),
        ValueListenableBuilder<int>(
          valueListenable: totalReactionsNotifier,
          builder: (context, totalReactions, child) {
            return Text(
              '$totalReactions',
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            );
          },
        ),
      ],
    );
  }
}
