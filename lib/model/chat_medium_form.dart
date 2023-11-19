/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_form.dart
                       
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

import 'package:eliud_pkg_chat/model/chat_medium_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_medium_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_medium_model.dart';
import 'package:eliud_pkg_chat/model/chat_medium_form_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_medium_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_medium_form_state.dart';


class ChatMediumForm extends StatelessWidget {
  final AppModel app;
  final FormAction formAction;
  final ChatMediumModel? value;
  final ActionModel? submitAction;

  ChatMediumForm({Key? key, required this.app, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  /**
   * Build the ChatMediumForm
   */
  @override
  Widget build(BuildContext context) {
    //var accessState = AccessBloc.getState(context);
    var appId = app.documentID;
    if (formAction == FormAction.showData) {
      return BlocProvider<ChatMediumFormBloc >(
            create: (context) => ChatMediumFormBloc(appId,
                                       
                                                )..add(InitialiseChatMediumFormEvent(value: value)),
  
        child: _MyChatMediumForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.showPreloadedData) {
      return BlocProvider<ChatMediumFormBloc >(
            create: (context) => ChatMediumFormBloc(appId,
                                       
                                                )..add(InitialiseChatMediumFormNoLoadEvent(value: value)),
  
        child: _MyChatMediumForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithApp(app).adminFormStyle().appBarWithString(app, context, title: formAction == FormAction.updateAction ? 'Update ChatMedium' : 'Add ChatMedium'),
        body: BlocProvider<ChatMediumFormBloc >(
            create: (context) => ChatMediumFormBloc(appId,
                                       
                                                )..add((formAction == FormAction.updateAction ? InitialiseChatMediumFormEvent(value: value) : InitialiseNewChatMediumFormEvent())),
  
        child: _MyChatMediumForm(app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class _MyChatMediumForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  _MyChatMediumForm({required this.app, this.formAction, this.submitAction});

  State<_MyChatMediumForm> createState() => _MyChatMediumFormState(this.formAction);
}


class _MyChatMediumFormState extends State<_MyChatMediumForm> {
  final FormAction? formAction;
  late ChatMediumFormBloc _myFormBloc;

  String? _memberMedium;


  _MyChatMediumFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<ChatMediumFormBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMediumFormBloc, ChatMediumFormState>(builder: (context, state) {
      if (state is ChatMediumFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context),
      );

      if (state is ChatMediumFormLoaded) {
        if (state.value!.memberMedium != null)
          _memberMedium= state.value!.memberMedium!.documentID;
        else
          _memberMedium= "";
      }
      if (state is ChatMediumFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'General')
                ));


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().groupTitle(widget.app, context, 'Image')
                ));

        children.add(

                DropdownButtonComponentFactory().createNew(app: widget.app, id: "memberMediums", value: _memberMedium, trigger: (value, privilegeLevel) => _onMemberMediumSelected(value), optional: true),
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().divider(widget.app, context));


        if ((formAction != FormAction.showData) && (formAction != FormAction.showPreloadedData))
          children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().button(widget.app, context, label: 'Submit',
                  onPressed: _readOnly(context, state) ? null : () {
                    if (state is ChatMediumFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.updateAction) {
                        BlocProvider.of<ChatMediumListBloc>(context).add(
                          UpdateChatMediumList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              memberMedium: state.value!.memberMedium, 
                        )));
                      } else {
                        BlocProvider.of<ChatMediumListBloc>(context).add(
                          AddChatMediumList(value: ChatMediumModel(
                              documentID: state.value!.documentID, 
                              memberMedium: state.value!.memberMedium, 
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

  void _onMemberMediumSelected(String? val) {
    setState(() {
      _memberMedium = val;
    });
    _myFormBloc.add(ChangedChatMediumMemberMedium(value: val));
  }



  @override
  void dispose() {
    super.dispose();
  }

  /**
   * Is the form read-only?
   */
  bool _readOnly(BuildContext context, ChatMediumFormInitialized state) {
    return (formAction == FormAction.showData) || (formAction == FormAction.showPreloadedData) || (!Apis.apis().getCoreApi().memberIsOwner(context, widget.app.documentID));
  }
  

}



