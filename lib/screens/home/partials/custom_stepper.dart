// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

enum ProgressStepState {
  /// A step that displays its index in its circle.
  indexed,

  /// A step that displays a pencil icon in its circle.
  editing,

  /// A step that displays a tick icon in its circle.
  complete,

  /// A step that is disabled and does not to react to taps.
  disabled,

  /// A step that is currently having an error. e.g. the user has submitted wrong
  /// input.
  error,
}

@immutable
class ControlsDetails {
  /// Creates a set of details describing the TrackingProgressTree.
  const ControlsDetails({
    required this.currentStep,
    required this.stepIndex,
    this.onStepCancel,
    this.onStepContinue,
  });
  /// Index that is active for the surrounding [TrackingProgressTree] widget. This may be
  /// different from [stepIndex] if the user has just changed steps and we are
  /// currently animating toward that step.
  final int currentStep;

  /// Index of the step for which these controls are being built. This is
  /// not necessarily the active index, if the user has just changed steps and
  /// this step is animating away. To determine whether a given builder is building
  /// the active step or the step being navigated away from, see [isActive].
  final int stepIndex;

  /// The callback called when the 'continue' button is tapped.
  ///
  /// If null, the 'continue' button will be disabled.
  final VoidCallback? onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  ///
  /// If null, the 'cancel' button will be disabled.
  final VoidCallback? onStepCancel;

  /// True if the indicated step is also the current active step. If the user has
  /// just activated the transition to a new step, some [TrackingProgressTree.type] values will
  /// lead to both steps being rendered for the duration of the animation shifting
  /// between steps.
  bool get isActive => currentStep == stepIndex;
}

/// A builder that creates a widget given the two callbacks `onStepContinue` and
/// `onStepCancel`.
///
/// Used by [TrackingProgressTree.controlsBuilder].
///
/// See also:
///
///  * [WidgetBuilder], which is similar but only takes a [BuildContext].
typedef ControlsWidgetBuilder = Widget Function(BuildContext context, ControlsDetails details);

const TextStyle _kStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);
const Color _kErrorLight = Colors.red;
final Color _kErrorDark = Colors.red.shade400;
const Color _kCircleActiveLight = Colors.white;
const Color _kCircleActiveDark = Colors.black87;
const Color _kDisabledLight = Colors.black38;
const Color _kDisabledDark = Colors.white38;
const double _kStepSize = 20.0;

@immutable
class ProgressStep {
  const ProgressStep({
    required this.title,
    this.subtitle,
    this.remark,
    this.content,
    this.state = ProgressStepState.indexed,
    this.isActive = false,
  });

  final Widget title;

  final Widget? subtitle;

  final Widget? remark;

  final Widget? content;

  final ProgressStepState state;

  final bool isActive;
}

class TrackingProgressTree extends StatefulWidget {
  const TrackingProgressTree({
    Key? key,
    required this.steps,
    this.physics,
    this.currentStep = 0,
    this.controlsBuilder,
    this.elevation,
    this.margin,
    this.color,
  }) : assert(0 <= currentStep && currentStep < steps.length),
        super(key: key);
  final List<ProgressStep> steps;
  final ScrollPhysics? physics;
  final int currentStep;
  final ControlsWidgetBuilder? controlsBuilder;
  final Color? color;

  /// The elevation of this stepper's [Material] when [type] is [TrackingProgressType.horizontal].
  final double? elevation;

  /// custom margin on vertical stepper.
  final EdgeInsetsGeometry? margin;

  @override
  State<TrackingProgressTree> createState() => _TrackingProgressState();
}

