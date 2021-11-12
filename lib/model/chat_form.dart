/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_form.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/blocs/access/state/logged_in.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/tools/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/style/admin/admin_form_style.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:intl/intl.dart';

import 'package:eliud_core/eliud.dart';

import 'package:eliud_core/model/internal_component.dart';
import 'package:eliud_pkg_chat/model/embedded_component.dart';
import 'package:eliud_pkg_chat/tools/bespoke_formfields.dart';
import 'package:eliud_core/tools/bespoke_formfields.dart';

import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_core/tools/etc.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_core/model/embedded_component.dart';
import 'package:eliud_pkg_chat/model/embedded_component.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/chat_form_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_form_state.dart';


class ChatForm extends StatelessWidget {
  FormAction formAction;
  ChatModel? value;
  ActionModel? submitAction;

  ChatForm({Key? key, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var app = AccessBloc.currentApp(context);
    if (app == null) return Text("No app available");
    if (formAction == FormAction.ShowData) {
      return BlocProvider<ChatFormBloc >(
            create: (context) => ChatFormBloc(AccessBloc.currentAppId(context),
                                       formAction: formAction,

                                                )..add(InitialiseChatFormEvent(value: value)),
  
        child: MyChatForm(submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<ChatFormBloc >(
            create: (context) => ChatFormBloc(AccessBloc.currentAppId(context),
                                       formAction: formAction,

                                                )..add(InitialiseChatFormNoLoadEvent(value: value)),
  
        child: MyChatForm(submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithContext(context).adminFormStyle().appBarWithString(context, title: formAction == FormAction.UpdateAction ? 'Update Chat' : 'Add Chat'),
        body: BlocProvider<ChatFormBloc >(
            create: (context) => ChatFormBloc(AccessBloc.currentAppId(context),
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialiseChatFormEvent(value: value) : InitialiseNewChatFormEvent())),
  
        child: MyChatForm(submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyChatForm extends StatefulWidget {
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyChatForm({this.formAction, this.submitAction});

  _MyChatFormState createState() => _MyChatFormState(this.formAction);
}


class _MyChatFormState extends State<MyChatForm> {
  final FormAction? formAction;
  late ChatFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _authorIdController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _roomIdController = TextEditingController();
  final TextEditingController _sayingController = TextEditingController();


  _MyChatFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<ChatFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _authorIdController.addListener(_onAuthorIdChanged);
    _appIdController.addListener(_onAppIdChanged);
    _roomIdController.addListener(_onRoomIdChanged);
    _sayingController.addListener(_onSayingChanged);
  }

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.currentApp(context);
    if (app == null) return Text('No app available');
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<ChatFormBloc, ChatFormState>(builder: (context, state) {
      if (state is ChatFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithContext(context).adminListStyle().progressIndicator(context),
      );

      if (state is ChatFormLoaded) {
        if (state.value!.documentID != null)
          _documentIDController.text = state.value!.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value!.authorId != null)
          _authorIdController.text = state.value!.authorId.toString();
        else
          _authorIdController.text = "";
        if (state.value!.appId != null)
          _appIdController.text = state.value!.appId.toString();
        else
          _appIdController.text = "";
        if (state.value!.roomId != null)
          _roomIdController.text = state.value!.roomId.toString();
        else
          _roomIdController.text = "";
        if (state.value!.saying != null)
          _sayingController.text = state.value!.saying.toString();
        else
          _sayingController.text = "";
      }
      if (state is ChatFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Author ID', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _authorIdController, keyboardType: TextInputType.text, validator: (_) => state is AuthorIdChatFormError ? state.message : null, hintText: 'field.remark')
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Document ID', icon: Icons.vpn_key, readOnly: (formAction == FormAction.UpdateAction), textEditingController: _documentIDController, keyboardType: TextInputType.text, validator: (_) => state is DocumentIDChatFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'App Identifier', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _appIdController, keyboardType: TextInputType.text, validator: (_) => state is AppIdChatFormError ? state.message : null, hintText: 'field.remark')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Room Identifier', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _roomIdController, keyboardType: TextInputType.text, validator: (_) => state is RoomIdChatFormError ? state.message : null, hintText: 'field.remark')
          );


        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Saying', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _sayingController, keyboardType: TextInputType.text, validator: (_) => state is SayingChatFormError ? state.message : null, hintText: null)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'Media')
                ));

        children.add(

                new Container(
                    height: (fullScreenHeight(context) / 2.5), 
                    child: chatMediumsList(context, state.value!.chatMedia, _onChatMediaChanged)
                )
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().button(context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is ChatFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<ChatListBloc>(context).add(
                          UpdateChatList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              authorId: state.value!.authorId, 
                              appId: state.value!.appId, 
                              roomId: state.value!.roomId, 
                              timestamp: state.value!.timestamp, 
                              saying: state.value!.saying, 
                              readAccess: state.value!.readAccess, 
                              chatMedia: state.value!.chatMedia, 
                        )));
                      } else {
                        BlocProvider.of<ChatListBloc>(context).add(
                          AddChatList(value: ChatModel(
                              documentID: state.value!.documentID, 
                              authorId: state.value!.authorId, 
                              appId: state.value!.appId, 
                              roomId: state.value!.roomId, 
                              timestamp: state.value!.timestamp, 
                              saying: state.value!.saying, 
                              readAccess: state.value!.readAccess, 
                              chatMedia: state.value!.chatMedia, 
                          )));
                      }
                      if (widget.submitAction != null) {
                        eliudrouter.Router.navigateTo(context, widget.submitAction!);
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                ));

        return StyleRegistry.registry().styleWithContext(context).adminFormStyle().container(context, Form(
            child: ListView(
              padding: const EdgeInsets.all(8),
              physics: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)) ? NeverScrollableScrollPhysics() : null,
              shrinkWrap: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)),
              children: children as List<Widget>
            ),
          ), formAction!
        );
      } else {
        return StyleRegistry.registry().styleWithContext(context).adminListStyle().progressIndicator(context);
      }
    });
  }

  void _onDocumentIDChanged() {
    _myFormBloc.add(ChangedChatDocumentID(value: _documentIDController.text));
  }


  void _onAuthorIdChanged() {
    _myFormBloc.add(ChangedChatAuthorId(value: _authorIdController.text));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedChatAppId(value: _appIdController.text));
  }


  void _onRoomIdChanged() {
    _myFormBloc.add(ChangedChatRoomId(value: _roomIdController.text));
  }


  void _onSayingChanged() {
    _myFormBloc.add(ChangedChatSaying(value: _sayingController.text));
  }


  void _onReadAccessChanged(value) {
    _myFormBloc.add(ChangedChatReadAccess(value: value));
    setState(() {});
  }


  void _onChatMediaChanged(value) {
    _myFormBloc.add(ChangedChatChatMedia(value: value));
    setState(() {});
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _authorIdController.dispose();
    _appIdController.dispose();
    _roomIdController.dispose();
    _sayingController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, ChatFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner(AccessBloc.currentAppId(context)));
  }
  

}



