enum CallType {
  audio("audio"),
  video("video");

  final String value;
  const CallType(this.value);
}

enum ReceiverType {
  user("user"),
  group("group");

  final String value;
  const ReceiverType(this.value);
}
