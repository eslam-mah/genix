import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/comments%20section/data/models/comments_model.dart';
import 'package:genix/features/comments%20section/view%20model/cubit/add_comment_cubit.dart';
import 'package:genix/features/comments%20section/view%20model/cubit/add_comment_react_cubit.dart';
import 'package:genix/features/comments%20section/views/widgets/comment_bubble.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

class CommentsBody extends StatefulWidget {
  const CommentsBody({super.key, required this.postsModel});
  static const String routeName = '/comments_page';
  final PostsModel postsModel;

  @override
  State<CommentsBody> createState() => _CommentsBodyState();
}

class _CommentsBodyState extends State<CommentsBody> {
  List<Comment> comments = [];
  List<Comment> replies = [];
  Comment comment = Comment();
  final PagingController<int, Comment> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  TextEditingController textEditingController = TextEditingController();

  late AddCommentCubit addCommentCubit;

  @override
  void initState() {
    super.initState();
    addCommentCubit = BlocProvider.of<AddCommentCubit>(context);
    for (var comment in widget.postsModel.comments!) {
      if (comment.commentId == null) {
        comments.add(comment);
      } else {
        replies.add(comment);
      }
    }
  }

  Future<void> _fetchPage(List<Comment> postsList) async {
    try {
      final newItems = postsList;
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _nextPageKey++;
        _pagingController.appendPage(newItems, _nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  List<Comment> getReplies(int commentId) {
    return replies.where((reply) => reply.commentId == commentId).toList();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> addComment() async {
    String commentText = textEditingController.text.trim();
    if (commentText.isNotEmpty) {
      // Create a new Comment object with a temporary ID
      Comment newComment = Comment(
        content: commentText,
        postId: widget.postsModel.id?.toInt(),
      );

      // Add the comment to the list with shimmer effect
      setState(() {
        comments.add(newComment);
        textEditingController.clear();
      });

      // Trigger the Cubit to add the comment
      addCommentCubit.addComments(comment: newComment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddCommentCubit, AddCommentState>(
          listener: (context, addState) {
            if (addState is AddCommentSuccess) {
              setState(() {
                comments.removeLast(); // Remove the shimmer comment
                comments.add(addState.addComment);
                print('Comment added successfully');
              });
            }
          },
        ),
        BlocListener<AddCommentReactCubit, AddCommentReactState>(
          listener: (context, addState) {
            if (addState is AddCommentReactSuccess) {
              // Handle comment reaction success
              setState(() {
                // Assuming you're handling the reaction logic here
              });
            }
          },
        ),
      ],
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () {
            setState(() {
              _nextPageKey = 1;
            });
            _pagingController.refresh();
          },
        ),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 45.h,
            title: const Text('Comments'),
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Expanded(
                      child: widget.postsModel.comments == null ||
                              widget.postsModel.comments!.isEmpty
                          ? Center(
                              child: CustomTextWidget(
                                textSize: 17.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.normal,
                                // color: Colors.black.withOpacity(0.4),
                                text: 'No comments yet',
                              ),
                            )
                          : ListView.builder(
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                final comment = comments[index];
                                final commentReplies =
                                    getReplies(comment.id ?? 0);

                                return BlocBuilder<AddCommentCubit,
                                    AddCommentState>(
                                  builder: (context, addState) {
                                    bool isLoading =
                                        addState is AddCommentLoading;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        isLoading &&
                                                index == comments.length - 1
                                            ? Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: CustomCommentBubble(
                                                  onTap: () {},
                                                  postsModel: comment,
                                                ),
                                              )
                                            : CustomCommentBubble(
                                                onTap: () {},
                                                postsModel: comment,
                                              ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.w),
                                          child: Column(
                                            children: List.generate(
                                                commentReplies.length, (i) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                child: CustomCommentBubble(
                                                  onTap: () {},
                                                  postsModel: commentReplies[i],
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
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
                              'Reply to ${widget.postsModel.user?.showname} post',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.5)),
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            gapPadding: 0,
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          disabledBorder: OutlineInputBorder(
                            gapPadding: 0,
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              addComment(); // Add the comment with shimmer effect
                            },
                            icon: const Icon(FontAwesomeIcons.solidPaperPlane),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
