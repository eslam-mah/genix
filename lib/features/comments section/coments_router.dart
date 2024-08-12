import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/comments%20section/views/view/commentsbody.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/view%20model/get%20newsfeed%20posts/get_newsfeed_posts_cubit.dart';

import 'package:go_router/go_router.dart';

abstract class CommentsRouter {
  static final getNewsFeedPostsCubit = GetNewsFeedPostsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: CommentsBody.routeName,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getNewsFeedPostsCubit,
              ),
            ],
            child: CommentsBody(
              postsModel: state.extra as PostsModel,
            ),
          );
        }),
  ];
}
