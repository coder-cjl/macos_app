class TextModel {
  String? content;
  SendType? sendType;

  TextModel({
    this.sendType,
    this.content,
  });
}

enum SendType {
  me,
  other,
}
