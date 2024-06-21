import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';

class TicketsList {
  String status;
  Data data;

  TicketsList({required this.status, required this.data});

  factory TicketsList.fromJson(Map<String, dynamic> json) {
    return TicketsList(
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
  List<TicketsModel> tickets;

  Data({required this.tickets});

  factory Data.fromJson(Map<String, dynamic> json) {
    var ticketsJson = json['collection'] as List;
    List<TicketsModel> ticketsList =
        ticketsJson.map((i) => TicketsModel.fromJson(i)).toList();

    return Data(
      tickets: ticketsList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] =
        this.tickets.map((TicketsModel) => TicketsModel.toJson()).toList();
    return data;
  }

  void addUser({required TicketsModel ticket}) {
    this.tickets.add(ticket);
  }

  void updateUser({required TicketsModel newTicket}) {
    final updatedUserIndex = this.tickets.indexWhere((ticket) {
      return ticket.collection
          .any((collection) => collection.id == newTicket.collection.first.id);
    });

    if (updatedUserIndex != -1) {
      this.tickets[updatedUserIndex] = newTicket;
    }
  }

  void deleteUser(int ticketId) {
    final removedTicketIndex = this.tickets.indexWhere((ticket) {
      return ticket.collection.any((collection) => collection.id == ticketId);
    });

    if (removedTicketIndex != -1) {
      this.tickets.removeAt(removedTicketIndex);
    }
  }
}
