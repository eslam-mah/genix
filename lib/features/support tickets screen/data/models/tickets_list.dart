import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';

class SupportTicketsList {
  bool success;
  TicketData data;
  String? message;

  SupportTicketsList({
    required this.success,
    required this.data,
    this.message,
  });

  factory SupportTicketsList.fromJson(Map<String, dynamic> json) {
    return SupportTicketsList(
      success: json['success'],
      data: TicketData.fromJson(json['data']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['data'] = this.data.toJson();
    data['message'] = this.message;
    return data;
  }
}

class TicketData {
  List<TicketsModel> collection;

  int totalCount;
  int openCount;
  int solvedCount;

  TicketData({
    required this.collection,
    required this.totalCount,
    required this.openCount,
    required this.solvedCount,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) {
    return TicketData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => TicketsModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'],
      openCount: json['openCount'],
      solvedCount: json['solvedCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();

    data['totalCount'] = this.totalCount;
    data['openCount'] = this.openCount;
    data['solvedCount'] = this.solvedCount;
    return data;
  }
}
