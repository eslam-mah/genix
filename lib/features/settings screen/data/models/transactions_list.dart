import 'package:genix/features/settings%20screen/data/models/transactions_model.dart';

class TransactionsList {
  String status;
  Data data;

  TransactionsList({required this.status, required this.data});

  factory TransactionsList.fromJson(Map<String, dynamic> json) {
    return TransactionsList(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  List<TransactionsModel> transactions;

  Data({required this.transactions});

  factory Data.fromJson(Map<String, dynamic> json) {
    var transactionsJson = json['collection'] as List;
    List<TransactionsModel> transactionsList =
        transactionsJson.map((i) => TransactionsModel.fromJson(i)).toList();

    return Data(
      transactions: transactionsList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this
        .transactions
        .map((TransactionsModel) => TransactionsModel.toJson())
        .toList();
    return data;
  }

  void addUser({required TransactionsModel user}) {
    this.transactions.add(user);
  }

  void updateUser({required TransactionsModel newUser}) {
    final updatedUserIndex = this
        .transactions
        .first
        .collection
        .indexWhere((u) => u.id == newUser.collection.first.id);
    if (updatedUserIndex != -1) {
      this.transactions[updatedUserIndex] = newUser;
    }
  }

  void deleteUser(int userId) {
    final removedUserIndex =
        this.transactions.first.collection.indexWhere((u) => u.id == userId);
    if (removedUserIndex != -1) {
      this.transactions.removeAt(removedUserIndex);
    }
  }
}
