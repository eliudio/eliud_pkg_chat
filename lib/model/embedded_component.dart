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
import 'package:eliud_core/core/blocs/access/access_bloc.dart';

import '../model/chat_medium_list_bloc.dart';
import '../model/chat_medium_list.dart';
import '../model/chat_medium_list_event.dart';
import '../model/chat_medium_model.dart';
import '../model/chat_medium_repository.dart';

typedef ChatMediumListChanged(List<ChatMediumModel> values);

chatMediumsList(app, context, value, trigger) => EmbeddedComponentFactory.chatMediumsList(app, context, value, trigger);

class EmbeddedComponentFactory {

static Widget chatMediumsList(BuildContext context, AppModel app, List<ChatMediumModel> values, ChatMediumListChanged trigger) {
  ChatMediumInMemoryRepository inMemoryRepository = ChatMediumInMemoryRepository(trigger, values,);
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

class ChatMediumInMemoryRepository implements ChatMediumRepository {
    final List<ChatMediumModel> items;
    final ChatMediumListChanged trigger;
    Stream<List<ChatMediumModel>>? theValues;

    ChatMediumInMemoryRepository(this.trigger, this.items) {
        List<List<ChatMediumModel>> myList = <List<ChatMediumModel>>[];
        if (items != null) myList.add(items);
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

    Future<ChatMediumModel> add(ChatMediumModel value) {
        items.add(value.copyWith(documentID: newRandomKey()));
        trigger(items);
        return Future.value(value);
    }

    Future<void> delete(ChatMediumModel value) {
      int index = _index(value.documentID!);
      if (index >= 0) items.removeAt(index);
      trigger(items);
      return Future.value(value);
    }

    Future<ChatMediumModel> update(ChatMediumModel value) {
      int index = _index(value.documentID!);
      if (index >= 0) {
        items.replaceRange(index, index+1, [value]);
        trigger(items);
      }
      return Future.value(value);
    }

    Future<ChatMediumModel> get(String? id, { Function(Exception)? onError }) {
      int index = _index(id!);
      var completer = new Completer<ChatMediumModel>();
      completer.complete(items[index]);
      return completer.future;
    }

    Stream<List<ChatMediumModel>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!;
    }
    
    Stream<List<ChatMediumModel>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!;
    }
    
    @override
    StreamSubscription<List<ChatMediumModel>> listen(trigger, { String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!.listen((theList) => trigger(theList));
    }
  
    @override
    StreamSubscription<List<ChatMediumModel>> listenWithDetails(trigger, { String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return theValues!.listen((theList) => trigger(theList));
    }
    
    void flush() {}

    Future<List<ChatMediumModel>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return Future.value(items);
    }
    
    Future<List<ChatMediumModel>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
      return Future.value(items);
    }

    @override
    getSubCollection(String documentId, String name) {
      throw UnimplementedError();
    }

  @override
  String timeStampToString(timeStamp) {
    throw UnimplementedError();
  }
  
  @override
  StreamSubscription<ChatMediumModel> listenTo(String documentId, ChatMediumChanged changed) {
    throw UnimplementedError();
  }

  @override
  Future<ChatMediumModel> changeValue(String documentId, String fieldName, num changeByThisValue) {
    throw UnimplementedError();
  }
  

    Future<void> deleteAll() async {}
}

