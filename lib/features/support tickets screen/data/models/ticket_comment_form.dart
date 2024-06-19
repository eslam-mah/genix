class TicketCommentForm {
  String content;

  TicketCommentForm({required this.content});

  TicketCommentForm.fromJson(Map<String, dynamic> json)
      : content = json['content'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['content'] = this.content;
    return data;
  }
}
