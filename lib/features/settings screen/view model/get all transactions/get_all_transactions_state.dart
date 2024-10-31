part of 'get_all_transactions_cubit.dart';

sealed class GetAllTransactionsState extends Equatable {
  const GetAllTransactionsState();

  @override
  List<Object> get props => [];
}

final class GetAllTransactionsInitial extends GetAllTransactionsState {}

final class GetAllTransactionsLoading extends GetAllTransactionsState {}

final class GetAllTransactionsSuccess extends GetAllTransactionsState {
  final TransactionList transactions;
  const GetAllTransactionsSuccess({required this.transactions});
}

final class GetAllTransactionsError extends GetAllTransactionsState {}
