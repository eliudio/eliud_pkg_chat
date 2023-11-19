/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_list.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core_model/apis/apis.dart';
import 'package:eliud_core_model/tools/route_builders/route_builders.dart';
import 'package:eliud_core_model/style/style_registry.dart';
import 'package:eliud_core_model/tools/etc/has_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core_model/tools/etc/screen_size.dart';
import 'package:eliud_core_model/model/background_model.dart';
import 'package:eliud_core_model/tools/etc/delete_snackbar.dart';
import 'package:eliud_core_model/tools/etc/etc.dart';
import 'package:eliud_core_model/tools/etc/enums.dart';
import 'package:eliud_core_model/style/frontend/has_text.dart';

import 'package:eliud_pkg_chat/model/chat_medium_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_medium_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_medium_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_medium_model.dart';

import 'package:eliud_core_model/model/app_model.dart';


import 'chat_medium_form.dart';


typedef ChatMediumWidgetProvider(ChatMediumModel? value);

class ChatMediumListWidget extends StatefulWidget with HasFab {
  final AppModel app;
  final BackgroundModel? listBackground;
  final ChatMediumWidgetProvider? widgetProvider;
  final bool? readOnly;
  final String? form;
  //final ChatMediumListWidgetState? state;
  final bool? isEmbedded;

  ChatMediumListWidget({ Key? key, required this.app, this.readOnly, this.form, this.widgetProvider, this.isEmbedded, this.listBackground }): super(key: key);

  @override
  ChatMediumListWidgetState createState() {
    return ChatMediumListWidgetState();
  }

  @override
  Widget? fab(BuildContext context) {
    if ((readOnly != null) && readOnly!) return null;
    var state = ChatMediumListWidgetState();
    return state.fab(context,);
  }
}

class ChatMediumListWidgetState extends State<ChatMediumListWidget> {
  Widget? fab(BuildContext aContext) {
    return  !Apis.apis().getCoreApi().memberIsOwner(context, widget.app.documentID) ? null : 
      StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().floatingActionButton(widget.app, context, 'PageFloatBtnTag', Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          pageRouteBuilder(widget.app, page: BlocProvider.value(
              value: BlocProvider.of<ChatMediumListBloc>(context),
              child: ChatMediumForm(app:widget.app,
                  value: null,
                  formAction: FormAction.addAction)
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Apis.apis().getCoreApi().buildWhenAccessDetermined(widget.app, (context) {
        return BlocBuilder<ChatMediumListBloc, ChatMediumListState>(builder: (context, state) {
          if (state is ChatMediumListLoading) {
            return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
          } else if (state is ChatMediumListLoaded) {
            final values = state.values;
            if ((widget.isEmbedded != null) && widget.isEmbedded!) {
              var children = <Widget>[];
              children.add(theList(context, values, ));
              children.add(
                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().button(widget.app,
                      context, label: 'Add',
                      onPressed: () {
                        Navigator.of(context).push(
                                  pageRouteBuilder(widget.app, page: BlocProvider.value(
                                      value: BlocProvider.of<ChatMediumListBloc>(context),
                                      child: ChatMediumForm(app:widget.app,
                                          value: null,
                                          formAction: FormAction.addAction)
                                  )),
                                );
                      },
                    ));
              return ListView(
                padding: const EdgeInsets.all(8),
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: children
              );
            } else {
              return theList(context, values, );
            }
          } else {
            return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
          }
        });
    });
  }
  
  Widget theList(BuildContext context, values, ) {
    var member = Apis.apis().getCoreApi().getMember(context);
    return Container(
      decoration: widget.listBackground == null ? StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().boxDecorator(widget.app, context, member) : BoxDecorationHelper.boxDecoration(widget.app, member, widget.listBackground),
      child: ListView.separated(
        separatorBuilder: (context, index) => StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().divider(widget.app, context),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: values.length,
        itemBuilder: (context, index) {
          final value = values[index];
          
          if (widget.widgetProvider != null) { return widget.widgetProvider!(value);}

          return ChatMediumListItem(app: widget.app,
            value: value,
//            app: accessState.app,
            onDismissed: (direction) {
              BlocProvider.of<ChatMediumListBloc>(context)
                  .add(DeleteChatMediumList(value: value));
              ScaffoldMessenger.of(context).showSnackBar(DeleteSnackBar(
                message: "ChatMedium $value.documentID",
                onUndo: () => BlocProvider.of<ChatMediumListBloc>(context)
                    .add(AddChatMediumList(value: value)),
              ));
            },
            onTap: () async {
                                   final removedItem = await Navigator.of(context).push(
                        pageRouteBuilder(widget.app, page: BlocProvider.value(
                              value: BlocProvider.of<ChatMediumListBloc>(context),
                              child: getForm(value, FormAction.updateAction))));
                      if (removedItem != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          DeleteSnackBar(
                        message: "ChatMedium $value.documentID",
                            onUndo: () => BlocProvider.of<ChatMediumListBloc>(context)
                                .add(AddChatMediumList(value: value)),
                          ),
                        );
                      }

            },
          );
        }
      ));
  }
  
  
  Widget? getForm(value, action) {
    if (widget.form == null) {
      return ChatMediumForm(app:widget.app, value: value, formAction: action);
    } else {
      return null;
    }
  }
  
  
}


class ChatMediumListItem extends StatelessWidget {
  final AppModel app;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ChatMediumModel value;

  ChatMediumListItem({
    Key? key,
    required this.app,
    required this.onDismissed,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__ChatMedium_item_${value.documentID}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.documentID)),
      ),
    );
  }
}

