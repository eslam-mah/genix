import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/photos%20page/view%20model/get%20photo%20posts/get_photo_posts_cubit.dart';
import 'package:genix/features/photos%20page/views/view/my_photos_page.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';

import 'package:go_router/go_router.dart';

abstract class MyPhotosRouter {
  static final getPhotosCubit = GetPhotoPostsCubit();
  static final getMyAccountDetails = GetMyAccountDetailsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: MyPhotosPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getPhotosCubit,
              ),
              BlocProvider.value(
                value: getMyAccountDetails,
              ),
            ],
            child: MyPhotosPage(),
          );
        }),
  ];
}
