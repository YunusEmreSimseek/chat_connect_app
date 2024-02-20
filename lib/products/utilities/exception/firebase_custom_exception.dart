class FirebaseCustomException implements Exception {
  FirebaseCustomException({required this.description});

  final String description;

  @override
  String toString() {
    return '$this $description';
  }
}

class VersionCustomException implements Exception {
  VersionCustomException({required this.description});

  final String description;

  @override
  String toString() {
    return '$this $description';
  }
}
