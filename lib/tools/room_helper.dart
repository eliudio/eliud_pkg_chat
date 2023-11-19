import 'package:eliud_core_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';

import '../extensions/widgets/all_chats_bloc/all_chats_state.dart';

class RoomHelper {
  static List<String> getUniqueList(List<String> members) {
    Set<String> uniqueSet = {};
    uniqueSet.addAll(members);
    var uniqueList = uniqueSet.toList();
    uniqueList.sort();
    return uniqueList;
  }

  static String getRoomKey(String currentMemberId, List<String> members) {
    var uniqueList = getUniqueList([currentMemberId, ...members]);
    return uniqueList.join('+');
  }

  // todo: remove and replace with currentMemberId
  static String getChatMemberInfoId(String currentMemberId, String roomId) {
    return '$currentMemberId-$roomId';
  }

  static Future<RoomModel> getRoomForMembers(
      String appId, String currentMemberId, List<String> members) async {
    var roomId = RoomHelper.getRoomKey(currentMemberId, members);
    return await _storeRoom(appId, roomId, currentMemberId, members,
        'Chat between ${members.join(', ')}');
  }

  static Future<RoomModel> getRoomWithId(String appId, String roomId) async {
    var room = await roomRepository(appId: appId)!.get(roomId, onError: (_) {});
    if (room == null) {
      throw Exception('Room with id $roomId for app $appId not found');
    } else {
      return room;
    }
  }

  static Future<RoomModel> _storeRoom(String appId, String roomId,
      String ownerId, List<String> members, String descr) async {
    var uniqueMembers = getUniqueList(members);
    var roomModel =
        await roomRepository(appId: appId)!.get(roomId, onError: (_) {});
    if (roomModel == null) {
      roomModel = RoomModel(
        documentID: roomId,
        ownerId: ownerId,
        appId: appId,
        description: descr,
        isRoom: false,
        members: uniqueMembers,
      );
      await roomRepository(appId: appId)!.add(roomModel);
    }

    return roomModel;
  }

  static Future<List<OtherMemberRoomInfo>> getOtherMembersRoomInfo(
      String thisMemberId, String appId, List<String> memberIds) async {
    List<OtherMemberRoomInfo> otherMembersRoomInfo = [];
    for (var memberId in memberIds) {
      if (memberId != thisMemberId) {
        var member =
            await memberPublicInfoRepository(appId: appId)!.get(memberId);
        if (member != null) {
          var otherMemberRoomInfo = OtherMemberRoomInfo(
              memberId: member.documentID,
              name: (member.name != null && member.name!.isNotEmpty)
                  ? member.name!
                  : 'No name',
              avatar: member.photoURL);
          otherMembersRoomInfo.add(otherMemberRoomInfo);
        }
      }
    }
    return otherMembersRoomInfo;
  }
}
