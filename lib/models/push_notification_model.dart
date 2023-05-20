import 'dart:convert';

class PushNotificationModel {
  String? title;
  String? body;
  String? email;
  PushNotificationModel({
    this.title,
    this.body,
    this.email,
  });

  PushNotificationModel copyWith({
    String? title,
    String? body,
  }) {
    return PushNotificationModel(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
    };
  }

  factory PushNotificationModel.fromMap(Map<String, dynamic> map) {
    return PushNotificationModel(
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PushNotificationModel.fromJson(String source) =>
      PushNotificationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PushNotificationModel(title: $title, body: $body)';

  @override
  bool operator ==(covariant PushNotificationModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.body == body;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode;
}
