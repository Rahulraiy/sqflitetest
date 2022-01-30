import 'dart:convert';

class Item {
  int id;
  String title;


  Item({
    required this.id,
    required this.title,
  });

  Item copyWith({
    int? id,
    String? title,

  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,

    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(id: $id, name: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.id == id &&
        other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    title.hashCode;
  }
}
