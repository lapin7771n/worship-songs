import 'dart:core';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:worshipsongs/widgets/speed_dial/speed_dial_controller.dart';

// Special Thanks to Andrea Bizzotto and Matt Carroll!
//
// Goal: https://material.io/components/buttons-floating-action-button/#types-of-transitions
// Influenced by: https://medium.com/coding-with-flutter/flutter-adding-animated-overlays-to-your-app-e0bb049eff39
//                https://stackoverflow.com/questions/46480221/flutter-floating-action-button-with-speed-dail
// Codes from: https://github.com/bizz84/bottom_bar_fab_flutter
//             https://github.com/matthew-carroll/fluttery/blob/master/lib/src/layout_overlays.dart

class SpeedDialFloatingActionButton extends StatefulWidget {
  /// Creates Floating action button with speed dial attached.
  ///
  /// [childOnFold] is default widget attched to Floating action button.
  /// [useRotateAnimation] makes more fancy when using with Icons.add or with unfold child.
  ///
  /// The [childOnFold] must not be null. Additionally,
  /// if [childOnUnfold] is specified, two widgets([childOnFold] and [childOnUnfold]) will be switched with animation when speed dial is opened/closed.

  /// NOTE: In order to apply fade transition between [childOnFold] and [childOnUnfold], make sure one of those has Key field. (eg. ValueKey<int>(value) or UniqueKey()).
  ///       As we using AnimatedSwitcher for transition animation, no key with same type of child will perform no animation. It is AnimatedSwitcher's behaviour.
  SpeedDialFloatingActionButton({
    @required this.actions,
    this.onAction,
    @required this.childOnFold,
    this.childOnUnfold,
    this.useRotateAnimation = false,
    this.animationDuration = 250,
    this.controller,
    this.visible = true,
    this.isDismissible = false,
    this.backgroundColor,
  });

  final List<SpeedDialAction> actions;
  final ValueChanged<int> onAction;
  final Widget childOnFold;
  final Widget childOnUnfold;
  final int animationDuration;
  final bool useRotateAnimation;
  final SpeedDialController controller;
  final bool visible;
  final bool isDismissible;

  /// The floating button's background color.
  ///
  /// If this property is null, then the [Theme]'s
  /// [ThemeData.floatingActionButtonTheme.backgroundColor] is used. If that
  /// property is also null, then the [Theme]'s
  /// [ThemeData.colorScheme.secondary] color is used.
  final Color backgroundColor;

  @override
  State<StatefulWidget> createState() => SpeedDialFloatingActionButtonState();
}

class SpeedDialFloatingActionButtonState
    extends State<SpeedDialFloatingActionButton> {
  final GlobalKey key = GlobalKey();
  bool flagRender = false;
  OverlayEntry oEntry;

  @override
  void initState() {
    super.initState();
    if (oEntry != null) {
      oEntry.remove();
    }

    oEntry = OverlayEntry(builder: (_) => renderButton());
    insertButton();
  }

  @override
  void didUpdateWidget(SpeedDialFloatingActionButton oldWidget) {
    removeButton();
    if (ModalRoute.of(context).isCurrent) {
      insertButton();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    removeButton();
    super.dispose();
  }

  void removeButton() {
    if (flagRender) {
      oEntry.remove();
      flagRender = !flagRender;
    }
  }

  void insertButton() {
    if (!flagRender) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => Overlay.of(context).insert(oEntry));
      flagRender = !flagRender;
    }
  }

  Widget renderButton() {
    if (widget.visible) {
      RenderBox box = key.currentContext.findRenderObject();
      final Offset offset = box.localToGlobal(Offset.zero);

      return SpeedDial(
        controller: widget.controller,
        actions: widget.actions,
        onAction: widget.onAction,
        childOnFold: widget.childOnFold,
        childOnUnfold: widget.childOnUnfold,
        animationDuration: widget.animationDuration,
        useRotateAnimation: widget.useRotateAnimation,
        offset: Offset(offset.dx, offset.dy),
        backgroundColor: widget.backgroundColor,
        isDismissible: widget.isDismissible,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        child: FloatingActionButton(onPressed: () {}, key: key),
        visible: widget.visible);
  }
}

class SpeedDialAction {
  SpeedDialAction({this.child, this.label, this.backgroundColor});

