import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String appId;

  ChatBloc(this.appId) : super(ChatStateUninitialized());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
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

  void stuffIVeTested() async {
    // to be passed in:
    var appId = "MINKEY_APP";
    var otherMemberId = '';
    var currentMemberId = '';

    var roomId = (currentMemberId.compareTo(otherMemberId) < 0)
        ? currentMemberId + '-' + otherMemberId
        : otherMemberId + '-' + currentMemberId;
    var roomModel =
    await roomRepository(appId: appId)!.get(roomId, onError: (_) {});
    if (roomModel == null) {
      roomModel = RoomModel(
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
      roomRepository(appId: appId!)!.add(roomModel);
    }

    var _chatRepository = chatRepository(appId: appId!, roomId: roomId);
    if (_chatRepository != null) {
      var chatModel = ChatModel(
        documentID: newRandomKey(),
        roomId: roomId,
        authorId: currentMemberId,
        appId: appId,
        saying: 'hello',
        readAccess: [
          currentMemberId,
          otherMemberId,
        ],
      );

      // retrieve entry from chat
      var value2 = await _chatRepository!.get(
          '1c5322b4-0ff0-412b-a58e-9c4e5153acad');

      // add entry to chat
      _chatRepository!.add(chatModel);

      var _chatMemberInfoRepository = chatMemberInfoRepository(
          appId: appId!, roomId: roomId);
      if (_chatMemberInfoRepository != null) {
        var chatMemberInfo = ChatMemberInfoModel(
            documentID: newRandomKey(),
            memberId: currentMemberId,
            roomId: roomId,
            timestamp: value2!.timestamp
        );
      }
    }
  }
}
