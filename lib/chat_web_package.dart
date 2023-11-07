import 'package:flutter/foundation.dart';

import 'chat_package.dart';

ChatPackage getChatPackage() => ChatWebPackage();

class ChatWebPackage extends ChatPackage {
  @override
  List<Object?> get props => [stateConditionMemberHasUnreadChat];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatWebPackage &&
          mapEquals(stateConditionMemberHasUnreadChat,
              other.stateConditionMemberHasUnreadChat) &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => stateConditionMemberHasUnreadChat.hashCode;
}
