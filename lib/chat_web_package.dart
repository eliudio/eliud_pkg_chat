import 'chat_package.dart';

class ChatWebPackage extends ChatPackage {
  @override
  void init() {
    super.init();
  }

  @override
  List<Object?> get props => [
  ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is ChatWebPackage &&
              runtimeType == other.runtimeType;
}
