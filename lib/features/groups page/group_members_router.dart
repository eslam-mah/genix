import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/models/group_profile_model/group_profile_model.dart';
import 'package:genix/features/groups%20page/view%20model/delete_group_member/delete_group_member_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/delete_group_member_comment/delete_group_member_comment_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/delete_group_member_post/delete_group_member_post_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/get_group_members/get_group_members_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/post_group_invitation/post_group_invitation_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/update_group_invitation/update_group_invitation_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/update_group_member/update_group_member_cubit.dart';
import 'package:genix/features/groups%20page/views/screens/group_members_screen.dart';
import 'package:go_router/go_router.dart';

abstract class GroupMembersRouter {
  static final deleteGroupMemberCubit = DeleteGroupMemberCubit();
  static final deleteGroupMemberCommentCubit = DeleteGroupMemberCommentCubit();
  static final deleteGroupMemberPostCubit = DeleteGroupMemberPostCubit();
  static final getGroupMembersCubit = GetGroupMembersCubit();
  static final postGroupInvitationCubit = PostGroupInvitationCubit();

  static final updateGroupInvitationCubit = UpdateGroupInvitationCubit();
  static final updateGroupMemberCubit = UpdateGroupMemberCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: GroupMembersScreen.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
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
                value: getGroupMembersCubit,
              ),
              BlocProvider.value(
                value: postGroupInvitationCubit,
              ),
              BlocProvider.value(
                value: updateGroupInvitationCubit,
              ),
              BlocProvider.value(
                value: updateGroupMemberCubit,
              ),
            ],
            child: GroupMembersScreen(
              group: state.extra as GroupProfileModel,
            ),
          );
        }),
  ];
}
