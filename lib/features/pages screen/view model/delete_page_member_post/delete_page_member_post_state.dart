part of 'delete_page_member_post_cubit.dart';

sealed class DeletePageMemberPostState extends Equatable {
  const DeletePageMemberPostState();

  @override
  List<Object> get props => [];
}

final class DeletePageMemberPostInitial extends DeletePageMemberPostState {}

final class DeletePageMemberPostLoading extends DeletePageMemberPostState {}

final class DeletePageMemberPostSuccess extends DeletePageMemberPostState {
  final int id;

  const DeletePageMemberPostSuccess({required this.id});
}

final class DeletePageMemberPostError extends DeletePageMemberPostState {}
