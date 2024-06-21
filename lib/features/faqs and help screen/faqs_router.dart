import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/faqs%20and%20help%20screen/view%20model/get%20documents%20by%20id/get_documents_by_id_cubit.dart';
import 'package:genix/features/faqs%20and%20help%20screen/view%20model/get%20documents/get_documents_cubit.dart';
import 'package:genix/features/faqs%20and%20help%20screen/views/view/help_page.dart';
import 'package:go_router/go_router.dart';

abstract class FaqsRouter {
  static final getAllDocumentsCubit = GetDocumentsCubit();
  static final getDocumentsByIdCubit = GetDocumentsByIdCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: HelpPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getAllDocumentsCubit,
              ),
              BlocProvider.value(
                value: getDocumentsByIdCubit,
              ),
            ],
            child: HelpPage(args: state.extra as HelpPageArgs),
          );
        }),
  ];
}
