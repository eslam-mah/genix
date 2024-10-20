class UpdatePageFollowerForm {
  RolesModel roles;
  List<PermissionsModel>? permissions;

  UpdatePageFollowerForm({
    required this.roles,
    this.permissions,
  });

  factory UpdatePageFollowerForm.fromJson(Map<String, dynamic> json) {
    return UpdatePageFollowerForm(
      roles: RolesModel.fromJson(json['roles']),
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
    data['roles'] = this.roles.toJson();
    if (this.permissions != null) {
      data['permissions'] =
          this.permissions!.map((item) => item.toJson()).toList();
    }
    return data;
  }
}

class PermissionsModel {
  String permissionName;
  String permissionDescription;

  PermissionsModel({
    required this.permissionName,
    required this.permissionDescription,
  });

  factory PermissionsModel.fromJson(Map<String, dynamic> json) {
    return PermissionsModel(
      permissionName: json['permission_name'],
      permissionDescription: json['permission_description'],
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
  String roleDescription;

  RolesModel({
    required this.roleName,
    required this.roleDescription,
  });

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(
      roleName: json['role_name'],
      roleDescription: json['role_description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role_name'] = this.roleName;
    data['role_description'] = this.roleDescription;
    return data;
  }
}
