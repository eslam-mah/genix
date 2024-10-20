part of 'delete_page_member_cubit.dart';

sealed class DeletePageMemberState extends Equatable {
  const DeletePageMemberState();

  @override
  List<Object> get props => [];
}

final class DeletePageMemberInitial extends DeletePageMemberState {}

final class DeletePageMemberLoading extends DeletePageMemberState {}

final class DeletePageMemberSuccess extends DeletePageMemberState {
  final int id;

  const DeletePageMemberSuccess({required this.id});
}

final class DeletePageMemberError extends DeletePageMemberState {}
