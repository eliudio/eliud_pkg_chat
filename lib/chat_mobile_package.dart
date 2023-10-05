
import 'package:flutter/foundation.dart';

import 'chat_package.dart';

ChatPackage getChatPackage() => ChatMobilePackage();

class ChatMobilePackage extends ChatPackage {

  ChatMobilePackage() {
  }

  @override
  void init() {
    super.init();
  }

  @override
  List<Object?> get props => [state_CONDITION_MEMBER_HAS_UNREAD_CHAT];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is ChatMobilePackage &&
              mapEquals(state_CONDITION_MEMBER_HAS_UNREAD_CHAT, other.state_CONDITION_MEMBER_HAS_UNREAD_CHAT) &&
              runtimeType == other.runtimeType;
}

