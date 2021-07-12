/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_form.dart
                       
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

import 'package:eliud_pkg_chat/model/chat_interactions_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_model.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_form_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_form_state.dart';


class ChatInteractionsForm extends StatelessWidget {
  FormAction formAction;
  ChatInteractionsModel? value;
  ActionModel? submitAction;

  ChatInteractionsForm({Key? key, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var app = AccessBloc.app(context);
    if (app == null) return Text("No app available");
    if (formAction == FormAction.ShowData) {
      return BlocProvider<ChatInteractionsFormBloc >(
            create: (context) => ChatInteractionsFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialiseChatInteractionsFormEvent(value: value)),
  
        child: MyChatInteractionsForm(submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<ChatInteractionsFormBloc >(
            create: (context) => ChatInteractionsFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialiseChatInteractionsFormNoLoadEvent(value: value)),
  
        child: MyChatInteractionsForm(submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithContext(context).adminFormStyle().appBarWithString(context, title: formAction == FormAction.UpdateAction ? 'Update ChatInteractions' : 'Add ChatInteractions'),
        body: BlocProvider<ChatInteractionsFormBloc >(
            create: (context) => ChatInteractionsFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialiseChatInteractionsFormEvent(value: value) : InitialiseNewChatInteractionsFormEvent())),
  
        child: MyChatInteractionsForm(submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyChatInteractionsForm extends StatefulWidget {
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyChatInteractionsForm({this.formAction, this.submitAction});

  _MyChatInteractionsFormState createState() => _MyChatInteractionsFormState(this.formAction);
}


class _MyChatInteractionsFormState extends State<MyChatInteractionsForm> {
  final FormAction? formAction;
  late ChatInteractionsFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _authorIdController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();


  _MyChatInteractionsFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<ChatInteractionsFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _authorIdController.addListener(_onAuthorIdChanged);
    _appIdController.addListener(_onAppIdChanged);
    _detailsController.addListener(_onDetailsChanged);
  }

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.app(context);
    if (app == null) return Text('No app available');
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<ChatInteractionsFormBloc, ChatInteractionsFormState>(builder: (context, state) {
      if (state is ChatInteractionsFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithContext(context).adminListStyle().progressIndicator(context),
      );

      if (state is ChatInteractionsFormLoaded) {
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
        if (state.value!.details != null)
          _detailsController.text = state.value!.details.toString();
        else
          _detailsController.text = "";
      }
      if (state is ChatInteractionsFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Author ID', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _authorIdController, keyboardType: TextInputType.text, validator: (_) => state is AuthorIdChatInteractionsFormError ? state.message : null, hintText: 'field.remark')
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Document ID', icon: Icons.vpn_key, readOnly: (formAction == FormAction.UpdateAction), textEditingController: _documentIDController, keyboardType: TextInputType.text, validator: (_) => state is DocumentIDChatInteractionsFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'App Identifier', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _appIdController, keyboardType: TextInputType.text, validator: (_) => state is AppIdChatInteractionsFormError ? state.message : null, hintText: 'field.remark')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Details', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _detailsController, keyboardType: TextInputType.text, validator: (_) => state is DetailsChatInteractionsFormError ? state.message : null, hintText: null)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().button(context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is ChatInteractionsFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<ChatInteractionsListBloc>(context).add(
                          UpdateChatInteractionsList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              authorId: state.value!.authorId, 
                              appId: state.value!.appId, 
                              details: state.value!.details, 
                              readAccess: state.value!.readAccess, 
                        )));
                      } else {
                        BlocProvider.of<ChatInteractionsListBloc>(context).add(
                          AddChatInteractionsList(value: ChatInteractionsModel(
                              documentID: state.value!.documentID, 
                              authorId: state.value!.authorId, 
                              appId: state.value!.appId, 
                              details: state.value!.details, 
                              readAccess: state.value!.readAccess, 
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
    _myFormBloc.add(ChangedChatInteractionsDocumentID(value: _documentIDController.text));
  }


  void _onAuthorIdChanged() {
    _myFormBloc.add(ChangedChatInteractionsAuthorId(value: _authorIdController.text));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedChatInteractionsAppId(value: _appIdController.text));
  }


  void _onDetailsChanged() {
    _myFormBloc.add(ChangedChatInteractionsDetails(value: _detailsController.text));
  }


  void _onReadAccessChanged(value) {
    _myFormBloc.add(ChangedChatInteractionsReadAccess(value: value));
    setState(() {});
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _authorIdController.dispose();
    _appIdController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, ChatInteractionsFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner());
  }
  

}



