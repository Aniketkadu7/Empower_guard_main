class Complaint {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final double latitude;
  final double longitude;
  final String status;
  final List<String>? images;

  Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.status,
    this.images,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'images': images,
    };
  }
}

