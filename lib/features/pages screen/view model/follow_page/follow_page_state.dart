part of 'follow_page_cubit.dart';

sealed class FollowPageState extends Equatable {
  const FollowPageState();

  @override
  List<Object> get props => [];
}

final class FollowPageInitial extends FollowPageState {}

final class FollowPageLoading extends FollowPageState {}

final class FollowPageSuccess extends FollowPageState {
  final String message;
  const FollowPageSuccess({required this.message});
}

final class FollowPageError extends FollowPageState {}
