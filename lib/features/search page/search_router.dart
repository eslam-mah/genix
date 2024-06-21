import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/search%20page/view%20model/search/search_cubit.dart';
import 'package:genix/features/search%20page/views/view/search_page.dart';
import 'package:go_router/go_router.dart';

abstract class SearchRouter {
  static final searchCubit = SearchCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: SearchPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: searchCubit,
              ),
            ],
            child: SearchPage(args: state.extra as SearchPageArgs),
          );
        }),
  ];
}
