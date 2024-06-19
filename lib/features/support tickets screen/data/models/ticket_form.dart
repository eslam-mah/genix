class TicketForm {
  String title;
  String content;

  TicketForm({required this.title, required this.content});

  TicketForm.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
