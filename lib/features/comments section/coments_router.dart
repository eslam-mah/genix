import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/comments%20section/view%20model/cubit/add_comment_cubit.dart';
import 'package:genix/features/comments%20section/view%20model/cubit/add_comment_react_cubit.dart';
import 'package:genix/features/comments%20section/views/view/commentsbody.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/view%20model/get%20newsfeed%20posts/get_newsfeed_posts_cubit.dart';

import 'package:go_router/go_router.dart';

abstract class CommentsRouter {
  static final getNewsFeedPostsCubit = GetNewsFeedPostsCubit();
  static final addCommentCubit = AddCommentCubit();
  static final addCommentReactCubit = AddCommentReactCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: CommentsBody.routeName,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getNewsFeedPostsCubit,
              ),
              BlocProvider.value(
                value: addCommentCubit,
              ),
              BlocProvider.value(
                value: addCommentReactCubit,
              ),
            ],
            child: CommentsBody(
              postsModel: state.extra as PostsModel,
            ),
          );
        }),
  ];
}
