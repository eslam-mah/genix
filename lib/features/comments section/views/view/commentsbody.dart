import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/comments%20section/data/models/comments_model.dart';
import 'package:genix/features/comments%20section/views/widgets/comment_bubble.dart';
import 'package:genix/features/comments%20section/views/widgets/comments_list.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/view%20model/get%20newsfeed%20posts/get_newsfeed_posts_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
  final PagingController<int, PostsModel> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  TextEditingController textEditingController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    for (var comment in widget.postsModel.comments!) {
      if (comment.commentId == null) {
        comments.add(comment);
      } else {
        replies.add(comment);
      }
    }
  }

  Future<void> _fetchPage(List<PostsModel> postsList) async {
    try {
      setState(() {
        _isLoading = true;
      });
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
    } finally {
      setState(() {
        _isLoading = false;
      });
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
      setState(() {
        // Add logic to add the comment to the comments list or send it to the backend
        textEditingController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetNewsFeedPostsCubit, GetNewsFeedPostsState>(
      listener: (context, state) {
        if (state is GetNewsFeedPostsSuccess) {
          _fetchPage(state.posts.data.postsModel);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: _isLoading
            ? CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              )
            : Stack(
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
                                    color: Colors.black.withOpacity(0.4),
                                    text: 'No comments yet',
                                  ),
                                )
                              : RefreshIndicator(
                                  onRefresh: () => Future.sync(
                                    () {
                                      setState(() {
                                        _nextPageKey = 1;
                                      });
                                      _pagingController.refresh();
                                    },
                                  ),
                                  child: ListView.builder(
                                    itemCount: comments.length,
                                    itemBuilder: (context, index) {
                                      final comment = comments[index];
                                      final commentReplies =
                                          getReplies(comment.id ?? 0);

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomCommentBubble(
                                              onTap: () {},
                                              postsModel: comment),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.w),
                                            child: Column(
                                              children: List.generate(
                                                  commentReplies.length, (i) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.h),
                                                  child: CustomCommentBubble(
                                                      onTap: () {},
                                                      postsModel:
                                                          commentReplies[i]),
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
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
                              hintText: 'Reply to Name post',
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
                                  setState(() {
                                    addComment();
                                  });
                                },
                                icon: const Icon(
                                    FontAwesomeIcons.solidPaperPlane),
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
    );
  }
}
