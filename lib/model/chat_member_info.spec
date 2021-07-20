{
  "id": "ChatMemberInfo",
  "packageName": "eliud_pkg_chat",
  "isAppModel": true,
  "generate": {
    "generateComponent": true,
    "generateRepository": true,
    "generateCache": true,
    "hasPersistentRepository": true,
    "generateFirestoreRepository": true,
    "generateRepositorySingleton": true,
    "generateModel": true,
    "generateEntity": true,
    "generateForm": true,
    "generateList": true,
    "generateDropDownButton": true,
    "generateInternalComponent": true,
    "generateEmbeddedComponent": false,
    "isExtension": false,
    "documentSubCollectionOf": "room"
  },
  "memberIdentifier": "memberId",
  "fields": [
    {
      "fieldName": "documentID",
      "displayName": "Document ID",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "memberId",
      "displayName": "Member ID",
      "fieldType": "String",
      "group": "member"
    },
    {
      "fieldName": "roomId",
      "displayName": "Chat ID",
      "fieldType": "String",
      "group": "chat"
    },
    {
      "fieldName": "timestamp",
      "displayName": "Last Read Timestamp",
      "remark": "Last Read entry in Chat in this room Timestamp",
      "fieldType": "ServerTimestampUninitialized",
      "group": "general"
    }
  ],
  "groups": [
    {
        "group": "general",
        "description": "General"
    }
 ],
  "listFields": {
    "title": "documentID!",
    "subTitle": "memberId!"
  },
  "depends": ["eliud_core"]
}