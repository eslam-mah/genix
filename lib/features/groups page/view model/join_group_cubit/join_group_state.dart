part of 'join_group_cubit.dart';

sealed class JoinGroupState extends Equatable {
  const JoinGroupState();

  @override
  List<Object> get props => [];
}

final class JoinGroupInitial extends JoinGroupState {}

final class JoinGroupLoading extends JoinGroupState {}

final class JoinGroupSuccess extends JoinGroupState {
  final String message;

  const JoinGroupSuccess(this.message);
}

final class JoinGroupError extends JoinGroupState {}
