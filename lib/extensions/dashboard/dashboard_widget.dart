import 'package:eliud_pkg_chat/extensions/dashboard/widgets/room_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import '../chat_dashboard_component.dart';
import 'bloc/chat_dashboard_bloc.dart';
import 'bloc/chat_dashboard_state.dart';

class DashboardWidget extends StatefulWidget {
  final String appId;
  final String memberId;

  const DashboardWidget({
    Key? key,
    required this.appId,
    required this.memberId,
  }) : super(key: key);

  @override
  DashboardWidgetState createState() => DashboardWidgetState(appId, memberId);
}

class DashboardWidgetState extends State<DashboardWidget>
    with SingleTickerProviderStateMixin {
  static double ICON_SIZE = 75;

  final String appId;
  final String memberId;
  final GlobalKey _parentKey = GlobalKey();

  DashboardWidgetState(this.appId, this.memberId);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
/*
    var ideaPng = Image.asset(
        "assets/images/publicdomainvectors.org/technoargia_Bulle_droite_montre_bas.png",
        package: "eliud_pkg_chat");
*/
    var speakPng = Image.asset("assets/images/cry-1636046_640.png", package: "eliud_pkg_chat");
    return Stack(key: _parentKey, children: <Widget>[
      SizedBox(
          height:
              MediaQuery.of(context).size.height - ChatDashboard.HEADER_HEIGHT,
          width: double.infinity,
          child: BlocBuilder<ChatDashboardBloc, ChatDashboardState>(
              builder: (context, state) {
            return RoomsWidget(appId: appId, memberId: memberId);
          })),
      DraggableFloatingActionButton(
          child: Container(
            width: ICON_SIZE,
            height: ICON_SIZE,
/*
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
//              color: Colors.red,
              shadows: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(10.0, 10.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
*/
            child:
                speakPng, // Icon(Icons.more_horiz, color: Colors.black, size: 30),
          ),
//          initialOffset: Offset(10,10),
          parentKey: _parentKey,
          onPressed: () {
            print('Button is clicked');
          }),
    ]);
  }

/*
  double height(BuildContext context) {
    return MediaQuery.of(context).size.height * .8;
  }

  double remainingHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - 155;
  }

  Widget contained(Widget widget) {
    return Container(height: 200, width: double.infinity, child: widget);
  }
*/
}

class DraggableFloatingActionButton extends StatefulWidget {
  final Widget child;
  final Offset? initialOffset;
  final VoidCallback onPressed;
  final GlobalKey parentKey;

  DraggableFloatingActionButton({
    required this.child,
    this.initialOffset,
    required this.onPressed,
    required this.parentKey,
  });

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  final GlobalKey _key = GlobalKey();

  bool _isDragging = false;
  bool _isInit = true;
  late Offset _offset;
  late Offset _minOffset;
  late Offset _maxOffset;

  @override
  void initState() {
    super.initState();
    if (widget.initialOffset != null) {
      _offset = widget.initialOffset!;
    } else {
      _offset =
          const Offset(-100, -100); // don't show, will be determined later
    }

    WidgetsBinding.instance?.addPostFrameCallback(_setBoundary);
  }

  void _setBoundary(_) {
    final RenderBox parentRenderBox =
        widget.parentKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;

    try {
      final Size parentSize = parentRenderBox.size;
      final Size size = renderBox.size;

      setState(() {
        _minOffset = const Offset(0, 0);
        _maxOffset = Offset(
            parentSize.width - size.width, parentSize.height - size.height);
        if (widget.initialOffset == null) {
          _offset = Offset((parentSize.width - size.width),
              (parentSize.height - size.width));
        }
        _isInit = false;
      });
    } catch (e) {
      print('catch: $e');
    }
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    if (newOffsetX < _minOffset.dx) {
      newOffsetX = _minOffset.dx;
    } else if (newOffsetX > _maxOffset.dx) {
      newOffsetX = _maxOffset.dx;
    }

    if (newOffsetY < _minOffset.dy) {
      newOffsetY = _minOffset.dy;
    } else if (newOffsetY > _maxOffset.dy) {
      newOffsetY = _maxOffset.dy;
    }

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent) {
          _updatePosition(pointerMoveEvent);

          setState(() {
            _isDragging = true;
          });
        },
        onPointerUp: (PointerUpEvent pointerUpEvent) {
          if (_isDragging) {
            setState(() {
              _isDragging = false;
            });
          } else {
            widget.onPressed();
          }
        },
        child: Container(
          key: _key,
          child: widget.child,
        ),
      ),
    );
  }
}
