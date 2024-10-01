import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';
import 'package:genix/features/comments%20section/data/models/comments_model.dart';
import 'package:genix/features/comments%20section/view%20model/cubit/add_comment_cubit.dart';
import 'package:genix/features/comments%20section/views/widgets/comment_bubble.dart';
import 'package:genix/features/comments%20section/views/widgets/temp_comment_bubble.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/summary.dart';
import 'package:genix/features/home%20screen/view%20model/add%20react/add_react_cubit.dart';
import 'package:genix/features/home%20screen/views/widgets/commenting_text_field.dart';
import 'package:genix/features/home%20screen/views/widgets/custom_post_components.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/event_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/image_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/link_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/poll_post.dart';
import 'package:genix/features/home%20screen/views/widgets/replying_text_field.dart';
import 'package:genix/features/home%20screen/views/widgets/share_bottom_sheet.dart';
import 'package:genix/features/home%20screen/views/widgets/show_post_tabbar_dialoge.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/video_post.dart';
import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:html/parser.dart' show parse;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

enum Reaction { cry, cute, angry, laugh, love, sad, surprise, wink, none }

enum PostType { image, video, poll, link, event, short, content }

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    required this.isNightModeEnabled,
    required this.postsModel,
    required this.id,
    required this.refresh,
  });
  final int id;
  final bool isNightModeEnabled;
  final PostsModel postsModel;
  final Function() refresh;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  Reaction reaction = Reaction.none;
  bool reactionView = false;
  bool isVideo = false;
  bool isComment = false;
  bool isReply = false;
  bool viewMoreComments = false;
  bool isAddingComment = false;
  bool showThirdWidget = false; // New boolean to control the third widget
  List<Comment> comments = [];
  List<Comment> replies = [];
  Comment comment = Comment();
  TextEditingController replyTextEditingController = TextEditingController();
  TextEditingController commentTextEditingController = TextEditingController();
  late AddReactCubit addReactCubit;
  late AddCommentCubit addCommentCubit;
  @override
  void initState() {
    super.initState();
    addReactCubit = BlocProvider.of<AddReactCubit>(context);
    addCommentCubit = BlocProvider.of<AddCommentCubit>(context);
  }

  List<PostType> _determinePostTypes(PostsModel postModel) {
    final List<PostType> postTypes = [];
    if (postModel.uploads != null) {
      if (postModel.uploads!.any((upload) =>
          upload.type == "image/png" ||
          upload.type == "image/jpeg" ||
          upload.type == "image/webp")) {
        postTypes.add(PostType.image);
      }
      if (postModel.uploads!.any((upload) => upload.type == 'video')) {
        postTypes.add(PostType.video);
      }
    }
    if (postModel.misc != null && postModel.misc!.poll != null) {
      if (postModel.misc!.poll != null) {
        postTypes.add(PostType.poll);
      }
    }
    if (postModel.ogInfo != null) {
      postTypes.add(PostType.link);
    }
    if (postModel.isEvent == true) {
      postTypes.add(PostType.event);
    }
    if (postModel.isVideoShort == true) {
      postTypes.add(PostType.short);
    } else {
      postTypes.add(PostType.content);
    }
    return postTypes;
  }

  Widget _getPostType(PostType postType, PostsModel postModel) {
    switch (postType) {
      case PostType.image:
        return ImagePost(postsModel: widget.postsModel);
      case PostType.video:
        return VideoPost(postsModel: widget.postsModel);
      case PostType.poll:
        return PollPost(
          postsModel: widget.postsModel,
          isNightMode: widget.isNightModeEnabled,
        );
      case PostType.event:
        return EventPost(
          postsModel: widget.postsModel,
          isNightMode: widget.isNightModeEnabled,
        );
      case PostType.link:
        return LinkPost(
          postsModel: widget.postsModel,
          isNightMode: widget.isNightModeEnabled,
        );
      case PostType.short:
        return const Text('short');
      case PostType.content:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }

  String _removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  final List<dynamic> reactions = [
    _ReactionElement(Lottie.asset(AppLottie.kLaughReact), Reaction.laugh),
    _ReactionElement(Lottie.asset(AppLottie.kSadReact), Reaction.sad),
    _ReactionElement(Lottie.asset(AppLottie.kWowReact), Reaction.surprise),
    _ReactionElement(Lottie.asset(AppLottie.kCry), Reaction.cry),
    _ReactionElement(Lottie.asset(AppLottie.kLove), Reaction.love),
    _ReactionElement(Lottie.asset(AppLottie.kAngryReact), Reaction.angry),
    _ReactionElement(Lottie.asset(AppLottie.kWinkReact), Reaction.wink),
    _ReactionElement(Lottie.asset(AppLottie.kCute), Reaction.cute),
  ];

  int _getTotalReactions() {
    final reactionsSummary = widget.postsModel.reactions?.summary;
    if (reactionsSummary != null) {
      int totalReactions = (reactionsSummary.love ?? 0) +
          (reactionsSummary.cute ?? 0) +
          (reactionsSummary.sad ?? 0) +
          (reactionsSummary.haha ?? 0) +
          (reactionsSummary.angry ?? 0) +
          (reactionsSummary.cry ?? 0) +
          (reactionsSummary.wink ?? 0) +
          (reactionsSummary.wow ?? 0);
      return totalReactions;
    }
    return 0;
  }

  void _handleReactionPress(Reaction selectedReaction) {
    String reactionType = '';
    switch (selectedReaction) {
      case Reaction.cute:
        reactionType = 'cute';
        break;
      case Reaction.love:
        reactionType = 'love';
        break;
      case Reaction.surprise:
        reactionType = 'wow';
        break;
      case Reaction.laugh:
        reactionType = 'haha';
        break;
      case Reaction.angry:
        reactionType = 'angry';
        break;
      case Reaction.sad:
        reactionType = 'sad';
        break;
      case Reaction.cry:
        reactionType = 'cry';
        break;
      case Reaction.wink:
        reactionType = 'wink';
        break;
      default:
        break;
    }
    // Update the total reactions count instantly in the UI
    setState(() {
      // Increase the total reactions count based on the selected reaction
      if (reactionType == 'cute' && widget.postsModel.reactions?.byMe == null) {
        widget.postsModel.reactions?.summary?.love =
            (widget.postsModel.reactions?.summary?.love ?? 0) + 1;
      } else if (reactionType == 'love' &&
          widget.postsModel.reactions?.byMe == null) {
        widget.postsModel.reactions?.summary?.cute =
            (widget.postsModel.reactions?.summary?.cute ?? 0) + 1;
      } else if (reactionType == 'wow' &&
          widget.postsModel.reactions?.byMe == null) {
        widget.postsModel.reactions?.summary?.wow =
            (widget.postsModel.reactions?.summary?.wow ?? 0) + 1;
      } else if (reactionType == 'haha' &&
          widget.postsModel.reactions?.byMe == null) {
        widget.postsModel.reactions?.summary?.haha =
            (widget.postsModel.reactions?.summary?.haha ?? 0) + 1;
      } else if (reactionType == 'angry' &&
          widget.postsModel.reactions?.byMe == null) {
        widget.postsModel.reactions?.summary?.angry =
            (widget.postsModel.reactions?.summary?.angry ?? 0) + 1;
      } else if (reactionType == 'sad' &&
          widget.postsModel.reactions?.byMe == null) {
        widget.postsModel.reactions?.summary?.sad =
            (widget.postsModel.reactions?.summary?.sad ?? 0) + 1;
      } else if (reactionType == 'cry' &&
          widget.postsModel.reactions?.byMe == null) {
        widget.postsModel.reactions?.summary?.cry =
            (widget.postsModel.reactions?.summary?.cry ?? 0) + 1;
      } else if (reactionType == 'wink' &&
          widget.postsModel.reactions?.byMe == null) {
        widget.postsModel.reactions?.summary?.wink =
            (widget.postsModel.reactions?.summary?.wink ?? 0) + 1;
      }
    });

    // Call the backend to update the reaction
    addReactCubit.addReactions(
        reactionType: reactionType, postId: widget.postsModel.id!.toInt());
  }

  Widget _buildReactionIcon(String lottieFile) {
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

  Widget _buildReactionsRow(Summary summary) {
    List<Widget> reactionWidgets = [];

    if (summary.love != null && summary.love! > 0) {
      reactionWidgets.add(_buildReactionIcon(AppLottie.kLove));
    }
    if (summary.cute != null && summary.cute! > 0) {
      reactionWidgets.add(_buildReactionIcon(AppLottie.kCute));
    }
    if (summary.wow != null && summary.wow! > 0) {
      reactionWidgets.add(_buildReactionIcon(AppLottie.kWowReact));
    }
    if (summary.haha != null && summary.haha! > 0) {
      reactionWidgets.add(_buildReactionIcon(AppLottie.kLaughReact));
    }
    if (summary.angry != null && summary.angry! > 0) {
      reactionWidgets.add(_buildReactionIcon(AppLottie.kAngryReact));
    }
    if (summary.sad != null && summary.sad! > 0) {
      reactionWidgets.add(_buildReactionIcon(AppLottie.kSadReact));
    }
    if (summary.cry != null && summary.cry! > 0) {
      reactionWidgets.add(_buildReactionIcon(AppLottie.kCry));
    }
    if (summary.wink != null && summary.wink! > 0) {
      reactionWidgets.add(_buildReactionIcon(AppLottie.kWinkReact));
    }

    // Limit to 3 reactions
    if (reactionWidgets.length > 3) {
      reactionWidgets = reactionWidgets.sublist(0, 3);
    }

    return SizedBox(
      width: reactionWidgets.length == 1
          ? 40.r
          : reactionWidgets.length == 2
              ? 60.r
              : 80.r,
      height: 40.r,
      child: Stack(
        children: List.generate(reactionWidgets.length, (index) {
          return Positioned(
            left: index * 20.r, // Adjust the spacing between reactions
            child: reactionWidgets[index],
          );
        }),
      ),
    );
  }

  Widget _getReactionIcon(Reaction r) {
    final reactionByMe = widget.postsModel.reactions?.byMe;

    // Check the reaction type directly from `reactionByMe`
    if (reactionByMe == "sad" || r == Reaction.sad) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kSadReact), const Text('Sad')],
      );
    } else if (reactionByMe == "like" || r == Reaction.love) {
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
    } else if (reactionByMe == "cry" || r == Reaction.cry) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kCry), const Text('Cry')],
      );
    } else if (reactionByMe == "wow" || r == Reaction.surprise) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kWowReact), const Text('Wow')],
      );
    } else if (reactionByMe == "wink" || r == Reaction.wink) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kWinkReact), const Text('Wink')],
      );
    } else if (reactionByMe == "love" || r == Reaction.cute) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Lottie.asset(AppLottie.kCute), const Text('Cute')],
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

  Future<void> addComment() async {
    String commentText = commentTextEditingController.text.trim();
    if (commentText.isNotEmpty) {
      // Create a temporary comment object to show immediately
      Comment tempComment = Comment(
        content: commentText,
        postId: widget.postsModel.id?.toInt(),
        id: DateTime.now().millisecondsSinceEpoch, // Temporary unique ID
      );

      // Add the comment instantly to the UI
      setState(() {
        comments.add(tempComment);
        commentTextEditingController.clear(); // Clear the text field
      });

      // Perform the actual comment submission
      try {
        await addCommentCubit.addComments(comment: tempComment);
        // Add a third comment after successfully adding the original comment
        addThirdCommentForVisualEffect(commentText);
        showThirdWidget = true; // Show the third widget when a comment is added
      } catch (error) {
        // Handle error if needed
        setState(() {
          // If the comment submission fails, you can remove the temporary comment
          comments.remove(tempComment);
        });
      }
    }
  }

  // This function adds a third comment for visual effect, using the same text as the original comment
  void addThirdCommentForVisualEffect(String commentText) {
    setState(() {
      comments.add(Comment(
        content: commentText, // Use the same text as the original comment
        postId: widget.postsModel.id?.toInt(),
        id: DateTime.now().millisecondsSinceEpoch + 1,
      ));
    });
  }

  Future<void> addReply() async {
    String commentText = replyTextEditingController.text.trim();
    if (commentText.isNotEmpty) {
      if (mounted) {
        setState(() {
          isAddingComment = true; // Set loading state
        });
      }

      // Create a temporary comment object to show immediately
      Comment tempComment = Comment(
        content: commentText,
        postId: widget.postsModel.id?.toInt(),
        commentId: widget.postsModel.comments?.first.id,
        id: DateTime.now().millisecondsSinceEpoch, // Temporary unique ID
      );

      // Add the comment instantly to the UI
      if (mounted) {
        setState(() {
          comments.add(tempComment);
          replyTextEditingController.clear();
        });
      }

      // Perform the actual comment submission
      await addCommentCubit.addComments(comment: tempComment);

      // After the comment is successfully added, remove the temporary loading state
      if (mounted) {
        setState(() {
          isAddingComment = false; // Reset loading state
        });
      }
    }
  }

  List<Comment> _flattenCommentsAndReplies() {
    List<Comment> flattenedList = [];

    // Iterate over all comments
    for (var comment in widget.postsModel.comments!) {
      // Add the parent comment first
      if (comment.commentId == null) {
        flattenedList.add(comment);

        // Add the replies associated with this comment
        for (var reply in widget.postsModel.comments!) {
          if (reply.commentId == comment.id) {
            flattenedList.add(reply);
          }
        }
      }
    }

    // Include the newly added comments that are in the `comments` list
    flattenedList.addAll(comments);

    return flattenedList;
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.postsModel.user;
    final content = widget.postsModel.content != null
        ? _removeHtmlTags(widget.postsModel.content!)
        : '';
    if (user == null) {
      return Container(); // Return an empty container or a placeholder if the data is invalid
    }
    int totalReactions = _getTotalReactions();

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: widget.isNightModeEnabled
                  ? DarkModeColors.kItemColorDark
                  : AppColors.kPostColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
              child: Column(children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        GoRouter.of(context)
                            .push(ProfilePage.route, extra: widget.postsModel);
                      },
                      borderRadius: BorderRadius.circular(400.r),
                      child: CustomUserProfileImage(
                        image: user.profileImg ?? '',
                        isActive: user.isActive ?? false,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomTextWidget(
                                  textSize: 12.sp,
                                  fontFamily: 'fontFamily',
                                  color: AppColors.kPrimaryColor,
                                  fontWeight: FontWeight.normal,
                                  text: user.showname ?? 'Unknown User',
                                  isNightMode: widget.isNightModeEnabled),
                              if (widget.postsModel.user!.isVerified == true)
                                Image.asset(
                                  AppGifs.kVerified,
                                  width: 20.w,
                                ),
                            ],
                          ),
                          if (user.createdAt != null)
                            Text(DateFormat('MMMM d, yyyy')
                                .format(widget.postsModel.createdAt!))
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showPostTabBar(context, widget.isNightModeEnabled,
                            widget.id, widget.postsModel);
                      },
                      icon: const Icon(FontAwesomeIcons.ellipsis),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                widget.postsModel.content != null
                    ? Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: widget.postsModel.ogInfo != null
                                  ? () async {
                                      if (await canLaunch(
                                          widget.postsModel.ogInfo?.url ??
                                              '')) {
                                        await launch(
                                            widget.postsModel.ogInfo?.url ??
                                                '');
                                      } else {
                                        throw 'Could not launch ${widget.postsModel.ogInfo?.url ?? ''}';
                                      }
                                    }
                                  : null,
                              child: CustomTextWidget(
                                textSize: 15.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.normal,
                                color: widget.postsModel.ogInfo != null
                                    ? Colors.blue
                                    : null,
                                text: content,
                                isNightMode: widget.isNightModeEnabled,
                              ),
                            ),
                          ),
                          SizedBox(height: 7.h),
                        ],
                      )
                    : const SizedBox.shrink(),
                _getPostType(_determinePostTypes(widget.postsModel).first,
                    widget.postsModel),
                SizedBox(height: 4.h),
                if (widget.postsModel.isEvent == false) ...[
                  Divider(
                      color: widget.isNightModeEnabled
                          ? Colors.black
                          : Colors.white),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      _buildReactionsRow(
                          widget.postsModel.reactions?.summary ?? Summary()),
                      SizedBox(width: 3.w),
                      SizedBox(
                        width: 30.w,
                        child: CustomTextWidget(
                            textSize: 13.sp,
                            isNightMode: widget.isNightModeEnabled,
                            fontFamily: '',
                            fontWeight: FontWeight.w500,
                            text: ' $totalReactions'),
                      ),
                      const Spacer(),
                      Icon(FontAwesomeIcons.solidComment, size: 11.sp),
                      SizedBox(width: 9.w),
                      SizedBox(
                          width: widget.postsModel.commentsCount!.toDouble(),
                          child: Text("${widget.postsModel.commentsCount}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11.sp))),
                      SizedBox(width: 9.w),
                      Text('Comments', style: TextStyle(fontSize: 11.sp)),
                      SizedBox(width: 9.w),
                      Icon(FontAwesomeIcons.share, size: 11.sp),
                      SizedBox(width: 9.w),
                      SizedBox(
                          width: widget.postsModel.sharesCount!.toDouble(),
                          child: Text("${widget.postsModel.sharesCount}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11.sp))),
                      SizedBox(width: 9.w),
                      Text('Shares', style: TextStyle(fontSize: 11.sp)),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (reaction == Reaction.none) {
                              reaction = Reaction.love;
                              _handleReactionPress(reaction);
                            }
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            reactionView = true;
                          });
                        },
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: widget.isNightModeEnabled
                                ? Colors.black
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: _getReactionIcon(reaction),
                        ),
                      ),
                      CustomPostComponents(
                        icon: FontAwesomeIcons.solidComment,
                        width: 100.w,
                        text: 'Comment',
                        onTap: () {
                          setState(() {
                            isComment = !isComment;
                            isReply = false;
                          });
                        },
                        isNightMode: widget.isNightModeEnabled,
                      ),
                      CustomPostComponents(
                        icon: FontAwesomeIcons.share,
                        width: 100.w,
                        isNightMode: widget.isNightModeEnabled,
                        text: 'Share',
                        onTap: () {
                          shareBottomSheet(context);
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        children: _flattenCommentsAndReplies()
                            .take(viewMoreComments
                                ? _flattenCommentsAndReplies().length
                                : 2)
                            .map((item) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  child: item.content == null
                                      ? Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: double.infinity,
                                            height: 50.h,
                                            color: Colors.grey[300],
                                          ),
                                        )
                                      : CustomCommentBubble(
                                          onTap: () {
                                            setState(() {
                                              isReply = !isReply;
                                              isComment = false;
                                            });
                                          },
                                          isNightMode:
                                              widget.isNightModeEnabled,
                                          postsModel: item,
                                        ),
                                ))
                            .toList(),
                      ),
                      if (showThirdWidget)
                        Padding(
                            padding: EdgeInsets.all(10.r),
                            child: TempCommentBubble(
                                onTap: () {},
                                isNightMode: widget.isNightModeEnabled,
                                commentText: comments.last.content ?? '',
                                postsModel: Comment())),
                      if (_flattenCommentsAndReplies().length > 2) ...[
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                viewMoreComments = !viewMoreComments;
                              });
                            },
                            child: CustomTextWidget(
                                textSize: 13.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.normal,
                                isNightMode: widget.isNightModeEnabled,
                                text: viewMoreComments
                                    ? 'Hide comments'
                                    : 'View more comments'),
                          ),
                        )
                      ],
                      if (isComment) ...[
                        SizedBox(height: 10.h),
                        CommentingTextField(
                            postsModel: widget.postsModel,
                            onPressed: () {
                              addComment();
                              // widget.refresh();
                            },
                            textEditingController: commentTextEditingController)
                      ] else if (isReply) ...[
                        SizedBox(height: 10.h),
                        ReplyingTextField(
                            postsModel: widget.postsModel,
                            onPressed: () {
                              addReply();
                              // widget.refresh();
                            },
                            textEditingController: replyTextEditingController)
                      ],
                    ],
                  )
                ],
              ]),
            ),
          ),
        ),
        if (reactionView)
          Positioned(
            bottom: widget.postsModel.comments!.length < 2
                ? widget.postsModel.comments!.isEmpty
                    ? 70.h
                    : 150.h
                : 270.h,
            left: 30.w,
            child: Container(
              height: 60.h,
              width: 300.w,
              decoration: BoxDecoration(
                color: widget.isNightModeEnabled
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
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (reactionView &&
                                  reaction != reactions[index].reaction) {
                                reaction = reactions[index].reaction;
                                _handleReactionPress(reaction);
                                totalReactions++;
                              }
                              reactionView = false;
                            });
                          },
                          icon: reactions[index].image,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _ReactionElement {
  final Reaction reaction;
  final LottieBuilder image;
  _ReactionElement(this.image, this.reaction);
}
