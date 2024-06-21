part of 'remove_lock_cubit.dart';

sealed class RemoveLockState extends Equatable {
  const RemoveLockState();

  @override
  List<Object> get props => [];
}

final class RemoveLockInitial extends RemoveLockState {}

final class RemoveLockLoading extends RemoveLockState {}

final class RemoveLockSuccess extends RemoveLockState {
  final String lock;
  const RemoveLockSuccess({required this.lock});
}

final class RemoveLockError extends RemoveLockState {}
