import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'chat_dashboard_event.dart';
import 'chat_dashboard_state.dart';

class ChatDashboardBloc extends Bloc<ChatDashboardEvent, ChatDashboardState> {
  final String appId;

  ChatDashboardBloc(this.appId) : super(ChatDashboardStateUninitialized());

  @override
  Stream<ChatDashboardState> mapEventToState(ChatDashboardEvent event) async* {
    if (event is OpenUnreadWidgetEvent) {
      yield UnreadWidgetState();
    } else if (event is OpenMemberRoomsWidgetEvent) {
      yield MemberRoomsWidgetState();
    } else if (event is OpenRealRoomFormsWidgetEvent) {
      yield RealRoomFormsWidgetState();
    } else if (event is OpenExistingMemberRoomsWidgetEvent) {
      yield ExistingMemberRoomsWidgetState();
    } else if (event is OpenExistingRealRoomsWidgetEvent) {
      yield ExistingRealRoomsWidgetState();
    } else if (event is CreateChatWithMemberEvent) {
      // check if room with this member exists, create it if needed, then open the chat with this room
      // fillChat(appId, event.currentMemberId, event.otherMemberId);
      var room = await getRoomForMember(appId, event.currentMemberId, event.otherMemberId);
      yield ChatWidgetState(room);
    }
  }

  Future<RoomModel> getRoomForMember(String appId, String currentMemberId, String otherMemberId) async {
    var roomId = (currentMemberId.compareTo(otherMemberId) < 0)
        ? currentMemberId + '-' + otherMemberId
        : otherMemberId + '-' + currentMemberId;
    var roomModel =
        await roomRepository(appId: appId)!.get(roomId, onError: (_) {});
    roomModel ??= RoomModel(
        documentID: roomId,
        ownerId: currentMemberId,
        appId: appId,
        description:
        'Chat between ' + currentMemberId + ' and ' + otherMemberId,
        isRoom: false,
        members: [
          currentMemberId,
          otherMemberId,
        ],
      );
    return roomModel;
  }

  void fillChat(String appId, String currentMemberId, String otherMemberId) {
    var roomId = (currentMemberId.compareTo(otherMemberId) < 0)
        ? currentMemberId + '-' + otherMemberId
        : otherMemberId + '-' + currentMemberId;
    var _chatRepository = chatRepository(appId: appId!, roomId: roomId);
    if (_chatRepository != null) {
      for (var i = 0; i < 1000; i++) {
        var chatModel = ChatModel(
          documentID: newRandomKey(),
          roomId: roomId,
          authorId: currentMemberId,
          appId: appId,
          saying: i.toString() + ' hello ' + i.toString(),
          readAccess: [
            currentMemberId,
            otherMemberId,
          ],
        );

        // add entry to chat
        _chatRepository!.add(chatModel);
      }
    }
  }
}
