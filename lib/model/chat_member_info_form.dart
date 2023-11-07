/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_form.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'package:eliud_core/tools/enums.dart';

import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';

import 'package:eliud_pkg_chat/model/chat_member_info_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_form_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_form_state.dart';

class ChatMemberInfoForm extends StatelessWidget {
  final AppModel app;
  final FormAction formAction;
  final ChatMemberInfoModel? value;
  final ActionModel? submitAction;

  ChatMemberInfoForm(
      {super.key,
      required this.app,
      required this.formAction,
      required this.value,
      this.submitAction});

  /// Build the ChatMemberInfoForm
  @override
  Widget build(BuildContext context) {
    //var accessState = AccessBloc.getState(context);
    var appId = app.documentID;
    if (formAction == FormAction.showData) {
      return BlocProvider<ChatMemberInfoFormBloc>(
        create: (context) => ChatMemberInfoFormBloc(
          appId,
          formAction: formAction,
        )..add(InitialiseChatMemberInfoFormEvent(value: value)),
        child: MyChatMemberInfoForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    }
    if (formAction == FormAction.showPreloadedData) {
      return BlocProvider<ChatMemberInfoFormBloc>(
        create: (context) => ChatMemberInfoFormBloc(
          appId,
          formAction: formAction,
        )..add(InitialiseChatMemberInfoFormNoLoadEvent(value: value)),
        child: MyChatMemberInfoForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    } else {
      return Scaffold(
          appBar: StyleRegistry.registry()
              .styleWithApp(app)
              .adminFormStyle()
              .appBarWithString(app, context,
                  title: formAction == FormAction.updateAction
                      ? 'Update ChatMemberInfo'
                      : 'Add ChatMemberInfo'),
          body: BlocProvider<ChatMemberInfoFormBloc>(
            create: (context) => ChatMemberInfoFormBloc(
              appId,
              formAction: formAction,
            )..add((formAction == FormAction.updateAction
                ? InitialiseChatMemberInfoFormEvent(value: value)
                : InitialiseNewChatMemberInfoFormEvent())),
            child: MyChatMemberInfoForm(
                app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}

class MyChatMemberInfoForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyChatMemberInfoForm({required this.app, this.formAction, this.submitAction});

  @override
  State<MyChatMemberInfoForm> createState() =>
      _MyChatMemberInfoFormState(formAction);
}

class _MyChatMemberInfoFormState extends State<MyChatMemberInfoForm> {
  final FormAction? formAction;
  late ChatMemberInfoFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _authorIdController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _roomIdController = TextEditingController();
  int? _accessibleByGroupSelectedRadioTile;

  _MyChatMemberInfoFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<ChatMemberInfoFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _authorIdController.addListener(_onAuthorIdChanged);
    _appIdController.addListener(_onAppIdChanged);
    _roomIdController.addListener(_onRoomIdChanged);
    _accessibleByGroupSelectedRadioTile = 0;
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<ChatMemberInfoFormBloc, ChatMemberInfoFormState>(
        builder: (context, state) {
      if (state is ChatMemberInfoFormUninitialized) {
        return Center(
          child: StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminListStyle()
              .progressIndicator(widget.app, context),
        );
      }

      if (state is ChatMemberInfoFormLoaded) {
        _documentIDController.text = state.value!.documentID.toString();
        _authorIdController.text = state.value!.authorId.toString();
        _appIdController.text = state.value!.appId.toString();
        _roomIdController.text = state.value!.roomId.toString();
        if (state.value!.accessibleByGroup != null) {
          _accessibleByGroupSelectedRadioTile =
              state.value!.accessibleByGroup!.index;
        } else {
          _accessibleByGroupSelectedRadioTile = 0;
        }
      }
      if (state is ChatMemberInfoFormInitialized) {
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
                validator: (_) => state is AuthorIdChatMemberInfoFormError
                    ? state.message
                    : null,
                hintText: 'field.remark'));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Chat ID',
                icon: Icons.text_format,
                readOnly: _readOnly(accessState, state),
                textEditingController: _roomIdController,
                keyboardType: TextInputType.text,
                validator: (_) => state is RoomIdChatMemberInfoFormError
                    ? state.message
                    : null,
                hintText: null));

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
                labelText: 'Document ID of this read indication',
                icon: Icons.vpn_key,
                readOnly: (formAction == FormAction.updateAction),
                textEditingController: _documentIDController,
                keyboardType: TextInputType.text,
                validator: (_) => state is DocumentIDChatMemberInfoFormError
                    ? state.message
                    : null,
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
                validator: (_) => state is AppIdChatMemberInfoFormError
                    ? state.message
                    : null,
                hintText: 'field.remark'));

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
                        if (state is ChatMemberInfoFormError) {
                          return;
                        } else {
                          if (formAction == FormAction.updateAction) {
                            BlocProvider.of<ChatMemberInfoListBloc>(context)
                                .add(UpdateChatMemberInfoList(
                                    value: state.value!.copyWith(
                              documentID: state.value!.documentID,
                              authorId: state.value!.authorId,
                              appId: state.value!.appId,
                              roomId: state.value!.roomId,
                              timestamp: state.value!.timestamp,
                              accessibleByGroup: state.value!.accessibleByGroup,
                              accessibleByMembers:
                                  state.value!.accessibleByMembers,
                              readAccess: state.value!.readAccess,
                            )));
                          } else {
                            BlocProvider.of<ChatMemberInfoListBloc>(context)
                                .add(AddChatMemberInfoList(
                                    value: ChatMemberInfoModel(
                              documentID: state.value!.documentID,
                              authorId: state.value!.authorId,
                              appId: state.value!.appId,
                              roomId: state.value!.roomId,
                              timestamp: state.value!.timestamp,
                              accessibleByGroup: state.value!.accessibleByGroup,
                              accessibleByMembers:
                                  state.value!.accessibleByMembers,
                              readAccess: state.value!.readAccess,
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
    _myFormBloc.add(
        ChangedChatMemberInfoDocumentID(value: _documentIDController.text));
  }

  void _onAuthorIdChanged() {
    _myFormBloc
        .add(ChangedChatMemberInfoAuthorId(value: _authorIdController.text));
  }

  void _onAppIdChanged() {
    _myFormBloc.add(ChangedChatMemberInfoAppId(value: _appIdController.text));
  }

  void _onRoomIdChanged() {
    _myFormBloc.add(ChangedChatMemberInfoRoomId(value: _roomIdController.text));
  }

  void setSelectionAccessibleByGroup(int? val) {
    setState(() {
      _accessibleByGroupSelectedRadioTile = val;
    });
    _myFormBloc.add(ChangedChatMemberInfoAccessibleByGroup(
        value: toChatMemberInfoAccessibleByGroup(val)));
  }

  @override
  void dispose() {
    _documentIDController.dispose();
    _authorIdController.dispose();
    _appIdController.dispose();
    _roomIdController.dispose();
    super.dispose();
  }

  /// Is the form read-only?
  bool _readOnly(AccessState accessState, ChatMemberInfoFormInitialized state) {
    return (formAction == FormAction.showData) ||
        (formAction == FormAction.showPreloadedData) ||
        (!accessState.memberIsOwner(widget.app.documentID));
  }
}
