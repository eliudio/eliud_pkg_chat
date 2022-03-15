/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_list.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'chat_member_info_list_bloc.dart';
import 'chat_member_info_list_event.dart';
import 'chat_member_info_list_state.dart';
import 'chat_member_info_model.dart';

class ChatMemberInfoComponentSelector extends ComponentSelector {
  @override
  Widget createSelectWidget(BuildContext context, AppModel app, double height,
      SelectComponent selected, editorConstructor) {
    var appId = app.documentID!;
    return BlocProvider<ChatMemberInfoListBloc>(
          create: (context) => ChatMemberInfoListBloc(
            chatMemberInfoRepository:
                chatMemberInfoRepository(appId: appId)!,
          )..add(LoadChatMemberInfoList()),
      child: SelectChatMemberInfoWidget(app: app,
          height: height,
          selected: selected,
          editorConstructor: editorConstructor),
    );
  }
}

class SelectChatMemberInfoWidget extends StatefulWidget {
  final AppModel app;
  final double height;
  final SelectComponent selected;
  final ComponentEditorConstructor editorConstructor;

  const SelectChatMemberInfoWidget(
      {Key? key,
      required this.app,
      required this.height,
      required this.selected,
      required this.editorConstructor})
      : super(key: key);

  @override
  _SelectChatMemberInfoWidgetState createState() {
    return _SelectChatMemberInfoWidgetState();
  }
}

class _SelectChatMemberInfoWidgetState extends State<SelectChatMemberInfoWidget> {
  Widget theList(BuildContext context, List<ChatMemberInfoModel?> values) {
    var app = widget.app; 
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: values.length,
        itemBuilder: (context, index) {
          final value = values[index];
          if (value != null) {
            return getListTile(
              context,
              widget.app,
              trailing: PopupMenuButton<int>(
                  child: Icon(Icons.more_vert),
                  elevation: 10,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: text(widget.app, context, 'Add to page'),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: text(widget.app, context, 'Update'),
                        ),
                      ],
                  onSelected: (selectedValue) {
                    if (selectedValue == 1) {
                      widget.selected(value.documentID!);
                    } else if (selectedValue == 2) {
                      widget.editorConstructor.updateComponent(widget.app, context, value, (_) {});
                    }
                  }),
              title: value.documentID != null ? Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.documentID!)) : Container(),
              subtitle: value.authorId != null ? Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.authorId!)) : Container(),
            );
          } else {
            return Container();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMemberInfoListBloc, ChatMemberInfoListState>(
        builder: (context, state) {
      var children = <Widget>[];
      if ((state is ChatMemberInfoListLoaded) && (state.values != null)) {
        children.add(Container(
            height: widget.height - 45,
            child: theList(
              context,
              state.values!,
            )));
      } else {
        children.add(Container(
            height: widget.height - 45,
            ));
      }
      children.add(Column(children: [
        divider(widget.app, context),
        Center(
            child: iconButton(widget.app, 
          context,
          onPressed: () {
            widget.editorConstructor.createNewComponent(widget.app, context, (_) {});
          },
          icon: Icon(Icons.add),
        ))
      ]));
      return ListView(
          physics: ScrollPhysics(), shrinkWrap: true, children: children);
    });
  }
}



