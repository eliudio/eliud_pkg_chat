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

import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
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

import 'package:eliud_pkg_chat/model/chat_member_info_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_form_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_form_state.dart';


class ChatMemberInfoForm extends StatelessWidget {
  FormAction formAction;
  ChatMemberInfoModel? value;
  ActionModel? submitAction;

  ChatMemberInfoForm({Key? key, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var app = AccessBloc.app(context);
    if (app == null) return Text("No app available");
    if (formAction == FormAction.ShowData) {
      return BlocProvider<ChatMemberInfoFormBloc >(
            create: (context) => ChatMemberInfoFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialiseChatMemberInfoFormEvent(value: value)),
  
        child: MyChatMemberInfoForm(submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<ChatMemberInfoFormBloc >(
            create: (context) => ChatMemberInfoFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialiseChatMemberInfoFormNoLoadEvent(value: value)),
  
        child: MyChatMemberInfoForm(submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithContext(context).adminFormStyle().appBarWithString(context, title: formAction == FormAction.UpdateAction ? 'Update ChatMemberInfo' : 'Add ChatMemberInfo'),
        body: BlocProvider<ChatMemberInfoFormBloc >(
            create: (context) => ChatMemberInfoFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialiseChatMemberInfoFormEvent(value: value) : InitialiseNewChatMemberInfoFormEvent())),
  
        child: MyChatMemberInfoForm(submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyChatMemberInfoForm extends StatefulWidget {
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyChatMemberInfoForm({this.formAction, this.submitAction});

  _MyChatMemberInfoFormState createState() => _MyChatMemberInfoFormState(this.formAction);
}


class _MyChatMemberInfoFormState extends State<MyChatMemberInfoForm> {
  final FormAction? formAction;
  late ChatMemberInfoFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _memberIdController = TextEditingController();
  final TextEditingController _roomIdController = TextEditingController();


  _MyChatMemberInfoFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<ChatMemberInfoFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _memberIdController.addListener(_onMemberIdChanged);
    _roomIdController.addListener(_onRoomIdChanged);
  }

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.app(context);
    if (app == null) return Text('No app available');
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<ChatMemberInfoFormBloc, ChatMemberInfoFormState>(builder: (context, state) {
      if (state is ChatMemberInfoFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithContext(context).adminListStyle().progressIndicator(context),
      );

      if (state is ChatMemberInfoFormLoaded) {
        if (state.value!.documentID != null)
          _documentIDController.text = state.value!.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value!.memberId != null)
          _memberIdController.text = state.value!.memberId.toString();
        else
          _memberIdController.text = "";
        if (state.value!.roomId != null)
          _roomIdController.text = state.value!.roomId.toString();
        else
          _roomIdController.text = "";
      }
      if (state is ChatMemberInfoFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Member ID', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _memberIdController, keyboardType: TextInputType.text, validator: (_) => state is MemberIdChatMemberInfoFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Chat ID', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _roomIdController, keyboardType: TextInputType.text, validator: (_) => state is RoomIdChatMemberInfoFormError ? state.message : null, hintText: null)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Document ID', icon: Icons.vpn_key, readOnly: (formAction == FormAction.UpdateAction), textEditingController: _documentIDController, keyboardType: TextInputType.text, validator: (_) => state is DocumentIDChatMemberInfoFormError ? state.message : null, hintText: null)
          );



        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().button(context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is ChatMemberInfoFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<ChatMemberInfoListBloc>(context).add(
                          UpdateChatMemberInfoList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              memberId: state.value!.memberId, 
                              roomId: state.value!.roomId, 
                              timestamp: state.value!.timestamp, 
                        )));
                      } else {
                        BlocProvider.of<ChatMemberInfoListBloc>(context).add(
                          AddChatMemberInfoList(value: ChatMemberInfoModel(
                              documentID: state.value!.documentID, 
                              memberId: state.value!.memberId, 
                              roomId: state.value!.roomId, 
                              timestamp: state.value!.timestamp, 
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
    _myFormBloc.add(ChangedChatMemberInfoDocumentID(value: _documentIDController.text));
  }


  void _onMemberIdChanged() {
    _myFormBloc.add(ChangedChatMemberInfoMemberId(value: _memberIdController.text));
  }


  void _onRoomIdChanged() {
    _myFormBloc.add(ChangedChatMemberInfoRoomId(value: _roomIdController.text));
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _memberIdController.dispose();
    _roomIdController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, ChatMemberInfoFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner());
  }
  

}


