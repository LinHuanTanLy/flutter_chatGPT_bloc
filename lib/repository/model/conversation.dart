class Conversation {
  String name;
  String description;
  String uuid;

  Conversation(
      {required this.name, required this.description, required this.uuid});

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
    };
  }
}
