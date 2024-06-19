part of 'block_user_cubit.dart';

@immutable
sealed class BlockUserState extends Equatable {
  const BlockUserState();

  @override
  List<Object> get props => [];
}

final class BlockUserInitial extends BlockUserState {}

final class BlockUserLoading extends BlockUserState {}

final class BlockUserSuccess extends BlockUserState {
  final UserModel blockedUser;
  const BlockUserSuccess({required this.blockedUser});
}

final class BlockUserError extends BlockUserState {}
