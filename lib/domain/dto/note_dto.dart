class NoteDto {
  final String id;
  final String title;
  final String content;
  final DateTime date;

  NoteDto(
      {required this.id,
      required this.title,
      required this.content,
      required this.date});

  factory NoteDto.fromJson(Map<String, dynamic> json) {
    return NoteDto(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
    };
  }

  NoteDto copyWith({String? id, String? title, String? content, DateTime? date}) =>
      NoteDto(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        date: date ?? this.date,
      );
}
