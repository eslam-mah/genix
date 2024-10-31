part of 'get_lock_cubit.dart';

sealed class GetLockState extends Equatable {
  const GetLockState();

  @override
  List<Object> get props => [];
}

final class GetLockInitial extends GetLockState {}

final class GetLockLoading extends GetLockState {}

final class GetLockSuccess extends GetLockState {
  final LockModel data;
  const GetLockSuccess({required this.data});
}

final class GetLockError extends GetLockState {}
