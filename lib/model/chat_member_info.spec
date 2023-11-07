{
  "id": "ChatMemberInfo",
  "packageName": "eliud_pkg_chat",
  "packageFriendlyName": "chat",
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
      "required": true,
      "displayName": "Document ID of this read indication",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "authorId",
      "required": true,
      "remark": "The person who this info is about",
      "displayName": "Author ID",
      "fieldType": "String",
      "group": "member"
    },
    {
      "fieldName": "appId",
      "required": true,
      "displayName": "App Identifier",
      "remark": "This is the identifier of the app to which this chat belongs",
      "fieldType": "String",
      "group": "general"
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
      "remark": "Last Read entry in Chat in this room for this member",
      "fieldType": "ServerTimestamp",
      "group": "general"
    },
    {
      "fieldName": "accessibleByGroup",
      "fieldType": "enum",
      "enumName": "ChatMemberInfoAccessibleByGroup",
      "enumValues" : [ "public", "followers", "me", "specificMembers" ]
    },
    {
      "fieldName": "accessibleByMembers",
      "remark": "In case accessibleByGroup == SpecificMembers, then these are the members",
      "displayName": "Accessible By Members",
      "fieldType": "String",
      "iconName": "text_format",
      "arrayType": "Array",
      "hidden": true
    },
    {
      "fieldName": "readAccess",
      "displayName": "Members that can read this detail of the chat. This is determined in functions, based on accessibleByGroup and accessibleByMembers",
      "fieldType": "String",
      "iconName": "text_format",
      "arrayType": "Array",
      "hidden": true
    }
  ],
  "groups": [
    {
        "group": "general",
        "description": "General"
    }
 ],
  "listFields": {
    "title": "Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.documentID))",
    "subTitle": "Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.authorId))"
  },
  "depends": ["eliud_core"]
}