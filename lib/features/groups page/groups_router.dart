import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/view%20model/create_group_cubit/create_group_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/delete_group/delete_group_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/delete_group_member/delete_group_member_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/delete_group_member_comment/delete_group_member_comment_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/delete_group_member_post/delete_group_member_post_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/get_all_groups/get_all_groups_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/get_group_by_id/get_group_by_id_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/get_group_members/get_group_members_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/get_group_photos/get_group_photos_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/join_group_cubit/join_group_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/post_group_invitation/post_group_invitation_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/post_group_rating/post_group_rating_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/remove_join_group/remove_join_group_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/update_group_details/update_group_details_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/update_group_invitation/update_group_invitation_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/update_group_member/update_group_member_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/update_group_profile/update_group_profile_cubit.dart';
import 'package:genix/features/groups%20page/views/screens/groups_list_body.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class GroupsRouter {
  static final createGroupCubit = CreateGroupCubit();
  static final deleteGroupCubit = DeleteGroupCubit();
  static final deleteGroupMemberCubit = DeleteGroupMemberCubit();
  static final deleteGroupMemberCommentCubit = DeleteGroupMemberCommentCubit();
  static final deleteGroupMemberPostCubit = DeleteGroupMemberPostCubit();
  static final getAllGroupsCubit = GetAllGroupsCubit();
  static final getGroupByIdCubit = GetGroupByIdCubit();
  static final getGroupMembersCubit = GetGroupMembersCubit();
  static final getGroupPhotosCubit = GetGroupPhotosCubit();
  static final joinGroupCubit = JoinGroupCubit();
  static final postGroupInvitationCubit = PostGroupInvitationCubit();
  static final postGroupRatingCubit = PostGroupRatingCubit();
  static final removeJoinGroupCubit = RemoveJoinGroupCubit();
  static final updateGroupDetailsCubit = UpdateGroupDetailsCubit();
  static final updateGroupInvitationCubit = UpdateGroupInvitationCubit();
  static final updateGroupMemberCubit = UpdateGroupMemberCubit();
  static final updateGroupProfileCubit = UpdateGroupProfileCubit();
  static final getAccountDetails = GetMyAccountDetailsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: GroupsListBody.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: createGroupCubit,
              ),
              BlocProvider.value(
                value: deleteGroupCubit,
              ),
              BlocProvider.value(
                value: getAccountDetails,
              ),
              BlocProvider.value(
                value: deleteGroupMemberCubit,
              ),
              BlocProvider.value(
                value: deleteGroupMemberCommentCubit,
              ),
              BlocProvider.value(
                value: deleteGroupMemberCommentCubit,
              ),
              BlocProvider.value(
                value: getAllGroupsCubit,
              ),
              BlocProvider.value(
                value: getGroupByIdCubit,
              ),
              BlocProvider.value(
                value: getGroupMembersCubit,
              ),
              BlocProvider.value(
                value: getGroupPhotosCubit,
              ),
              BlocProvider.value(
                value: joinGroupCubit,
              ),
              BlocProvider.value(
                value: postGroupInvitationCubit,
              ),
              BlocProvider.value(
                value: postGroupRatingCubit,
              ),
              BlocProvider.value(
                value: removeJoinGroupCubit,
              ),
              BlocProvider.value(
                value: updateGroupDetailsCubit,
              ),
              BlocProvider.value(
                value: updateGroupInvitationCubit,
              ),
              BlocProvider.value(
                value: updateGroupMemberCubit,
              ),
              BlocProvider.value(
                value: updateGroupProfileCubit,
              ),
            ],
            child: const GroupsListBody(),
          );
        }),
  ];
}
