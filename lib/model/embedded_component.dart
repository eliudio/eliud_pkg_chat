/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/embedded_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/model/app_model.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/chat_medium_list_bloc.dart';
import '../model/chat_medium_list.dart';
import '../model/chat_medium_list_event.dart';
import '../model/chat_medium_model.dart';
import '../model/chat_medium_entity.dart';
import '../model/chat_medium_repository.dart';

typedef ChatMediumListChanged = Function(List<ChatMediumModel> values);

chatMediumsList(app, context, value, trigger) =>
    EmbeddedComponentFactory.chatMediumsList(app, context, value, trigger);

class EmbeddedComponentFactory {
/* 
 * chatMediumsList function to construct a list of ChatMediumModel
 */
  static Widget chatMediumsList(AppModel app, BuildContext context,
      List<ChatMediumModel> values, ChatMediumListChanged trigger) {
    ChatMediumInMemoryRepository inMemoryRepository =
        ChatMediumInMemoryRepository(
      trigger,
      values,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatMediumListBloc>(
          create: (context) => ChatMediumListBloc(
            chatMediumRepository: inMemoryRepository,
          )..add(LoadChatMediumList()),
        )
      ],
      child: ChatMediumListWidget(app: app, isEmbedded: true),
    );
  }
}

/* 
 * ChatMediumInMemoryRepository is an in memory implementation of ChatMediumRepository
 */
class ChatMediumInMemoryRepository implements ChatMediumRepository {
  final List<ChatMediumModel> items;
  final ChatMediumListChanged trigger;
  Stream<List<ChatMediumModel>>? theValues;

  /* 
     * Construct the ChatMediumInMemoryRepository
     */
  ChatMediumInMemoryRepository(this.trigger, this.items) {
    List<List<ChatMediumModel>> myList = <List<ChatMediumModel>>[];
    myList.add(items);
    theValues = Stream<List<ChatMediumModel>>.fromIterable(myList);
  }

  int _index(String documentID) {
    int i = 0;
    for (final item in items) {
      if (item.documentID == documentID) {
        return i;
      }
      i++;
    }
    return -1;
  }

  /* 
     * Add an entity
     */
  @override
  Future<ChatMediumEntity> addEntity(
      String documentID, ChatMediumEntity value) {
    throw Exception('Not implemented');
  }

  /* 
     * Update an entity
     */
  @override
  Future<ChatMediumEntity> updateEntity(
      String documentID, ChatMediumEntity value) {
    throw Exception('Not implemented');
  }

  /* 
     * Update a model
     */
  @override
  Future<ChatMediumModel> add(ChatMediumModel value) {
    items.add(value.copyWith(documentID: newRandomKey()));
    trigger(items);
    return Future.value(value);
  }

  /* 
     * Delete a model
     */
  @override
  Future<void> delete(ChatMediumModel value) {
    int index = _index(value.documentID);
    if (index >= 0) items.removeAt(index);
    trigger(items);
    return Future.value();
  }

  /* 
     * Update a model
     */
  @override
  Future<ChatMediumModel> update(ChatMediumModel value) {
    int index = _index(value.documentID);
    if (index >= 0) {
      items.replaceRange(index, index + 1, [value]);
      trigger(items);
    }
    return Future.value(value);
  }

  /* 
     * Get a model
     */
  @override
  Future<ChatMediumModel> get(String? id, {Function(Exception)? onError}) {
    int index = _index(id!);
    var completer = Completer<ChatMediumModel>();
    completer.complete(items[index]);
    return completer.future;
  }

  /* 
     * Retrieve to a list of ChatMediumModel base on a query
     */
  @override
  Stream<List<ChatMediumModel>> values(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return theValues!;
  }

  /* 
     * Retrieve to a list of ChatMediumModel, including linked models base on a query
     */
  @override
  Stream<List<ChatMediumModel>> valuesWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return theValues!;
  }

  /* 
     * Subscribe to a list of ChatMediumModel base on a query
     */
  @override
  StreamSubscription<List<ChatMediumModel>> listen(trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return theValues!.listen((theList) => trigger(theList));
  }

  /* 
     * Subscribe to a list of ChatMediumModel, including linked models, base on a query
     */
  @override
  StreamSubscription<List<ChatMediumModel>> listenWithDetails(trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return theValues!.listen((theList) => trigger(theList));
  }

  /* 
     * Flush the repository
     */
  @override
  void flush() {}

  /* 
     * Retrieve the list of models
     */
  @override
  Future<List<ChatMediumModel>> valuesList(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return Future.value(items);
  }

  @override
  Future<List<ChatMediumModel>> valuesListWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    return Future.value(items);
  }

  /* 
     * Retrieve a subcollection of this collection
     */
  @override
  getSubCollection(String documentId, String name) {
    throw UnimplementedError();
  }

  /* 
   * Retrieve a timestamp
   */
  @override
  String timeStampToString(timeStamp) {
    throw UnimplementedError();
  }

  /* 
   * Subscribe to 1 document / 1 model
   */
  @override
  StreamSubscription<ChatMediumModel> listenTo(
      String documentId, ChatMediumChanged changed,
      {ChatMediumErrorHandler? errorHandler}) {
    throw UnimplementedError();
  }

  @override
  Future<ChatMediumModel> changeValue(
      String documentId, String fieldName, num changeByThisValue) {
    throw UnimplementedError();
  }

  @override
  Future<ChatMediumEntity?> getEntity(String? id,
      {Function(Exception p1)? onError}) {
    throw UnimplementedError();
  }

  @override
  ChatMediumEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() async {}
}
