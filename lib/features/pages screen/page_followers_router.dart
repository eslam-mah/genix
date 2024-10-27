import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/pages%20screen/data/models/page_profile_model/page_profile_model.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page_member/delete_page_member_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page_member_comment/delete_page_member_comment_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page_member_post/delete_page_member_post_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/get_page_members/get_page_members_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/post_page_invitation/post_page_invitation_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/update_page_invitation/update_page_invitation_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/update_page_member/update_page_member_cubit.dart';
import 'package:genix/features/pages%20screen/views/screens/page_followers_screen.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class PageFollowersRouter {
  static final deletePageMemberCubit = DeletePageMemberCubit();
  static final deletePageMemberCommentCubit = DeletePageMemberCommentCubit();
  static final deletePageMemberPostCubit = DeletePageMemberPostCubit();
  static final getPageMembersCubit = GetPageMembersCubit();
  static final postPageInvitationCubit = PostPageInvitationCubit();
  static final getAccountDetails = GetMyAccountDetailsCubit();
  static final updatePageInvitationCubit = UpdatePageInvitationCubit();
  static final updatePageMemberCubit = UpdatePageMemberCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: PageFollowersScreen.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: deletePageMemberCubit,
              ),
              BlocProvider.value(
                value: deletePageMemberCommentCubit,
              ),
              BlocProvider.value(
                value: getAccountDetails,
              ),
              BlocProvider.value(
                value: deletePageMemberCommentCubit,
              ),
              BlocProvider.value(
                value: getPageMembersCubit,
              ),
              BlocProvider.value(
                value: postPageInvitationCubit,
              ),
              BlocProvider.value(
                value: updatePageInvitationCubit,
              ),
              BlocProvider.value(
                value: updatePageMemberCubit,
              ),
            ],
            child: PageFollowersScreen(
              page: state.extra as PageProfileModel,
            ),
          );
        }),
  ];
}
