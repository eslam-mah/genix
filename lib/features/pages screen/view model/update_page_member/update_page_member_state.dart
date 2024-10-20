part of 'update_page_member_cubit.dart';

sealed class UpdatePageMemberState extends Equatable {
  const UpdatePageMemberState();

  @override
  List<Object> get props => [];
}

final class UpdatePageMemberInitial extends UpdatePageMemberState {}

final class UpdatePageMemberLoading extends UpdatePageMemberState {}

final class UpdatePageMemberSuccess extends UpdatePageMemberState {
  final UpdatePageFollowerForm follower;

  const UpdatePageMemberSuccess({required this.follower});
}

final class UpdatePageMemberError extends UpdatePageMemberState {}
