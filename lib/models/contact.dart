class Contact {
  final String id;
  final String name;
  final String phone;
  final String relationship;
  final bool isTracking;
  final bool isEmergencyContact;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.relationship,
    this.isTracking = false,
    this.isEmergencyContact = false,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      relationship: json['relationship'],
      isTracking: json['isTracking'] ?? false,
      isEmergencyContact: json['isEmergencyContact'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'relationship': relationship,
      'isTracking': isTracking,
      'isEmergencyContact': isEmergencyContact,
    };
  }
}

