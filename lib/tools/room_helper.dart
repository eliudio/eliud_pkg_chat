import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';

class RoomHelper {
  static String getRoomKey(String currentMemberId, String otherMemberId) {
    var roomId = (currentMemberId.compareTo(otherMemberId) < 0)
        ? currentMemberId + '-' + otherMemberId
        : otherMemberId + '-' + currentMemberId;
    return roomId;
  }

  // todo: remove and replace with currentMemberId
  static String getChatMemberInfoId(String currentMemberId, String roomId) {
    return currentMemberId + '-' + roomId;
  }

  static Future<RoomModel> getRoomForMembers(
      AppModel app, String currentMemberId, List<String> members) async {
    var roomId = newRandomKey();
    return _storeRoom(app, roomId, currentMemberId, members, 'Chat amongst ' + members.join(", "));
  }

  static Future<RoomModel> getRoomForMember(
      AppModel app, String currentMemberId, String otherMemberId) async {
    var roomId = RoomHelper.getRoomKey(currentMemberId, otherMemberId);
    return _storeRoom(app, roomId, currentMemberId, [
      currentMemberId,
      otherMemberId,
    ], 'Chat between ' + currentMemberId + ' and ' + otherMemberId);
  }

  static Future<RoomModel> _storeRoom(AppModel app, String roomId, String ownerId, List<String> members, String descr) async {
    var roomModel = await roomRepository(appId: app.documentID!)!.get(roomId, onError: (_) {});
    if (roomModel == null) {
      roomModel = RoomModel(
        documentID: roomId,
        ownerId: ownerId,
        appId: app.documentID!,
        description: descr,
        isRoom: false,
        members: members,
      );
      await roomRepository(appId: app.documentID!)!.add(roomModel);
    }
    return roomModel;
  }


}