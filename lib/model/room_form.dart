/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_form.dart
                       
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

import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/model/room_form_bloc.dart';
import 'package:eliud_pkg_chat/model/room_form_event.dart';
import 'package:eliud_pkg_chat/model/room_form_state.dart';


class RoomForm extends StatelessWidget {
  FormAction formAction;
  RoomModel? value;
  ActionModel? submitAction;

  RoomForm({Key? key, required this.formAction, required this.value, this.submitAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    var app = AccessBloc.app(context);
    if (app == null) return Text("No app available");
    if (formAction == FormAction.ShowData) {
      return BlocProvider<RoomFormBloc >(
            create: (context) => RoomFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialiseRoomFormEvent(value: value)),
  
        child: MyRoomForm(submitAction: submitAction, formAction: formAction),
          );
    } if (formAction == FormAction.ShowPreloadedData) {
      return BlocProvider<RoomFormBloc >(
            create: (context) => RoomFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add(InitialiseRoomFormNoLoadEvent(value: value)),
  
        child: MyRoomForm(submitAction: submitAction, formAction: formAction),
          );
    } else {
      return Scaffold(
        appBar: StyleRegistry.registry().styleWithContext(context).adminFormStyle().appBarWithString(context, title: formAction == FormAction.UpdateAction ? 'Update Room' : 'Add Room'),
        body: BlocProvider<RoomFormBloc >(
            create: (context) => RoomFormBloc(AccessBloc.appId(context),
                                       formAction: formAction,

                                                )..add((formAction == FormAction.UpdateAction ? InitialiseRoomFormEvent(value: value) : InitialiseNewRoomFormEvent())),
  
        child: MyRoomForm(submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}


class MyRoomForm extends StatefulWidget {
  final FormAction? formAction;
  final ActionModel? submitAction;

  MyRoomForm({this.formAction, this.submitAction});

  _MyRoomFormState createState() => _MyRoomFormState(this.formAction);
}


class _MyRoomFormState extends State<MyRoomForm> {
  final FormAction? formAction;
  late RoomFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _ownerIdController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


  _MyRoomFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<RoomFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _ownerIdController.addListener(_onOwnerIdChanged);
    _appIdController.addListener(_onAppIdChanged);
    _descriptionController.addListener(_onDescriptionChanged);
  }

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.app(context);
    if (app == null) return Text('No app available');
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<RoomFormBloc, RoomFormState>(builder: (context, state) {
      if (state is RoomFormUninitialized) return Center(
        child: StyleRegistry.registry().styleWithContext(context).adminListStyle().progressIndicator(context),
      );

      if (state is RoomFormLoaded) {
        if (state.value!.documentID != null)
          _documentIDController.text = state.value!.documentID.toString();
        else
          _documentIDController.text = "";
        if (state.value!.ownerId != null)
          _ownerIdController.text = state.value!.ownerId.toString();
        else
          _ownerIdController.text = "";
        if (state.value!.appId != null)
          _appIdController.text = state.value!.appId.toString();
        else
          _appIdController.text = "";
        if (state.value!.description != null)
          _descriptionController.text = state.value!.description.toString();
        else
          _descriptionController.text = "";
      }
      if (state is RoomFormInitialized) {
        List<Widget> children = [];
         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Owner ID', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _ownerIdController, keyboardType: TextInputType.text, validator: (_) => state is OwnerIdRoomFormError ? state.message : null, hintText: 'field.remark')
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


         children.add(Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: StyleRegistry.registry().styleWithContext(context).adminFormStyle().groupTitle(context, 'General')
                ));

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Document ID', icon: Icons.vpn_key, readOnly: (formAction == FormAction.UpdateAction), textEditingController: _documentIDController, keyboardType: TextInputType.text, validator: (_) => state is DocumentIDRoomFormError ? state.message : null, hintText: null)
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'App Identifier', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _appIdController, keyboardType: TextInputType.text, validator: (_) => state is AppIdRoomFormError ? state.message : null, hintText: 'field.remark')
          );

        children.add(

                  StyleRegistry.registry().styleWithContext(context).adminFormStyle().textFormField(context, labelText: 'Description', icon: Icons.text_format, readOnly: _readOnly(accessState, state), textEditingController: _descriptionController, keyboardType: TextInputType.text, validator: (_) => state is DescriptionRoomFormError ? state.message : null, hintText: null)
          );


        children.add(Container(height: 20.0));
        children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().divider(context));


        if ((formAction != FormAction.ShowData) && (formAction != FormAction.ShowPreloadedData))
          children.add(StyleRegistry.registry().styleWithContext(context).adminFormStyle().button(context, label: 'Submit',
                  onPressed: _readOnly(accessState, state) ? null : () {
                    if (state is RoomFormError) {
                      return null;
                    } else {
                      if (formAction == FormAction.UpdateAction) {
                        BlocProvider.of<RoomListBloc>(context).add(
                          UpdateRoomList(value: state.value!.copyWith(
                              documentID: state.value!.documentID, 
                              ownerId: state.value!.ownerId, 
                              appId: state.value!.appId, 
                              description: state.value!.description, 
                              members: state.value!.members, 
                        )));
                      } else {
                        BlocProvider.of<RoomListBloc>(context).add(
                          AddRoomList(value: RoomModel(
                              documentID: state.value!.documentID, 
                              ownerId: state.value!.ownerId, 
                              appId: state.value!.appId, 
                              description: state.value!.description, 
                              members: state.value!.members, 
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
    _myFormBloc.add(ChangedRoomDocumentID(value: _documentIDController.text));
  }


  void _onOwnerIdChanged() {
    _myFormBloc.add(ChangedRoomOwnerId(value: _ownerIdController.text));
  }


  void _onAppIdChanged() {
    _myFormBloc.add(ChangedRoomAppId(value: _appIdController.text));
  }


  void _onDescriptionChanged() {
    _myFormBloc.add(ChangedRoomDescription(value: _descriptionController.text));
  }


  void _onMembersChanged(value) {
    _myFormBloc.add(ChangedRoomMembers(value: value));
    setState(() {});
  }



  @override
  void dispose() {
    _documentIDController.dispose();
    _ownerIdController.dispose();
    _appIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _readOnly(AccessState accessState, RoomFormInitialized state) {
    return (formAction == FormAction.ShowData) || (formAction == FormAction.ShowPreloadedData) || (!accessState.memberIsOwner());
  }
  

}



