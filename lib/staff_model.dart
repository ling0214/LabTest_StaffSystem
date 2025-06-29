class Staff {
  final String? id; // Firestore document ID
  final String name;
  final String staffId;
  final int age;

  Staff({
    this.id,
    required this.name,
    required this.staffId,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'staffId': staffId,
      'age': age,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map, String docId) {
    return Staff(
      id: docId,
      name: map['name'],
      staffId: map['staffId'],
      age: map['age'],
    );
  }
}
