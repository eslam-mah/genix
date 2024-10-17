import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/transactions_list.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'get_all_transactions_state.dart';

class GetAllTransactionsCubit extends Cubit<GetAllTransactionsState> {
  GetAllTransactionsCubit() : super(GetAllTransactionsInitial());
  final SettingRepository getAllTransactionsRepo = SettingRepository();
  Future<void> getAllTransactions() async {
    emit(GetAllTransactionsLoading());
    final result = await getAllTransactionsRepo.getAllTransactions();
    result.fold((l) => emit(GetAllTransactionsError()), (r) {
      final transactions = TransactionsList.fromJson(r as Map<String, dynamic>);
      emit(GetAllTransactionsSuccess(transactions: transactions));
    });
  }
}
