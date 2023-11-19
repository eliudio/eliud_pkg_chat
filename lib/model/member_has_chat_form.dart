/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_form.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core_model/model/app_model.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core_model/apis/action_api/action_model.dart';

import 'package:eliud_core_model/apis/apis.dart';

import 'package:eliud_core_model/tools/etc/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:eliud_core_model/tools/common_tools.dart';
import 'package:eliud_core_model/style/style_registry.dart';
import 'package:eliud_core_model/style/admin/admin_form_style.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:eliud_core_model/model/internal_component.dart';
import 'package:eliud_pkg_chat/model/embedded_component.dart';
import 'package:eliud_pkg_chat/tools/bespoke_formfields.dart';
import 'package:eliud_core_model/tools/bespoke_formfields.dart';

import 'package:eliud_core_model/tools/etc/enums.dart';
import 'package:eliud_core_model/tools/etc/etc.dart';

import 'package:eliud_core_model/model/repository_export.dart';
import 'package:eliud_core_model/model/abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_core_model/model/embedded_component.dart';
import 'package:eliud_pkg_chat/model/embedded_component.dart';
import 'package:eliud_core_model/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_core_model/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

import 'package:eliud_pkg_chat/model/member_has_chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_list_event.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_model.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_form_bloc.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_form_event.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_form_state.dart';


class MemberHasChatForm extends StatelessWidget {
  final AppModel app;
  final FormAction formAction;
  final MemberHasChatModel? value;
  final ActionModel? submitAction;

  MemberHasChatForm({Key? key, required this.app, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  /**
   * Build the MemberHasChatForm
   */
  @override
  Widget build(BuildContext context) {
    //var accessState = AccessBloc.getState(context);
    var appId = app.documentID;
    if (formAction == FormAction.showData) {
      return BlocProvider<MemberHasChatFormBloc >(
            create: (context) => MemberHasChatFormBloc(appId,
                                       formAction: formAction,

                                                )..add(InitialiseMemberHasChatFormEvent(value: value)),
  
        child: _MyMemberHasChatForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.showPreloadedData) {
      return BlocProvider<MemberHasChatFormBloc >(
            create: (context) => MemberHasChatFormBloc(appId,
                                       formAction: formAction,

                                                )..add(InitialiseMemberHasChatFormNoLoadEvent(value: value)),
  
        child: _MyMemberHasChatForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithApp(app).adminFormStyle().appBarWithString(app, context, title: formAction == FormAction.updateAction ? 'Update MemberHasChat' : 'Add MemberHasChat'),
        body: BlocProvider<MemberHasChatFormBloc >(
            create: (context) => MemberHasChatFormBloc(appId,
                                       formAction: formAction,

                                                )..add((formAction == FormAction.updateAction ? InitialiseMemberHasChatFormEvent(value: value) : InitialiseNewMemberHasChatFormEvent())),
  
        child: _MyMemberHasChatForm(app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class _MyMemberHasChatForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  _MyMemberHasChatForm({required this.app, this.formAction, this.submitAction});

  State<_MyMemberHasChatForm> createState() => _MyMemberHasChatFormState(this.formAction);
}


class _MyMemberHasChatFormState extends State<_MyMemberHasChatForm> {
  final FormAction? formAction;
  late MemberHasChatFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _memberIdController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  bool? _hasUnreadSelection;


  _MyMemberHasChatFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<MemberHasChatFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _memberIdController.addListener(_onMemberIdChanged);
    _appIdController.addListener(_onAppIdChanged);
    _hasUnreadSelection = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberHasChatFormBloc, MemberHasChatFormState>(builder: (context, state) {
      if (state is MemberHasChatFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context),
      );

      if (state is MemberHasChatFormLoaded) {
        _documentIDController.text = state.value!.documentID.toString();
        _memberIdController.text = state.value!.memberId.toString();
        _appIdController.text = state.value!.appId.toString();
        if (state.value!.hasUnread != null)
        _hasUnreadSelection = state.value!.hasUnread;
        else
        _hasUnreadSelection = false;
      }
      if (state is MemberHasChatFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'Member ID', icon: Icons.text_format, readOnly: _readOnly(context, state), textEditingController: _memberIdController, keyboardType: TextInputType.text, validator: (_) => state is MemberIdMemberHasChatFormError ? state.message : null, hintText: null)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'Document ID', icon: Icons.vpn_key, readOnly: (formAction == FormAction.updateAction), textEditingController: _documentIDController, keyboardType: TextInputType.text, validator: (_) => state is DocumentIDMemberHasChatFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().textFormField(widget.app, context, labelText: 'App Identifier', icon: Icons.text_format, readOnly: _readOnly(context, state), textEditingController: _appIdController, keyboardType: TextInputType.text, validator: (_) => state is AppIdMemberHasChatFormError ? state.message : null, hintText: 'field.remark')
          );

        children.add(

                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().checkboxListTile(widget.app, context, 'Has Unread', _hasUnreadSelection, _readOnly(context, state) ? null : (dynamic val) => setSelectionHasUnread(val))
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


        if ((formAction != FormAction.showData) && (formAction != FormAction.showPreloadedData))
          children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().button(widget.app, context, label: 'Submit',
                  onPressed: _readOnly(context, state) ? null : () {
                    if (state is MemberHasChatFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.updateAction) {
                        BlocProvider.of<MemberHasChatListBloc>(context).add(
                          UpdateMemberHasChatList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              memberId: state.value!.memberId, 
                              appId: state.value!.appId, 
                              hasUnread: state.value!.hasUnread, 
                        )));
                      } else {
                        BlocProvider.of<MemberHasChatListBloc>(context).add(
                          AddMemberHasChatList(value: MemberHasChatModel(
                              documentID: state.value!.documentID, 
                              memberId: state.value!.memberId, 
                              appId: state.value!.appId, 
                              hasUnread: state.value!.hasUnread, 
                          )));
                      }
                      if (widget.submitAction != null) {
                        Apis.apis().getRouterApi().navigateTo(context, widget.submitAction!);
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                ));

        return StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().container(widget.app, context, Form(
            child: ListView(
              padding: const EdgeInsets.all(8),
              physics: ((formAction == FormAction.showData) || (formAction == FormAction.showPreloadedData)) ? NeverScrollableScrollPhysics() : null,
              shrinkWrap: ((formAction == FormAction.showData) || (formAction == FormAction.showPreloadedData)),
              children: children as List<Widget>
            ),
          ), formAction!
        );
      } else {
        return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
      }
    });
  }

  void _onDocumentIDChanged() {
    _myFormBloc.add(ChangedMemberHasChatDocumentID(value: _documentIDController.text));
  }


  void _onMemberIdChanged() {
    _myFormBloc.add(ChangedMemberHasChatMemberId(value: _memberIdController.text));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedMemberHasChatAppId(value: _appIdController.text));
  }


  void setSelectionHasUnread(bool? val) {
    setState(() {
      _hasUnreadSelection = val;
    });
    _myFormBloc.add(ChangedMemberHasChatHasUnread(value: val));
  }


  @override
  void dispose() {
    _documentIDController.dispose();
    _memberIdController.dispose();
    _appIdController.dispose();
    super.dispose();
  }

  /**
   * Is the form read-only?
   */
  bool _readOnly(BuildContext context, MemberHasChatFormInitialized state) {
    return (formAction == FormAction.showData) || (formAction == FormAction.showPreloadedData) || (!Apis.apis().getCoreApi().memberIsOwner(context, widget.app.documentID));
  }
  

}



