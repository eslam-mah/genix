part of 'remove_follow_page_cubit.dart';

sealed class RemoveFollowPageState extends Equatable {
  const RemoveFollowPageState();

  @override
  List<Object> get props => [];
}

final class RemoveFollowPageInitial extends RemoveFollowPageState {}

final class RemoveFollowPageLoading extends RemoveFollowPageState {}

final class RemoveFollowPageSuccess extends RemoveFollowPageState {
  final int id;
  const RemoveFollowPageSuccess({required this.id});
}

final class RemoveFollowPageError extends RemoveFollowPageState {}