  final Widget child;
  final Widget label;

  /// The action button's background color.
  ///
  /// If this property is null, then the [Theme]'s
  /// [ThemeData.cardColor] is used.
  final Color backgroundColor;
}

class SpeedDial extends StatefulWidget {
  SpeedDial({
    @required this.actions,
    this.onAction,
    @required this.childOnFold,
    this.childOnUnfold,
    this.animationDuration,
    this.useRotateAnimation,
    this.controller,
    this.offset,
    this.isDismissible,
    this.backgroundColor,
  });

  final SpeedDialController controller;
  final List<SpeedDialAction> actions;
  final ValueChanged<int> onAction;
  final Widget childOnFold;
  final Widget childOnUnfold;
  final int animationDuration;
  final bool useRotateAnimation;
  final Offset offset;
  final bool isDismissible;
  final Color backgroundColor;

  @override
  State createState() => _SpeedDialState();
}

class _SpeedDialState extends State<SpeedDial> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );

    widget.controller ?? SpeedDialController()
      ..setAnimator(_controller);

    if (widget.isDismissible) {
      _controller.addStatusListener(_onDismissible);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildActions();
  }

  Widget _buildActions() {
    final Size fullsize = MediaQuery.of(context).size; // device size
    final double wButton = 56; // button width
    final double hButtom = 56; // button height + ( icon height * length icons )

    double start;
    if (widget.offset.dx > (fullsize.width / 2)) {
      start = fullsize.width - (widget.offset.dx + wButton);
    } else {
      start = fullsize.width - widget.offset.dx - wButton;
    }

    double bottom;
    if (widget.offset.dy > (fullsize.height / 2)) {
      bottom = fullsize.height - widget.offset.dy - hButtom;
    } else {
      bottom = fullsize.height + (widget.offset.dy.abs() - hButtom);
    }

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned.directional(
          textDirection: TextDirection.rtl,
          bottom: bottom,
          start: start,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.actions.length, (int index) {
              return _buildChild(index);
            }).reversed.toList()
              ..add(_buildFab()),
          ),
        ),
      ],
    );
  }

  Widget _buildChild(int index) {
    Color backgroundColor =
        widget.actions[index].backgroundColor ?? Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(_controller),
          child: widget.actions[index].label != null
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                  margin: EdgeInsets.only(right: 5.0, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        offset: Offset(0.8, 0.8),
                        blurRadius: 2.4,
                      )
                    ],
                  ),
                  child: widget.actions[index].label,
                )
              : Container(),
        ),
        Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Interval(0.0, (index + 1) / widget.actions.length,
                  curve: Curves.linear),
            ),
            child: FloatingActionButton(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              mini: true,
              child: widget.actions[index].child,
              onPressed: () => _onAction(index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      onPressed: toggle,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (widget.childOnUnfold == null) {
              return widget.useRotateAnimation
                  ? _buildRotation(widget.childOnFold)
                  : widget.childOnFold;
            } else {
              return widget.useRotateAnimation
                  ? _buildRotation(_buildAnimatedSwitcher())
                  : _buildAnimatedSwitcher();
            }
          }),
      elevation: 2.0,
    );
  }

  void toggle() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Widget _buildRotation(Widget child) {
    return Transform.rotate(
      angle: _controller.value * pi / 4,
      child: child,
    );
  }

  Widget _buildAnimatedSwitcher() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: widget.animationDuration),
      child:
          _controller.value < 0.5 ? widget.childOnFold : widget.childOnUnfold,
    );
  }

  void _onAction(int index) {
    _controller.reverse();
    widget.onAction(index);
  }

  void _onDismissible(AnimationStatus status) {
    Future<bool> _onReturn() async {
      _controller.reverse();
      return false;
    }

    if (status == AnimationStatus.forward) {
      Navigator.of(context).push(
        PageRouteBuilder(
          fullscreenDialog: true,
          opaque: false,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 100),
          barrierColor: Colors.black54,
          pageBuilder: (BuildContext context, _, __) {
            return WillPopScope(
              child: Container(),
              onWillPop: _onReturn,
            );
          },
        ),
      );
    }
    if (status == AnimationStatus.reverse) {
      Navigator.pop(context);
    }
  }
}
