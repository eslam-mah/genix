class Pagination {
  int? currentPage;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  Pagination({
    this.currentPage,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  Pagination.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'] as int?,
        from = json['from'] as int?,
        lastPage = json['last_page'] as int?,
        perPage = json['per_page'] as int?,
        to = json['to'] as int?,
        total = json['total'] as int?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}
