import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/features/comments%20section/data/models/comments_model.dart';
import 'package:genix/features/comments%20section/view%20model/cubit/add_comment_cubit.dart';
import 'package:genix/features/comments%20section/views/widgets/comment_bubble.dart';
import 'package:genix/features/comments%20section/views/widgets/temp_comment_bubble.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/view%20model/add%20react/add_react_cubit.dart';
import 'package:genix/features/home%20screen/views/widgets/commenting_text_field.dart';
import 'package:genix/features/home%20screen/views/widgets/custom_post_components.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/event_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/image_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/link_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/media_item.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/poll_post.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/shared_post.dart';
import 'package:genix/features/home%20screen/views/widgets/reaction_box.dart';
import 'package:genix/features/home%20screen/views/widgets/reaction_view.dart';
import 'package:genix/features/home%20screen/views/widgets/reacts_list.dart';
import 'package:genix/features/home%20screen/views/widgets/replying_text_field.dart';
import 'package:genix/features/home%20screen/views/widgets/share_post/share_bottom_sheet.dart';
import 'package:genix/features/home%20screen/views/widgets/show_post_tabbar_dialoge.dart';
import 'package:genix/features/home%20screen/views/widgets/post%20types/video_post.dart';
import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart' show parse;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

enum Reaction { angry, laugh, love, sad, surprise, like, none }

enum PostType { image, video, poll, link, event, short, content, shared, media }

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    required this.isNightModeEnabled,
    required this.postsModel,
    required this.id,
    required this.refresh,
    required this.pagingController,
  });
  final int id;
  final bool isNightModeEnabled;
  final PostsModel postsModel;
  final Function() refresh;
  final PagingController<int, PostsModel> pagingController;

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
  final ValueNotifier<int> totalReactionsNotifier = ValueNotifier<int>(0);
  final ValueNotifier<String> userReactionNotifier =
      ValueNotifier<String>(''); // New

  // ValueNotifier to track total reactions count
  bool hasImage = false;
  bool hasVideo = false;

  @override
  void initState() {
    super.initState();
    addReactCubit = BlocProvider.of<AddReactCubit>(context);
    addCommentCubit = BlocProvider.of<AddCommentCubit>(context);
    totalReactionsNotifier.value = _getTotalReactions();
    userReactionNotifier.value =
        ''; // Initialize with the user's current reaction
  }

  int _getTotalReactions() {
    final reactionsSummary = widget.postsModel.reactions?.summary;
    if (reactionsSummary != null) {
      return (reactionsSummary.love ?? 0) +
          (reactionsSummary.sad ?? 0) +
          (reactionsSummary.haha ?? 0) +
          (reactionsSummary.angry ?? 0) +
          (reactionsSummary.like ?? 0) +
          (reactionsSummary.wow ?? 0);
    }
    return 0;
  }

  List<PostType> _determinePostTypes(PostsModel postModel) {
    final List<PostType> postTypes = [];
    if (postModel.uploads != null) {
      // Check for images
      if (postModel.uploads!.any((upload) =>
          upload.type == "image/png" ||
          upload.type == "image/jpeg" ||
          upload.type == "image/webp")) {
        hasImage = true;
      }
      // Check for videos
      if (postModel.uploads!.any((upload) =>
          upload.type == 'video/mov' ||
          upload.type == 'video/mp4' ||
          upload.type == 'video/webm' ||
          upload.type == 'video/heic')) {
        hasVideo = true;
      }

      if (hasImage && hasVideo) {
        postTypes.add(PostType.media);
      } else if (hasImage) {
        postTypes.add(PostType.image);
      } else if (hasVideo) {
        postTypes.add(PostType.video);
      }
    }

    if (postModel.misc != null && postModel.misc!.poll != null) {
      postTypes.add(PostType.poll);
    }

    if (postModel.ogInfo != null) {
      postTypes.add(PostType.link);
    }
    if (postModel.isEvent == true) {
      postTypes.add(PostType.event);
    }
    if (postModel.isVideoShort == true) {
      postTypes.add(PostType.short);
    }
    if (postModel.sharedPost != null) {
      postTypes.add(PostType.shared);
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
      case PostType.media:
        return MediaPost(postsModel: widget.postsModel);
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
      case PostType.shared:
        return SharedPost(postsModel: widget.postsModel.sharedPost!);
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
      return Container();
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          reactionView = false;
        });
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: ThemeCubit().state == ThemeState.dark
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
                          GoRouter.of(context).push(ProfilePage.route,
                              extra: widget.postsModel.user?.username);
                        },
                        borderRadius: BorderRadius.circular(400.r),
                        child: CustomUserProfileImage(
                          showname: user.showname ?? '',
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
                                InkWell(
                                  onTap: () {
                                    GoRouter.of(context).push(ProfilePage.route,
                                        extra:
                                            widget.postsModel.user?.username);
                                  },
                                  child: CustomTextWidget(
                                    textSize: 12.sp,
                                    fontFamily: 'fontFamily',
                                    color: AppColors.kPrimaryColor,
                                    fontWeight: FontWeight.normal,
                                    text: user.showname ?? 'Unknown User',
                                  ),
                                ),
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
                          showPostTabBar(context, widget.id, widget.postsModel,
                              widget.refresh, widget.pagingController);
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
                                        // ignore: deprecated_member_use
                                        if (await canLaunch(
                                            widget.postsModel.ogInfo?.url ??
                                                '')) {
                                          // ignore: deprecated_member_use
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
                        ReactsList(
                          postsModel: widget.postsModel,
                          totalReactionsNotifier: totalReactionsNotifier,
                          userReactionNotifier: userReactionNotifier,
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
                            onLongPress: () {
                              setState(() {
                                reactionView = !reactionView;
                              });
                            },
                            child: ReactionBox(
                              postsModel: widget.postsModel,
                              reaction: reaction,
                            )),
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
                            shareBottomSheet(context,
                                postModel: widget.postsModel);
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
                              textEditingController:
                                  commentTextEditingController)
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
                child: ReactionView(
                  postsModel: widget.postsModel,
                  addReactCubit: addReactCubit,
                  reaction: reaction,
                  onClose: () {
                    setState(() {
                      reactionView = false; // Close the ReactionView
                    });
                  },
                  totalReactionsNotifier: totalReactionsNotifier,
                  userReactionNotifier: userReactionNotifier,
                )),
        ],
      ),
    );
  }
}
