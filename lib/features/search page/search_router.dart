import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/search%20page/view%20model/search/search_cubit.dart';
import 'package:genix/features/search%20page/views/view/search_page.dart';
import 'package:genix/features/search%20page/views/view/searched_list_page.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class SearchRouter {
  static final searchCubit = SearchCubit();
  static final getAccountDetails = GetMyAccountDetailsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
      path: SearchPage.route,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: searchCubit,
            ),
            BlocProvider.value(
              value: getAccountDetails,
            ),
          ],
          child: const SearchPage(),
        );
      },
    ),
    GoRoute(
      path: SearchedListPage.route,
      builder: (context, state) {
        // Extract both searchQuery and searchType from the 'extra'
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        final String searchQuery = extra['query'] as String;
        final String searchType = extra['type'] as String;

        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: searchCubit,
            ),
            BlocProvider.value(
              value: getAccountDetails,
            ),
          ],
          child: SearchedListPage(
              searchQuery: searchQuery, searchType: searchType),
        );
      },
    ),
  ];
}
