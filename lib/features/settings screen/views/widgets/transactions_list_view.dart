import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/features/settings%20screen/data/models/transactions_model.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20all%20transactions/get_all_transactions_cubit.dart';
import 'package:genix/features/settings%20screen/views/widgets/transaction_history_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionsListView extends StatefulWidget {
  const TransactionsListView({
    super.key,
    required this.isNightModeEnabled,
    required this.searchType,
    required this.query,
  });

  final String searchType;
  final String query;
  final bool isNightModeEnabled;

  @override
  State<TransactionsListView> createState() => _TransactionsListViewState();
}

class _TransactionsListViewState extends State<TransactionsListView> {
  final PagingController<int, TransactionModel> _pagingController =
      PagingController(firstPageKey: 1);
  late GetAllTransactionsCubit getAllTransactionsCubit;

  @override
  void initState() {
    super.initState();
    getAllTransactionsCubit = BlocProvider.of<GetAllTransactionsCubit>(context);

    _pagingController
        .addPageRequestListener((page) => _fetchTransactions(page));
  }

  @override
  void didUpdateWidget(covariant TransactionsListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchType != widget.searchType ||
        oldWidget.query != widget.query) {
      // Clear the paging controller and fetch with new search parameters
      _pagingController.refresh();
    }
  }

  void _fetchTransactions(int page) {
    switch (widget.searchType) {
      case 'all transactions':
        getAllTransactionsCubit.getAllTransactions(page: page);
        break;
      case 'transactions name':
        getAllTransactionsCubit.getTransactionsByName(
            page: page, query: widget.query);
        break;
      case 'transactions id':
        getAllTransactionsCubit.getTransactionsById(
            page: page, query: widget.query);
        break;
    }
  }

  Future<void> _fetchPage(List<TransactionModel> items) async {
    try {
      final newItems = items;
      final isLastPage = newItems.length < 25;

      if (_pagingController.itemList == null) {
        _pagingController.itemList = [];
      } else if (_pagingController.itemList != null &&
          _pagingController.firstPageKey == 1) {
        _pagingController.itemList!.clear();
      }

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _pagingController.appendPage(newItems, _pagingController.nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Widget _transactionsPaginationList() {
    return PagedListView<int, TransactionModel>(
      padding: EdgeInsets.zero,
      pagingController: _pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<TransactionModel>(
        animateTransitions: true,
        firstPageErrorIndicatorBuilder: (_) => FirstPageErrorIndicator(
          onTryAgain: () => _pagingController.refresh(),
        ),
        firstPageProgressIndicatorBuilder: (_) => const Center(
          child: CircularProgressIndicator(
            color: AppColors.kPrimaryColor,
          ),
        ),
        newPageProgressIndicatorBuilder: (_) =>
            const NewPageProgressIndicator(),
        noItemsFoundIndicatorBuilder: (_) => const NoItemsFoundIndicator(),
        itemBuilder: (context, item, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: TransactionHistoryCard(
              isNightMode: widget.isNightModeEnabled,
              transactionsModel: item,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetAllTransactionsCubit, GetAllTransactionsState>(
      listener: (context, state) {
        if (state is GetAllTransactionsSuccess) {
          _fetchPage(state.transactions.data.collection);
        }
      },
      child: Column(
        children: [_transactionsPaginationList()],
      ),
    );
  }
}
