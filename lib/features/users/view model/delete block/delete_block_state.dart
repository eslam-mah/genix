part of 'delete_block_cubit.dart';

@immutable
sealed class DeleteBlockState {}

final class DeleteBlockInitial extends DeleteBlockState {}

final class DeleteBlockLoading extends DeleteBlockState {}

final class DeleteBlockSuccess extends DeleteBlockState {
  final String block;
  DeleteBlockSuccess({required this.block});
}

final class DeleteBlockError extends DeleteBlockState {}
