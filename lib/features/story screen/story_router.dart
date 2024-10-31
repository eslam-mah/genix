import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/home%20screen/data/models/stories_list.dart';
import 'package:genix/features/home%20screen/data/models/stories_list_model.dart';
import 'package:genix/features/story%20screen/view%20model/add_story_react/add_story_react_cubit.dart';
import 'package:genix/features/story%20screen/view%20model/see_story/see_story_cubit.dart';
import 'package:genix/features/story%20screen/views/view/story_screen.dart';
import 'package:go_router/go_router.dart';

abstract class StoryRouter {
  static final seeStory = SeeStoryCubit();
  static final addStoryReact = AddStoryReactCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
      path: StoryScreen.routeName,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final storyList = extra['storyList'] as StoryList;
        final startingStoryIndex = extra['startingStoryIndex'] as int? ?? 0;

        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: seeStory),
            BlocProvider.value(value: addStoryReact),
          ],
          child: StoryScreen(
            storyList: storyList,
            startingStoryIndex: startingStoryIndex,
          ),
        );
      },
    ),
  ];
}
