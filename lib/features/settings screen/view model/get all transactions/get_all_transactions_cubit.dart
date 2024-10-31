import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/transactions_list.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'get_all_transactions_state.dart';

class GetAllTransactionsCubit extends Cubit<GetAllTransactionsState> {
  GetAllTransactionsCubit() : super(GetAllTransactionsInitial());
  final SettingRepository getAllTransactionsRepo = SettingRepository();
  Future<void> getAllTransactions({required int page}) async {
    emit(GetAllTransactionsLoading());
    final result = await getAllTransactionsRepo.getAllTransactions(page: page);
    result.fold((l) => emit(GetAllTransactionsError()), (r) {
      final transactions = TransactionList.fromJson(r as Map<String, dynamic>);
      emit(GetAllTransactionsSuccess(transactions: transactions));
    });
  }

  Future<void> getTransactionsByName(
      {required int page, required String query}) async {
    emit(GetAllTransactionsLoading());
    final result = await getAllTransactionsRepo.getTransactionsByName(
        page: page, query: query);
    result.fold((l) => emit(GetAllTransactionsError()), (r) {
      final transactions = TransactionList.fromJson(r as Map<String, dynamic>);
      emit(GetAllTransactionsSuccess(transactions: transactions));
    });
  }

  Future<void> getTransactionsById(
      {required int page, required String query}) async {
    emit(GetAllTransactionsLoading());
    final result = await getAllTransactionsRepo.getTransactionsById(
        page: page, query: query);
    result.fold((l) => emit(GetAllTransactionsError()), (r) {
      final transactions = TransactionList.fromJson(r as Map<String, dynamic>);
      emit(GetAllTransactionsSuccess(transactions: transactions));
    });
  }
}
