class TextFieldItem {
  final String value;
  final String content;
  final int id;

  TextFieldItem({
    required this.value,
    required this.content,
    required this.id,
  });

  @override
  bool operator ==(Object other) =>
      other is TextFieldItem &&
      other.id == id &&
      other.value == value &&
      other.content == content;

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ content.hashCode;
}
