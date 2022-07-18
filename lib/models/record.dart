class Record {
  int id;
  int value;
  String date;

  Record({required this.id, required this.value, required this.date});

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      value: json['distance'],
      date: json['updated_at'],
    );
  }
}
