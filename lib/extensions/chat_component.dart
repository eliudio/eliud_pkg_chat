import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_chat/extensions/widget/rooms.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_component.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/chat_repository.dart';
import 'package:flutter/cupertino.dart';

class ChatComponentConstructorDefault
    implements ComponentConstructor {

  @override
  Widget createNew({String? id, Map<String, dynamic>? parameters}) {
    return Chat(id: id);
  }
}

class Chat extends AbstractChatComponent {
  Chat({String? id}) : super(chatID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  ChatRepository getChatRepository(BuildContext context) {
    return chatRepository(appId: AccessBloc.appId(context))!;
  }

  @override
  Widget yourWidget(BuildContext context, ChatModel? value) {
    return const RoomsPage();
  }

}
