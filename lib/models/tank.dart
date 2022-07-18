class Tank {
  final int distance;

  const Tank({
    required this.distance,
  });

  factory Tank.fromJson(Map<String, dynamic> json) {
    return Tank(
      distance: json['distance'],
    );
  }
}
