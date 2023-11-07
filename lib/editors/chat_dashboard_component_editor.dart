import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/storage_conditions_model.dart';
import 'package:eliud_core/style/frontend/has_container.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_dialog_field.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/tools/widgets/condition_simple_widget.dart';
import 'package:eliud_core/tools/widgets/header_widget.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_bloc.dart';
import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_event.dart';
import 'package:eliud_core/core/editor/editor_base_bloc/editor_base_state.dart';

import '../model/chat_dashboard_entity.dart';
import 'members_type_widget.dart';

class ChatDashboardComponentEditorConstructor
    extends ComponentEditorConstructor {
  @override
  void updateComponent(
      AppModel app, BuildContext context, model, EditorFeedback feedback) {
    _openIt(app, context, false, model.copyWith(), feedback);
  }

  @override
  void createNewComponent(
      AppModel app, BuildContext context, EditorFeedback feedback) {
    _openIt(
        app,
        context,
        true,
        ChatDashboardModel(
          appId: app.documentID,
          documentID: newRandomKey(),
          description: 'Chat',
          conditions: StorageConditionsModel(
              privilegeLevelRequired:
                  PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
        ),
        feedback);
  }

  @override
  void updateComponentWithID(AppModel app, BuildContext context, String id,
      EditorFeedback feedback) async {
    var chatDashboard =
        await chatDashboardRepository(appId: app.documentID)!.get(id);
    if (chatDashboard != null) {
      _openIt(app, context, false, chatDashboard, feedback);
    } else {
      openErrorDialog(app, context, '${app.documentID}/_error',
          title: 'Error',
          errorMessage: 'Cannot find chat dashboard with id $id');
    }
  }

  void _openIt(AppModel app, BuildContext context, bool create,
      ChatDashboardModel model, EditorFeedback feedback) {
    openComplexDialog(
      app,
      context,
      '${app.documentID}/chatdashboard',
      title: create ? 'Create Chat Dashboard' : 'Update Chat Dashboard',
      includeHeading: false,
      widthFraction: .9,
      child: BlocProvider<ChatDashboardBloc>(
          create: (context) => ChatDashboardBloc(
                app.documentID,
                /*create,
            */
                feedback,
              )..add(EditorBaseInitialise<ChatDashboardModel>(model)),
          child: ChatDashboardComponentEditor(
            app: app,
          )),
    );
  }
}

class ChatDashboardBloc
    extends EditorBaseBloc<ChatDashboardModel, ChatDashboardEntity> {
  ChatDashboardBloc(String appId, EditorFeedback feedback)
      : super(appId, chatDashboardRepository(appId: appId)!, feedback);

  @override
  ChatDashboardModel newInstance(StorageConditionsModel conditions) {
    return ChatDashboardModel(
        appId: appId,
        description: 'Chat',
        documentID: newRandomKey(),
        membersType: MembersType.allMembers,
        conditions: conditions);
  }

  @override
  ChatDashboardModel setDefaultValues(
      ChatDashboardModel t, StorageConditionsModel conditions) {
    return t.copyWith(conditions: t.conditions ?? conditions);
  }
}

class ChatDashboardComponentEditor extends StatefulWidget {
  final AppModel app;

  const ChatDashboardComponentEditor({
    super.key,
    required this.app,
  });

  @override
  State<StatefulWidget> createState() => _ChatDashboardComponentEditorState();
}

class _ChatDashboardComponentEditorState
    extends State<ChatDashboardComponentEditor> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (aContext, accessState) {
      if (accessState is AccessDetermined) {
        return BlocBuilder<ChatDashboardBloc,
                EditorBaseState<ChatDashboardModel>>(
            builder: (ppContext, chatDashboardState) {
          if (chatDashboardState is EditorBaseInitialised<ChatDashboardModel>) {
            return ListView(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [
                  HeaderWidget(
                    app: widget.app,
                    title: 'ChatDashboard',
                    okAction: () async {
                      await BlocProvider.of<ChatDashboardBloc>(context).save(
                          EditorBaseApplyChanges<ChatDashboardModel>(
                              model: chatDashboardState.model));
                      return true;
                    },
                    cancelAction: () async {
                      return true;
                    },
                  ),
                  topicContainer(widget.app, context,
                      title: 'General',
                      collapsible: true,
                      collapsed: true,
                      children: [
                        getListTile(context, widget.app,
                            leading: const Icon(Icons.vpn_key),
                            title: text(widget.app, context,
                                chatDashboardState.model.documentID)),
                        getListTile(context, widget.app,
                            leading: const Icon(Icons.description),
                            title: dialogField(
                              widget.app,
                              context,
                              initialValue:
                                  chatDashboardState.model.description,
                              valueChanged: (value) {
                                chatDashboardState.model.description = value;
                              },
                              maxLines: 1,
                              decoration: const InputDecoration(
                                hintText: 'Description',
                                labelText: 'Description',
                              ),
                            )),
                      ]),
                  topicContainer(widget.app, context,
                      title: 'Members to chat to',
                      collapsible: true,
                      collapsed: true,
                      children: [
                        MembersTypeWidget(
                          app: widget.app,
                          membersTypeCallback: (MembersType membersType) {
                            setState(() {
                              chatDashboardState.model.membersType =
                                  membersType;
                            });
                          },
                          membersType: chatDashboardState.model.membersType ??
                              MembersType.allMembers,
                        ),
                      ]),
                  topicContainer(widget.app, context,
                      title: 'Condition',
                      collapsible: true,
                      collapsed: true,
                      children: [
                        getListTile(context, widget.app,
                            leading: const Icon(Icons.security),
                            title: ConditionsSimpleWidget(
                              app: widget.app,
                              value: chatDashboardState.model.conditions!,
                            )),
                      ]),
                ]);
          } else {
            return progressIndicator(widget.app, context);
          }
        });
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }
}
