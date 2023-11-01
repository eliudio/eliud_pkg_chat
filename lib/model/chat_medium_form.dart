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

import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core/core/navigate/router.dart' as eliudrouter;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';




import 'package:eliud_core/model/internal_component.dart';

import 'package:eliud_core/tools/enums.dart';

import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';

import 'package:eliud_pkg_chat/model/chat_medium_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_medium_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_medium_model.dart';
import 'package:eliud_pkg_chat/model/chat_medium_form_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_medium_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_medium_form_state.dart';


class ChatMediumForm extends StatelessWidget {
  final AppModel app;
  FormAction formAction;
  ChatMediumModel? value;
  ActionModel? submitAction;

  ChatMediumForm({Key? key, required this.app, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var appId = app.documentID;
    if (formAction == FormAction.ShowData) {
      return BlocProvider<ChatMediumFormBloc >(
            create: (context) => ChatMediumFormBloc(appId,
                                       
                                                )..add(InitialiseChatMediumFormEvent(value: value)),
  
        child: MyChatMediumForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<ChatMediumFormBloc >(
            create: (context) => ChatMediumFormBloc(appId,
                                       
                                                )..add(InitialiseChatMediumFormNoLoadEvent(value: value)),
  
        child: MyChatMediumForm(app:app, submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithApp(app).adminFormStyle().appBarWithString(app, context, title: formAction == FormAction.UpdateAction ? 'Update ChatMedium' : 'Add ChatMedium'),
        body: BlocProvider<ChatMediumFormBloc >(
            create: (context) => ChatMediumFormBloc(appId,
                                       
                                                )..add((formAction == FormAction.UpdateAction ? InitialiseChatMediumFormEvent(value: value) : InitialiseNewChatMediumFormEvent())),
  
        child: MyChatMediumForm(app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyChatMediumForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  const MyChatMediumForm({super.key, required this.app, this.formAction, this.submitAction});

  @override
  _MyChatMediumFormState createState() => _MyChatMediumFormState(formAction);
}


class _MyChatMediumFormState extends State<MyChatMediumForm> {
  final FormAction? formAction;
  late ChatMediumFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  String? _memberMedium;


  _MyChatMediumFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<ChatMediumFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<ChatMediumFormBloc, ChatMediumFormState>(builder: (context, state) {
      if (state is ChatMediumFormUninitialized) {
        return Center(
        child: StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context),
      );
      }

      if (state is ChatMediumFormLoaded) {
        if (state.value!.documentID != null) {
          _documentIDController.text = state.value!.documentID.toString();
        } else {
          _documentIDController.text = "";
        }
        if (state.value!.memberMedium != null) {
          _memberMedium= state.value!.memberMedium!.documentID;
        } else {
          _memberMedium= "";
        }
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


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData)) {
          children.add(StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().button(widget.app, context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is ChatMediumFormError) {
                      return;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
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
                        eliudrouter.Router.navigateTo(context, widget.submitAction!);
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                ));
        }

        return StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().container(widget.app, context, Form(
            child: ListView(
              padding: const EdgeInsets.all(8),
              physics: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)) ? const NeverScrollableScrollPhysics() : null,
              shrinkWrap: ((formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData)),
              children: children
            ),
          ), formAction!
        );
      } else {
        return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
      }
    });
  }

  void _onDocumentIDChanged() {
    _myFormBloc.add(ChangedChatMediumDocumentID(value: _documentIDController.text));
  }


  void _onMemberMediumSelected(String? val) {
    setState(() {
      _memberMedium = val;
    });
    _myFormBloc.add(ChangedChatMediumMemberMedium(value: val));
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, ChatMediumFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner(widget.app.documentID));
  }
  

}



