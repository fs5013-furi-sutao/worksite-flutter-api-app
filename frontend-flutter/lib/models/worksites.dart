class Worksites {
  int id;
  String name;
  String subName;
  String type;
  String staffName;
  String photo;
  String address;
  String status;
  String startAt;
  String endAt;

  Worksites(
      {this.id,
      this.name,
      this.subName,
      this.type,
      this.staffName,
      this.photo,
      this.address,
      this.status,
      this.startAt,
      this.endAt});

  factory Worksites.fromJson(Map<String, dynamic> json) {
    return Worksites(
      id: json['id'] as int,
      name: json['name'] as String,
      subName: json['subName'] as String,
      type: json['type'] as String,
      staffName: json['staffName'] as String,
      photo: json['photo'] as String,
      address: json['address'] as String,
      status: json['status'] as String,
      startAt: json['startAt'] as String,
      endAt: json['endAt'] as String,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $name, subName: $subName, type: $type, staffName: $staffName, address: $address, status: $status, startAt: $startAt , endAt: $endAt}';
  }
}
