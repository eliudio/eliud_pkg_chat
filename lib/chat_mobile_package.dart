import 'package:flutter/foundation.dart';

import 'chat_package.dart';

ChatPackage getChatPackage() => ChatMobilePackage();

class ChatMobilePackage extends ChatPackage {
  ChatMobilePackage();

  @override
  List<Object?> get props => [stateConditionMemberHasUnreadChat];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMobilePackage &&
          mapEquals(stateConditionMemberHasUnreadChat,
              other.stateConditionMemberHasUnreadChat) &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => stateConditionMemberHasUnreadChat.hashCode;
}
