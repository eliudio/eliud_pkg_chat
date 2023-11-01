/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_list.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/model/app_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/component/update_component.dart';


import 'package:eliud_pkg_chat/model/chat_dashboard_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';



typedef ChatDashboardChanged = Function(String? value, int? privilegeLevel,);

class ChatDashboardDropdownButtonWidget extends StatefulWidget {
  final AppModel app;
  int? privilegeLevel;
  String? value;
  final ChatDashboardChanged? trigger;
  final bool? optional;

  ChatDashboardDropdownButtonWidget({ required this.app, this.privilegeLevel, this.value, this.trigger, this.optional, Key? key }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChatDashboardDropdownButtonWidgetState();
  }
}

class ChatDashboardDropdownButtonWidgetState extends State<ChatDashboardDropdownButtonWidget> {
  ChatDashboardListBloc? bloc;

  ChatDashboardDropdownButtonWidgetState();

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<ChatDashboardListBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (bloc != null) bloc!.close();
    super.dispose();
  }

List<Widget> widgets(ChatDashboardModel value) {
var app = widget.app;
var widgets = <Widget>[];
widgets.add(value.description != null ? Center(child: text(app, context, value.description!)) : value.documentID != null ? Center(child: text(app, context, value.documentID)) : Container());
return widgets;
}


  @override
  Widget build(BuildContext context) {
    //var accessState = AccessBloc.getState(context);
    return BlocBuilder<ChatDashboardListBloc, ChatDashboardListState>(builder: (context, state) {
      if (state is ChatDashboardListLoading) {
        return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
      } else if (state is ChatDashboardListLoaded) {
        int? privilegeChosen = widget.privilegeLevel;
        if ((widget.value != null) && (privilegeChosen == null)) {
          if (state.values != null) {
            var selectedValue = state.values!.firstWhere((v) => (v!.documentID == widget.value), orElse: () => null);
            privilegeChosen = selectedValue != null && selectedValue.conditions != null && selectedValue.conditions!.privilegeLevelRequired != null ? selectedValue.conditions!.privilegeLevelRequired!.index : 0;
          }
        }
          
        final values = state.values;
        final items = <DropdownMenuItem<String>>[];
        if (state.values!.isNotEmpty) {
          if (widget.optional != null && widget.optional!) {
            items.add(DropdownMenuItem<String>(
                value: null,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  height: 100.0,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [ Text("None") ],
                  ),
                )));
          }
          for (var element in state.values!) {
            items.add(DropdownMenuItem<String>(
                value: element!.documentID,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  height: 100.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widgets(element),
                  ),
                )));
          }
        }
        return ListView(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: [
          dropdownButton<int>(
            widget.app, context,
            isDense: false,
            isExpanded: false,
            items: [
              DropdownMenuItem<int>(
                value: 0,
                child: text(widget.app, context, 'No privilege Required'),
              ),
              DropdownMenuItem<int>(
                value: 1,
                child: text(widget.app, context, 'Level 1 privilege required'),
              ),
              DropdownMenuItem<int>(
                value: 2,
                child: text(widget.app, context, 'Level 2 privilege required'),
              ),
              DropdownMenuItem<int>(
                value: 3,
                child: text(widget.app, context, 'Must be owner'),
              ),
            ],
            value: privilegeChosen,
            hint: text(widget.app, context, 'Select a privilege'),
            onChanged: _onPrivilegeLevelChange,
          ),
          Row(children: [(false)
            ? SizedBox(
                height: 48, 
                child: dropdownButton<String>(
                      widget.app, context,
                      isDense: false,
                      isExpanded: false,
                      items: items,
                      value: widget.value,
                      hint: text(widget.app, context, 'Select a chatDashboard'),
                      onChanged: _onValueChange,
                    )
                ) 
            : dropdownButton<String>(
                widget.app, context,
                isDense: false,
                isExpanded: false,
                items: items,
                value: widget.value,
                hint: text(widget.app, context, 'Select a chatDashboard'),
                onChanged: _onValueChange,
              ),
          if (widget.value != null) const Spacer(),
          if (widget.value != null) 
            Align(alignment: Alignment.topRight, child: button(
              widget.app,
              context,
              icon: const Icon(
                Icons.edit,
              ),
              label: 'Update',
              onPressed: () {
                updateComponent(context, widget.app, 'chatDashboards', widget.value, (newValue, _) {
                  setState(() {
                    widget.value = widget.value;
                  });
                });
              },
            ))
          ])
        ]);
      } else {
        return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
      }
    });
  }

  void _onValueChange(String? value) {
    widget.trigger!(value, null);
  }

  void _onPrivilegeLevelChange(int? value) {
    BlocProvider.of<ChatDashboardListBloc>(context).add(ChatDashboardChangeQuery(
       newQuery: EliudQuery(theConditions: [
         EliudQueryCondition('conditions.privilegeLevelRequired', isEqualTo: value ?? 0),
         EliudQueryCondition('appId', isEqualTo: widget.app.documentID),]
       ),
     ));
     widget.trigger!(null, value);
  }
}

