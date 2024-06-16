part of 'block_user_cubit.dart';

@immutable
sealed class BlockUserState {}

final class BlockUserInitial extends BlockUserState {}

final class BlockUserLoading extends BlockUserState {}

final class BlockUserSuccess extends BlockUserState {
  final UserModel blockedUser;
  BlockUserSuccess({required this.blockedUser});
}

final class BlockUserError extends BlockUserState {}
