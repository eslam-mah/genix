class StripeForm {
  num amount;

  StripeForm({required this.amount});

  Map<String, dynamic> toJson() {
    return {'amount': amount};
  }
}
