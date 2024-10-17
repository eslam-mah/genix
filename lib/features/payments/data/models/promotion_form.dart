class PromotionForm {
  double amount;
  String? postId;

  PromotionForm({
    required this.amount,
    this.postId,
  });

  factory PromotionForm.fromJson(Map<String, dynamic> json) {
    return PromotionForm(
      amount: (json['amount'] ?? 0).toDouble(),
      postId: json['post_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = this.amount;
    if (this.postId != null) {
      data['post_id'] = this.postId;
    }
    return data;
  }
}
