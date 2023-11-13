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

import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:eliud_core/tools/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'package:eliud_pkg_chat/model/embedded_component.dart';

import 'package:eliud_core/tools/enums.dart';

import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';

import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/chat_form_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_form_state.dart';

class ChatForm extends StatelessWidget {
  final AppModel app;
  final FormAction formAction;
  final ChatModel? value;
  final ActionModel? submitAction;

  ChatForm(
      {super.key,
      required this.app,
      required this.formAction,
      required this.value,
      this.submitAction});

  /// Build the ChatForm
  @override
  Widget build(BuildContext context) {
    //var accessState = AccessBloc.getState(context);
    var appId = app.documentID;
    if (formAction == FormAction.showData) {
      return BlocProvider<ChatFormBloc>(
        create: (context) => ChatFormBloc(
          appId,
          formAction: formAction,
        )..add(InitialiseChatFormEvent(value: value)),
        child: _MyChatForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    }
    if (formAction == FormAction.showPreloadedData) {
      return BlocProvider<ChatFormBloc>(
        create: (context) => ChatFormBloc(
          appId,
          formAction: formAction,
        )..add(InitialiseChatFormNoLoadEvent(value: value)),
        child: _MyChatForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    } else {
      return Scaffold(
          appBar: StyleRegistry.registry()
              .styleWithApp(app)
              .adminFormStyle()
              .appBarWithString(app, context,
                  title: formAction == FormAction.updateAction
                      ? 'Update Chat'
                      : 'Add Chat'),
          body: BlocProvider<ChatFormBloc>(
            create: (context) => ChatFormBloc(
              appId,
              formAction: formAction,
            )..add((formAction == FormAction.updateAction
                ? InitialiseChatFormEvent(value: value)
                : InitialiseNewChatFormEvent())),
            child: _MyChatForm(
                app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}

class _MyChatForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  _MyChatForm({required this.app, this.formAction, this.submitAction});

  @override
  State<_MyChatForm> createState() => _MyChatFormState(formAction);
}

class _MyChatFormState extends State<_MyChatForm> {
  final FormAction? formAction;
  late ChatFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _authorIdController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _roomIdController = TextEditingController();
  final TextEditingController _sayingController = TextEditingController();
  int? _accessibleByGroupSelectedRadioTile;

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
    _accessibleByGroupSelectedRadioTile = 0;
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<ChatFormBloc, ChatFormState>(builder: (context, state) {
      if (state is ChatFormUninitialized) {
        return Center(
          child: StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminListStyle()
              .progressIndicator(widget.app, context),
        );
      }

      if (state is ChatFormLoaded) {
        _documentIDController.text = state.value!.documentID.toString();
        _authorIdController.text = state.value!.authorId.toString();
        _appIdController.text = state.value!.appId.toString();
        _roomIdController.text = state.value!.roomId.toString();
        _sayingController.text = state.value!.saying.toString();
        if (state.value!.accessibleByGroup != null) {
          _accessibleByGroupSelectedRadioTile =
              state.value!.accessibleByGroup!.index;
        } else {
          _accessibleByGroupSelectedRadioTile = 0;
        }
      }
      if (state is ChatFormInitialized) {
        List<Widget> children = [];
        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'General')));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Author ID',
                icon: Icons.text_format,
                readOnly: _readOnly(accessState, state),
                textEditingController: _authorIdController,
                keyboardType: TextInputType.text,
                validator: (_) =>
                    state is AuthorIdChatFormError ? state.message : null,
                hintText: 'field.remark'));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .radioListTile(
                widget.app,
                context,
                0,
                _accessibleByGroupSelectedRadioTile,
                'public',
                'public',
                !accessState.memberIsOwner(widget.app.documentID)
                    ? null
                    : (dynamic val) => setSelectionAccessibleByGroup(val)));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .radioListTile(
                widget.app,
                context,
                0,
                _accessibleByGroupSelectedRadioTile,
                'followers',
                'followers',
                !accessState.memberIsOwner(widget.app.documentID)
                    ? null
                    : (dynamic val) => setSelectionAccessibleByGroup(val)));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .radioListTile(
                widget.app,
                context,
                0,
                _accessibleByGroupSelectedRadioTile,
                'me',
                'me',
                !accessState.memberIsOwner(widget.app.documentID)
                    ? null
                    : (dynamic val) => setSelectionAccessibleByGroup(val)));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .radioListTile(
                widget.app,
                context,
                0,
                _accessibleByGroupSelectedRadioTile,
                'specificMembers',
                'specificMembers',
                !accessState.memberIsOwner(widget.app.documentID)
                    ? null
                    : (dynamic val) => setSelectionAccessibleByGroup(val)));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'General')));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Document ID',
                icon: Icons.vpn_key,
                readOnly: (formAction == FormAction.updateAction),
                textEditingController: _documentIDController,
                keyboardType: TextInputType.text,
                validator: (_) =>
                    state is DocumentIDChatFormError ? state.message : null,
                hintText: null));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'App Identifier',
                icon: Icons.text_format,
                readOnly: _readOnly(accessState, state),
                textEditingController: _appIdController,
                keyboardType: TextInputType.text,
                validator: (_) =>
                    state is AppIdChatFormError ? state.message : null,
                hintText: 'field.remark'));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Room Identifier',
                icon: Icons.text_format,
                readOnly: _readOnly(accessState, state),
                textEditingController: _roomIdController,
                keyboardType: TextInputType.text,
                validator: (_) =>
                    state is RoomIdChatFormError ? state.message : null,
                hintText: 'field.remark'));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Saying',
                icon: Icons.text_format,
                readOnly: _readOnly(accessState, state),
                textEditingController: _sayingController,
                keyboardType: TextInputType.text,
                validator: (_) =>
                    state is SayingChatFormError ? state.message : null,
                hintText: null));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        children.add(Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: StyleRegistry.registry()
                .styleWithApp(widget.app)
                .adminFormStyle()
                .groupTitle(widget.app, context, 'Media')));

        children.add(Container(
            height: (fullScreenHeight(context) / 2.5),
            child: chatMediumsList(widget.app, context, state.value!.chatMedia,
                _onChatMediaChanged)));

        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .divider(widget.app, context));

        if ((formAction != FormAction.showData) &&
            (formAction != FormAction.showPreloadedData)) {
          children.add(StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminFormStyle()
              .button(
                widget.app,
                context,
                label: 'Submit',
                onPressed: _readOnly(accessState, state)
                    ? null
                    : () {
                        if (state is ChatFormError) {
                          return;
                        } else {
                          if (formAction == FormAction.updateAction) {
                            BlocProvider.of<ChatListBloc>(context)
                                .add(UpdateChatList(
                                    value: state.value!.copyWith(
                              documentID: state.value!.documentID,
                              authorId: state.value!.authorId,
                              appId: state.value!.appId,
                              roomId: state.value!.roomId,
                              timestamp: state.value!.timestamp,
                              saying: state.value!.saying,
                              accessibleByGroup: state.value!.accessibleByGroup,
                              accessibleByMembers:
                                  state.value!.accessibleByMembers,
                              readAccess: state.value!.readAccess,
                              chatMedia: state.value!.chatMedia,
                            )));
                          } else {
                            BlocProvider.of<ChatListBloc>(context)
                                .add(AddChatList(
                                    value: ChatModel(
                              documentID: state.value!.documentID,
                              authorId: state.value!.authorId,
                              appId: state.value!.appId,
                              roomId: state.value!.roomId,
                              timestamp: state.value!.timestamp,
                              saying: state.value!.saying,
                              accessibleByGroup: state.value!.accessibleByGroup,
                              accessibleByMembers:
                                  state.value!.accessibleByMembers,
                              readAccess: state.value!.readAccess,
                              chatMedia: state.value!.chatMedia,
                            )));
                          }
                          if (widget.submitAction != null) {
                            eliudrouter.Router.navigateTo(
                                context, widget.submitAction!);
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
              ));
        }

        return StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .container(
                widget.app,
                context,
                Form(
                  child: ListView(
                      padding: const EdgeInsets.all(8),
                      physics: ((formAction == FormAction.showData) ||
                              (formAction == FormAction.showPreloadedData))
                          ? NeverScrollableScrollPhysics()
                          : null,
                      shrinkWrap: ((formAction == FormAction.showData) ||
                          (formAction == FormAction.showPreloadedData)),
                      children: children),
                ),
                formAction!);
      } else {
        return StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminListStyle()
            .progressIndicator(widget.app, context);
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

  void setSelectionAccessibleByGroup(int? val) {
    setState(() {
      _accessibleByGroupSelectedRadioTile = val;
    });
    _myFormBloc
        .add(ChangedChatAccessibleByGroup(value: toChatAccessibleByGroup(val)));
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

  /// Is the form read-only?
  bool _readOnly(AccessState accessState, ChatFormInitialized state) {
    return (formAction == FormAction.showData) ||
        (formAction == FormAction.showPreloadedData) ||
        (!accessState.memberIsOwner(widget.app.documentID));
  }
}
