{
  "id": "Chat",
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
  "memberIdentifier": "authorId",
  "fields": [
    {
      "fieldName": "documentID",
      "displayName": "Document ID",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "authorId",
      "remark": "The person initiating the conversation, or the owner of the group",
      "displayName": "Author ID",
      "fieldType": "String",
      "group": "member"
    },
    {
      "fieldName": "appId",
      "displayName": "App Identifier",
      "remark": "This is the identifier of the app to which this chat belongs",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "roomId",
      "displayName": "Room Identifier",
      "remark": "This is the identifier of the room to which this chat belongs",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "timestamp",
      "displayName": "Timestamp",
      "fieldType": "ServerTimestamp",
      "group": "general"
    },
    {
      "fieldName": "saying",
      "displayName": "Saying",
      "fieldType": "String",
      "iconName": "text_format",
      "group": "general"
    },
    {
      "fieldName": "readAccess",
      "displayName": "Members that can read this detail of the chat",
      "fieldType": "String",
      "iconName": "text_format",
      "arrayType": "Array",
      "hidden": true
    },
    {
      "fieldName": "chatMedia",
      "fieldType": "ChatMedium",
      "displayName": "Media",
      "group": "media",
      "arrayType": "Array"
    }
  ],
  "groups": [
    {
        "group": "general",
        "description": "General"
    },
    {
        "group": "media",
        "description": "Media"
    }
 ],
  "listFields": {
    "title": "value!.documentID != null ? Center(child: StyleRegistry.registry().styleWithContext(context).adminListStyle().listItem(context, value!.documentID!)) : Container()",
    "subTitle": "value!.saying != null ? Center(child: StyleRegistry.registry().styleWithContext(context).adminListStyle().listItem(context, value!.saying!)) : Container()"
  },
  "depends": ["eliud_core"]
}