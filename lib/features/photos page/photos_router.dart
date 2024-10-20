import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/photos%20page/view%20model/get%20photo%20posts/get_photo_posts_cubit.dart';
import 'package:genix/features/photos%20page/views/view/photos_page.dart';

import 'package:go_router/go_router.dart';

abstract class PhotosRouter {
  static final getPhotosCubit = GetPhotoPostsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: PhotosPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getPhotosCubit,
              ),
            ],
            child: PhotosPage(id: state.extra as int),
          );
        }),
  ];
}
