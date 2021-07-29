class RoomHelper {
  static String getRoomKey(String currentMemberId, String otherMemberId) {
    var roomId = (currentMemberId.compareTo(otherMemberId) < 0)
        ? currentMemberId + '-' + otherMemberId
        : otherMemberId + '-' + currentMemberId;
    return roomId;
  }

  static String getChatMemberInfoId(String currentMemberId, String roomId) {
    return currentMemberId + '-' + roomId;
  }
}