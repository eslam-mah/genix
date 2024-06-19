class SecurityForm {
  String? currentPassword;
  String? newPassword;

  SecurityForm({this.currentPassword, this.newPassword});

  SecurityForm.fromJson(Map<String, dynamic> json)
      : currentPassword = json['current_password'],
        newPassword = json['new_password'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['current_password'] = this.currentPassword;
    data['new_password'] = this.newPassword;
    return data;
  }
}