class _TrackingProgressState extends State<TrackingProgressTree> with TickerProviderStateMixin {
  late List<GlobalKey> _keys;
  final Map<int, ProgressStepState> _oldStates = <int, ProgressStepState>{};

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.steps.length,
          (int i) => GlobalKey(),
    );

    for (int i = 0; i < widget.steps.length; i += 1)
      _oldStates[i] = widget.steps[i].state;
  }

  @override
  void didUpdateWidget(TrackingProgressTree oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);

    for (int i = 0; i < oldWidget.steps.length; i += 1)
      _oldStates[i] = oldWidget.steps[i].state;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Widget _buildLine(bool visible, {bool isCompleted = true}) {
    return Container(
      width: visible ? 2.0 : 0.0,
      height: 120.0,
      color: (widget.color ?? Color(0xFF0076BB)).withOpacity(isCompleted ? 0.5 : 1),
    );
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final ProgressStepState state = oldState ? _oldStates[index]! : widget.steps[index].state;
    final bool isDarkActive = _isDark() && widget.steps[index].isActive;
    switch (state) {
      case ProgressStepState.indexed:
      case ProgressStepState.disabled:
        return Text(
          '${index + 1}',
          style: isDarkActive ? _kStepStyle.copyWith(color: Colors.black87) : _kStepStyle,
        );
      case ProgressStepState.editing:
        return Container();
      case ProgressStepState.complete:
        return Icon(
          Icons.check,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 16.0,
        );
      case ProgressStepState.error:
        return const Text('!', style: _kStepStyle);
    }
  }

  Color _circleColor(int index) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    if (!_isDark()) {
      return widget.steps[index].isActive ? (widget.color ?? Color(0xFF0076BB)) : (widget.color ?? Color(0xFF0076BB)).withOpacity(0.5);
    } else {
      return widget.steps[index].isActive ? colorScheme.secondary : colorScheme.background;
    }
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _circleColor(index),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: _buildCircleChild(index, oldState && widget.steps[index].state == ProgressStepState.error),
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    return _buildCircle(index, false);
  }

  TextStyle _titleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    switch (widget.steps[index].state) {
      case ProgressStepState.indexed:
      case ProgressStepState.editing:
        return textTheme.bodyText1!.copyWith(
            fontSize: 14
        );
      case ProgressStepState.complete:
        return textTheme.bodyText1!.copyWith(
            color: _isDark() ? _kDisabledDark : _kDisabledLight,
            fontSize: 14
        );
      case ProgressStepState.disabled:
        return textTheme.bodyText1!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case ProgressStepState.error:
        return textTheme.bodyText1!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  TextStyle _subtitleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    switch (widget.steps[index].state) {
      case ProgressStepState.indexed:
      case ProgressStepState.editing:
        return textTheme.caption!.copyWith(
            fontSize: 12
        );
      case ProgressStepState.complete:
        return textTheme.caption!.copyWith(
            fontSize: 12
        );
      case ProgressStepState.disabled:
        return textTheme.caption!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case ProgressStepState.error:
        return textTheme.caption!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedDefaultTextStyle(
          style: _titleStyle(index),
          duration: kThemeAnimationDuration,
          curve: Curves.fastOutSlowIn,
          child: widget.steps[index].title,
        ),
        if (widget.steps[index].subtitle != null)
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: AnimatedDefaultTextStyle(
              style: _subtitleStyle(index),
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              child: widget.steps[index].subtitle!,
            ),
          ),
        if (widget.steps[index].remark != null)
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: AnimatedDefaultTextStyle(
              style: _subtitleStyle(index),
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              child: widget.steps[index].remark!,
            ),
          ),
      ],
    );
  }

  Widget _buildVerticalHeader(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              // Line parts are always added in order for the ink splash to
              // flood the tips of the connector lines.
              _buildIcon(index),
              _buildLine(!_isLast(index), isCompleted: (index > 0)),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 12.0),
              padding: const EdgeInsets.only(top: 4),
              child: _buildHeaderText(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVertical() {
    return ListView(
      shrinkWrap: true,
      physics: widget.physics,
      children: <Widget>[
        for (int i = 0; i < widget.steps.length; i += 1)
          Column(
            key: _keys[i],
            children: <Widget>[
              InkWell(
                onTap: widget.steps[i].state != ProgressStepState.disabled ? () {
                  // In the vertical case we need to scroll to the newly tapped
                  // step.
                  Scrollable.ensureVisible(
                    _keys[i].currentContext!,
                    curve: Curves.fastOutSlowIn,
                    duration: kThemeAnimationDuration,
                  );
                } : null,
                canRequestFocus: widget.steps[i].state != ProgressStepState.disabled,
                child: _buildVerticalHeader(i),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<TrackingProgressTree>() != null)
        throw FlutterError(
          'TrackingProgresss must not be nested.\n'
              'The material specification advises that one should avoid embedding '
              'steppers within steppers. '
              'https://material.io/archive/guidelines/components/steppers.html#steppers-usage',
        );
      return true;
    }());
    return _buildVertical();
  }
}
