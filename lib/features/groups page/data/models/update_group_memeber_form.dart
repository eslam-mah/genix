class UpdateGroupMemberForm {
  List<RolesModel>? roles;
  List<PermissionsModel>? permissions;

  UpdateGroupMemberForm({
    this.roles,
    this.permissions,
  });

  factory UpdateGroupMemberForm.fromJson(Map<String, dynamic> json) {
    return UpdateGroupMemberForm(
      roles: json['roles'] != null
          ? (json['roles'] as List<dynamic>)
              .map((item) => RolesModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      permissions: json['permissions'] != null
          ? (json['permissions'] as List<dynamic>)
              .map((item) =>
                  PermissionsModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.roles != null) {
      data['roles'] = this.roles!.map((item) => item.toJson()).toList();
    }
    if (this.permissions != null) {
      data['permissions'] =
          this.permissions!.map((item) => item.toJson()).toList();
    }
    return data;
  }
}

class PermissionsModel {
  String permissionName;
  String? permissionDescription;

  PermissionsModel({
    required this.permissionName,
    this.permissionDescription,
  });

  factory PermissionsModel.fromJson(Map<String, dynamic> json) {
    return PermissionsModel(
      permissionName: json['permission_name'] as String,
      permissionDescription: json['permission_description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['permission_name'] = this.permissionName;
    data['permission_description'] = this.permissionDescription;
    return data;
  }
}

class RolesModel {
  String roleName;
  String? roleDescription;

  RolesModel({
    required this.roleName,
    this.roleDescription,
  });

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(
      roleName: json['role_name'] as String,
      roleDescription: json['role_description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role_name'] = this.roleName;
    data['role_description'] = this.roleDescription;
    return data;
  }
}
