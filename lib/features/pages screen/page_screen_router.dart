import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/comments%20section/view%20model/cubit/add_comment_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/add%20react/add_react_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/create_page/create_page_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page/delete_page_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page_member/delete_page_member_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page_member_comment/delete_page_member_comment_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/delete_page_member_post/delete_page_member_post_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/follow_page/follow_page_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/get_all_pages/get_all_pages_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/get_page_by_id/get_page_by_id_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/get_page_members/get_page_members_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/get_page_photos/get_page_photos_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/post_page_invitation/post_page_invitation_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/post_page_rating/post_page_rating_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/remove_follow_page/remove_follow_page_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/update_page_details/update_page_details_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/update_page_invitation/update_page_invitation_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/update_page_member/update_page_member_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/update_page_profile/update_page_profile_cubit.dart';
import 'package:genix/features/pages%20screen/views/screens/pages_screen_body.dart';
import 'package:go_router/go_router.dart';

abstract class PagesScreenRouter {
  static final createPageCubit = CreatePageCubit();
  static final deletePageCubit = DeletePageCubit();
  static final deletePageMemberCubit = DeletePageMemberCubit();
  static final deletePageMemberCommentCubit = DeletePageMemberCommentCubit();
  static final deletePageMemberPostCubit = DeletePageMemberPostCubit();
  static final getAllPagesCubit = GetAllPagesCubit();
  static final getPageByIdCubit = GetPageByIdCubit();
  static final getPageMembersCubit = GetPageMembersCubit();
  static final getPagePhotosCubit = GetPagePhotosCubit();
  static final followPageCubit = FollowPageCubit();
  static final postPageInvitationCubit = PostPageInvitationCubit();
  static final postPageRatingCubit = PostPageRatingCubit();
  static final removeJoinPageCubit = RemoveFollowPageCubit();
  static final updatePageDetailsCubit = UpdatePageDetailsCubit();
  static final updatePageInvitationCubit = UpdatePageInvitationCubit();
  static final updatePageMemberCubit = UpdatePageMemberCubit();
  static final updatePageProfileCubit = UpdatePageProfileCubit();
  static final addReactCubit = AddReactCubit();
  static final addCommentCubit = AddCommentCubit();
  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: PagesScreen.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: createPageCubit,
              ),
              BlocProvider.value(
                value: deletePageCubit,
              ),
              BlocProvider.value(
                value: deletePageMemberCubit,
              ),
              BlocProvider.value(
                value: deletePageMemberCommentCubit,
              ),
              BlocProvider.value(
                value: deletePageMemberCommentCubit,
              ),
              BlocProvider.value(
                value: getAllPagesCubit,
              ),
              BlocProvider.value(
                value: getPageByIdCubit,
              ),
              BlocProvider.value(
                value: getPageMembersCubit,
              ),
              BlocProvider.value(
                value: getPagePhotosCubit,
              ),
              BlocProvider.value(
                value: followPageCubit,
              ),
              BlocProvider.value(
                value: postPageInvitationCubit,
              ),
              BlocProvider.value(
                value: postPageRatingCubit,
              ),
              BlocProvider.value(
                value: removeJoinPageCubit,
              ),
              BlocProvider.value(
                value: updatePageDetailsCubit,
              ),
              BlocProvider.value(
                value: updatePageInvitationCubit,
              ),
              BlocProvider.value(
                value: updatePageMemberCubit,
              ),
              BlocProvider.value(
                value: updatePageProfileCubit,
              ),
              BlocProvider.value(
                value: addReactCubit,
              ),
              BlocProvider.value(
                value: addCommentCubit,
              ),
            ],
            child: PagesScreen(
              id: state.extra as int,
            ),
          );
        }),
  ];
}
