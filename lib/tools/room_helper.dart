import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';

import '../extensions/widgets/all_chats_bloc/all_chats_state.dart';

class RoomHelper {
  static String getRoomKey(String currentMemberId, String otherMemberId) {
    var roomId = (currentMemberId.compareTo(otherMemberId) < 0)
        ? '$currentMemberId-$otherMemberId'
        : '$otherMemberId-$currentMemberId';
    return roomId;
  }

  // todo: remove and replace with currentMemberId
  static String getChatMemberInfoId(String currentMemberId, String roomId) {
    return '$currentMemberId-$roomId';
  }

  static Future<RoomModel> getRoomForMembers(
      String appId, String currentMemberId, List<String> members) async {

    List<String> reviewedListOfMembers = [];
    for (var member in members) {
      if (member != currentMemberId) {
        reviewedListOfMembers.add(member);
      }
    }

    if (reviewedListOfMembers.length == 1) {
      return getRoomForMember(appId, currentMemberId, members[0]);
    } else {
      var roomId = newRandomKey();
      return _storeRoom(appId, roomId, currentMemberId, reviewedListOfMembers,
          'Chat amongst ${reviewedListOfMembers.join(", ")}');
    }
  }

  static Future<RoomModel> getRoomForMember(
      String appId, String currentMemberId, String otherMemberId) async {
    var roomId = RoomHelper.getRoomKey(currentMemberId, otherMemberId);
    return _storeRoom(appId, roomId, currentMemberId, [
      currentMemberId,
      otherMemberId,
    ], 'Chat between $currentMemberId and $otherMemberId');
  }

  static Future<RoomModel> _storeRoom(String appId, String roomId, String ownerId, List<String> members, String descr) async {
    var roomModel = await roomRepository(appId: appId)!.get(roomId, onError: (_) {});
    if (roomModel == null) {
      roomModel = RoomModel(
        documentID: roomId,
        ownerId: ownerId,
        appId: appId,
        description: descr,
        isRoom: false,
        members: members,
      );
      await roomRepository(appId: appId)!.add(roomModel);
    }
    return roomModel;
  }

  static Future<List<OtherMemberRoomInfo>> getOtherMembersRoomInfo(String thisMemberId,
      String appId, List<String> memberIds) async {
    List<OtherMemberRoomInfo> otherMembersRoomInfo = [];
    for (var memberId in memberIds) {
      if (memberId != thisMemberId) {
        var member =
        await memberPublicInfoRepository(appId: appId)!.get(memberId);
        if (member != null) {
          var otherMemberRoomInfo = OtherMemberRoomInfo(
              memberId: member.documentID,
              name: member.name != null ? member.name! : 'No name',
              avatar: member.photoURL);
          otherMembersRoomInfo.add(otherMemberRoomInfo);
        }
      }
    }
    return otherMembersRoomInfo;
  }

}