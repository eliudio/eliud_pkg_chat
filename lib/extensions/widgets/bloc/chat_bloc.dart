import 'dart:async';
import 'package:bloc/bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatStateUninitialized());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
  }
}
