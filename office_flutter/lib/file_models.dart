class File{
  int id;
  String title;
  String content;

  File({this.id, this.title, this.content});

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
  dynamic toJson() => {
    'id': id,
    'title': title,
    'content': content,
  };
}