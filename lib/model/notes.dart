class Notes {
  final int id;
  final String title;
  final String body;

  Notes({
    required this.id,
    required this.body,
    required this.title,
  });

  factory Notes.json(Map<String, dynamic> json) {
    return Notes(
      body: json["body"],
      title: json["title"],
      id: json["id"],
    );
  }
  Notes copyWith({String? title, String? body}) {
    return Notes(
        id: id, 
        body: body ??
            this.body, 
        title: title ?? this.title);
  }
}
