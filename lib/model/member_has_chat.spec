{
  "id": "MemberHasChat",
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
    "documentSubCollectionOf": "app"
  },
  "memberIdentifier": "memberId",
  "fields": [
    {
      "fieldName": "documentID",
      "required": true,
      "displayName": "Document ID",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "memberId",
      "required": true,
      "displayName": "Member ID",
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
      "fieldName": "hasUnread",
      "displayName": "Has Unread",
      "fieldType": "bool",
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
    "title": "value.documentID != null ? Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.documentID)) : Container()",
    "subTitle": "value.memberId != null ? Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.memberId)) : Container()"
  },
  "depends": ["eliud_core"]
}