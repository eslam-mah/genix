part of 'delete_block_cubit.dart';

@immutable
sealed class DeleteBlockState extends Equatable {
  const DeleteBlockState();

  @override
  List<Object> get props => [];
}

final class DeleteBlockInitial extends DeleteBlockState {}

final class DeleteBlockLoading extends DeleteBlockState {}

final class DeleteBlockSuccess extends DeleteBlockState {
  final String block;
  const DeleteBlockSuccess({required this.block});
}

final class DeleteBlockError extends DeleteBlockState {}
