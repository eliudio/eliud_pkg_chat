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

import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/model/room_form_bloc.dart';
import 'package:eliud_pkg_chat/model/room_form_event.dart';
import 'package:eliud_pkg_chat/model/room_form_state.dart';

class RoomForm extends StatelessWidget {
  final AppModel app;
  final FormAction formAction;
  final RoomModel? value;
  final ActionModel? submitAction;

  RoomForm(
      {super.key,
      required this.app,
      required this.formAction,
      required this.value,
      this.submitAction});

  /// Build the RoomForm
  @override
  Widget build(BuildContext context) {
    //var accessState = AccessBloc.getState(context);
    var appId = app.documentID;
    if (formAction == FormAction.showData) {
      return BlocProvider<RoomFormBloc>(
        create: (context) => RoomFormBloc(
          appId,
          formAction: formAction,
        )..add(InitialiseRoomFormEvent(value: value)),
        child: _MyRoomForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    }
    if (formAction == FormAction.showPreloadedData) {
      return BlocProvider<RoomFormBloc>(
        create: (context) => RoomFormBloc(
          appId,
          formAction: formAction,
        )..add(InitialiseRoomFormNoLoadEvent(value: value)),
        child: _MyRoomForm(
            app: app, submitAction: submitAction, formAction: formAction),
      );
    } else {
      return Scaffold(
          appBar: StyleRegistry.registry()
              .styleWithApp(app)
              .adminFormStyle()
              .appBarWithString(app, context,
                  title: formAction == FormAction.updateAction
                      ? 'Update Room'
                      : 'Add Room'),
          body: BlocProvider<RoomFormBloc>(
            create: (context) => RoomFormBloc(
              appId,
              formAction: formAction,
            )..add((formAction == FormAction.updateAction
                ? InitialiseRoomFormEvent(value: value)
                : InitialiseNewRoomFormEvent())),
            child: _MyRoomForm(
                app: app, submitAction: submitAction, formAction: formAction),
          ));
    }
  }
}

class _MyRoomForm extends StatefulWidget {
  final AppModel app;
  final FormAction? formAction;
  final ActionModel? submitAction;

  _MyRoomForm({required this.app, this.formAction, this.submitAction});

  @override
  State<_MyRoomForm> createState() => _MyRoomFormState(formAction);
}

class _MyRoomFormState extends State<_MyRoomForm> {
  final FormAction? formAction;
  late RoomFormBloc _myFormBloc;

  final TextEditingController _documentIDController = TextEditingController();
  final TextEditingController _ownerIdController = TextEditingController();
  final TextEditingController _appIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool? _isRoomSelection;

  _MyRoomFormState(this.formAction);

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<RoomFormBloc>(context);
    _documentIDController.addListener(_onDocumentIDChanged);
    _ownerIdController.addListener(_onOwnerIdChanged);
    _appIdController.addListener(_onAppIdChanged);
    _descriptionController.addListener(_onDescriptionChanged);
    _isRoomSelection = false;
  }

  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    return BlocBuilder<RoomFormBloc, RoomFormState>(builder: (context, state) {
      if (state is RoomFormUninitialized) {
        return Center(
          child: StyleRegistry.registry()
              .styleWithApp(widget.app)
              .adminListStyle()
              .progressIndicator(widget.app, context),
        );
      }

      if (state is RoomFormLoaded) {
        _documentIDController.text = state.value!.documentID.toString();
        _ownerIdController.text = state.value!.ownerId.toString();
        _appIdController.text = state.value!.appId.toString();
        _descriptionController.text = state.value!.description.toString();
        if (state.value!.isRoom != null) {
          _isRoomSelection = state.value!.isRoom;
        } else {
          _isRoomSelection = false;
        }
      }
      if (state is RoomFormInitialized) {
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
                labelText: 'Owner ID',
                icon: Icons.text_format,
                readOnly: _readOnly(accessState, state),
                textEditingController: _ownerIdController,
                keyboardType: TextInputType.text,
                validator: (_) =>
                    state is OwnerIdRoomFormError ? state.message : null,
                hintText: 'field.remark'));

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
                    state is DocumentIDRoomFormError ? state.message : null,
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
                    state is AppIdRoomFormError ? state.message : null,
                hintText: 'field.remark'));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .textFormField(widget.app, context,
                labelText: 'Description',
                icon: Icons.text_format,
                readOnly: _readOnly(accessState, state),
                textEditingController: _descriptionController,
                keyboardType: TextInputType.text,
                validator: (_) =>
                    state is DescriptionRoomFormError ? state.message : null,
                hintText: null));

        children.add(StyleRegistry.registry()
            .styleWithApp(widget.app)
            .adminFormStyle()
            .checkboxListTile(
                widget.app,
                context,
                'Is Room',
                _isRoomSelection,
                _readOnly(accessState, state)
                    ? null
                    : (dynamic val) => setSelectionIsRoom(val)));

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
                        if (state is RoomFormError) {
                          return;
                        } else {
                          if (formAction == FormAction.updateAction) {
                            BlocProvider.of<RoomListBloc>(context)
                                .add(UpdateRoomList(
                                    value: state.value!.copyWith(
                              documentID: state.value!.documentID,
                              ownerId: state.value!.ownerId,
                              appId: state.value!.appId,
                              description: state.value!.description,
                              isRoom: state.value!.isRoom,
                              members: state.value!.members,
                              timestamp: state.value!.timestamp,
                            )));
                          } else {
                            BlocProvider.of<RoomListBloc>(context)
                                .add(AddRoomList(
                                    value: RoomModel(
                              documentID: state.value!.documentID,
                              ownerId: state.value!.ownerId,
                              appId: state.value!.appId,
                              description: state.value!.description,
                              isRoom: state.value!.isRoom,
                              members: state.value!.members,
                              timestamp: state.value!.timestamp,
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

  void setSelectionIsRoom(bool? val) {
    setState(() {
      _isRoomSelection = val;
    });
    _myFormBloc.add(ChangedRoomIsRoom(value: val));
  }

  @override
  void dispose() {
    _documentIDController.dispose();
    _ownerIdController.dispose();
    _appIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Is the form read-only?
  bool _readOnly(AccessState accessState, RoomFormInitialized state) {
    return (formAction == FormAction.showData) ||
        (formAction == FormAction.showPreloadedData) ||
        (!accessState.memberIsOwner(widget.app.documentID));
  }
}
