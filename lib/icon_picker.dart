// Copyright 2014 The m3uzz Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library icon_picker;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A [SelectFormField] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [SelectFormField].
///
/// A [Form] ancestor is not required. The [Form] simply makes it easier to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
///
/// When a [controller] is specified, its [TextEditingController.text]
/// defines the [initialValue]. If this [FormField] is part of a scrolling
/// container that lazily constructs its children, like a [ListView] or a
/// [CustomScrollView], then a [controller] should be specified.
/// The controller's lifetime should be managed by a stateful widget ancestor
/// of the scrolling container.
///
/// If a [controller] is not specified, [initialValue] can be used to give
/// the automatically generated controller an initial value.
///
/// Remember to [dispose] of the [TextEditingController] when it is no longer needed.
/// This will ensure we discard any resources used by the object.
///
/// For a documentation about the various parameters, see [TextField].
///
/// {@tool snippet}
///
/// Creates a [SelectFormField] with an [InputDecoration] and validator function.
///
/// ![If the user enters valid text, the TextField appears normally without any warnings to the user](https://flutter.github.io/assets-for-api-docs/assets/material/text_form_field.png)
///
/// ![If the user enters invalid text, the error message returned from the validator function is displayed in dark red underneath the input](https://flutter.github.io/assets-for-api-docs/assets/material/text_form_field_error.png)
///
/// ```dart
/// SelectFormField(
///   decoration: const InputDecoration(
///     icon: Icon(Icons.person),
///     hintText: 'What do people call you?',
///     labelText: 'Name *',
///   ),
///   onSaved: (String value) {
///     // This optional block of code can be used to run
///     // code when the user saves the form.
///   },
///   validator: (String value) {
///     return value.contains('@') ? 'Do not use the @ char.' : null;
///   },
/// )
/// ```
/// {@end-tool}
///
/// {@tool dartpad --template=stateful_widget_material}
/// This example shows how to move the focus to the next field when the user
/// presses the ENTER key.
///
/// ```dart imports
/// import 'package:flutter/services.dart';
/// ```
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Material(
///     child: Center(
///       child: Shortcuts(
///         shortcuts: <LogicalKeySet, Intent>{
///           // Pressing enter on the field will now move to the next field.
///           LogicalKeySet(LogicalKeyboardKey.enter):
///               Intent(NextFocusAction.key),
///         },
///         child: FocusTraversalGroup(
///           child: Form(
///             autovalidate: true,
///             onChanged: () {
///               Form.of(primaryFocus.context).save();
///             },
///             child: Wrap(
///               children: List<Widget>.generate(5, (int index) {
///                 return Padding(
///                   padding: const EdgeInsets.all(8.0),
///                   child: ConstrainedBox(
///                     constraints: BoxConstraints.tight(Size(200, 50)),
///                     child: SelectFormField(
///                       onSaved: (String value) {
///                         print('Value for field $index saved as "$value"');
///                       },
///                     ),
///                   ),
///                 );
///               }),
///             ),
///           ),
///         ),
///       ),
///     ),
///   );
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * <https://material.io/design/components/text-fields.html>
///  * [TextField], which is the underlying text field without the [Form]
///    integration.
///  * [InputDecorator], which shows the labels and other visual elements that
///    surround the actual text editing widget.
///  * Learn how to use a [TextEditingController] in one of our [cookbook recipe]s.(https://flutter.dev/docs/cookbook/forms/text-field-changes#2-use-a-texteditingcontroller)
class IconPicker extends FormField<String> {
  /// Creates a [SelectFormField] that contains a [TextField].
  ///
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialValue] or the empty string.
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  IconPicker({
    Key key,
    this.controller,
    this.initialValue,
    this.icon,
    this.labelText,
    this.title,
    this.cancelBtn,
    this.enableSearch = true,
    this.searchHint,
    this.iconCollection = MaterialIcons.mIcons,
    FocusNode focusNode,
    InputDecoration decoration,
    TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction,
    TextStyle style,
    StrutStyle strutStyle,
    TextDirection textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions toolbarOptions,
    bool showCursor,
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType smartDashesType,
    SmartQuotesType smartQuotesType,
    bool enableSuggestions = true,
    bool autovalidate = false,
    bool maxLengthEnforced = true,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    int maxLength,
    this.onChanged,
    //GestureTapCallback onTap,
    VoidCallback onEditingComplete,
    ValueChanged<String> onFieldSubmitted,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
    bool enabled = true,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder buildCounter,
    ScrollPhysics scrollPhysics,
  })  : assert(initialValue == null || controller == null),
        assert(iconCollection != null),
        assert(textAlign != null),
        assert(autofocus != null),
        assert(readOnly != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(enableSuggestions != null),
        assert(autovalidate != null),
        assert(maxLengthEnforced != null),
        assert(scrollPadding != null),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(expands != null),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(
          !obscureText || maxLines == 1,
          'Obscured fields cannot be multiline.',
        ),
        assert(maxLength == null || maxLength > 0),
        assert(enableInteractiveSelection != null),
        super(
          key: key,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          enabled: enabled,
          builder: (FormFieldState<String> field) {
            final _IconPickerState state = field as _IconPickerState;

            final InputDecoration effectiveDecoration = (decoration ??
                InputDecoration(
                  labelText: labelText,
                  icon: state._icon ?? icon,
                  suffixIcon: Container(
                    width: 10,
                    margin: EdgeInsets.all(0),
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 15),
                      onPressed: () {},
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ));
            effectiveDecoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            void onChangedHandler(String value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            return TextField(
              controller: state._effectiveController,
              focusNode: focusNode,
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
              ),
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              textDirection: textDirection,
              textCapitalization: textCapitalization,
              autofocus: autofocus,
              toolbarOptions: toolbarOptions,
              readOnly: true,
              showCursor: showCursor,
              obscureText: obscureText,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType ??
                  (obscureText
                      ? SmartDashesType.disabled
                      : SmartDashesType.enabled),
              smartQuotesType: smartQuotesType ??
                  (obscureText
                      ? SmartQuotesType.disabled
                      : SmartQuotesType.enabled),
              enableSuggestions: enableSuggestions,
              maxLengthEnforced: maxLengthEnforced,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              maxLength: maxLength,
              onChanged: onChangedHandler,
              onTap: readOnly ? null : state._showIconPickerDialog,
              onEditingComplete: onEditingComplete,
              onSubmitted: onFieldSubmitted,
              inputFormatters: inputFormatters,
              enabled: enabled,
              cursorWidth: cursorWidth,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              scrollPadding: scrollPadding,
              scrollPhysics: scrollPhysics,
              keyboardAppearance: keyboardAppearance,
              enableInteractiveSelection: enableInteractiveSelection,
              buildCounter: buildCounter,
            );
          },
        );

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController controller;

  /// A initial icon name to display as placeholder.
  /// If the icon name exist in collection, it will set the decoration icon
  final String initialValue;

  /// An icon to display as decoration icon in input field.
  ///
  /// This icon will be changed when a new icon is picked.
  ///
  /// The size and color of the icon is configured automatically using an
  /// [IconTheme] and therefore does not need to be explicitly given in the
  /// icon widget.
  ///
  /// The trailing edge of the icon is padded by 16dps.
  ///
  /// The decoration's container is the area which is filled if [filled] is
  /// true and bordered per the [border]. It's the area adjacent to
  /// [decoration.icon] and above the widgets that contain [helperText],
  /// [errorText], and [counterText].
  ///
  /// See [Icon], [ImageIcon].
  final Widget icon;

  /// Text that describes the input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text may be entered in the input field). When the input field receives
  /// focus (or if the field is non-empty), the label moves above (i.e.,
  /// vertically adjacent to) the input field.
  final String labelText;

  /// Param to set search feature. The default value is true.
  ///
  /// If enable, an icon button will be displayed on top right of the dialog
  /// window to show a text field to type the icon name to search of.
  final bool enableSearch;

  /// If search is enable on dialog window, searchHint will be displayed
  /// as placeholder in search field.
  final String searchHint;

  /// The title of the dialog window.
  final String title;

  /// The label of the cancel button on dialog window.
  final String cancelBtn;

  /// A map of an icon collection.
  ///
  /// The default value is a collection of Material Icons.
  ///
  /// You can pass your own collection using a [Map<String, IconData>] value.
  /// ```dart
  /// Map<String, IconData> mIcons = {
  ///  'threesixty': Icons.threesixty,
  ///  'threed_rotation': Icons.threed_rotation,
  ///  'four_k': Icons.four_k,
  ///  'ac_unit': Icons.ac_unit,
  ///  ...
  /// }
  /// ```
  final Map<String, IconData> iconCollection;

  final ValueChanged<String> onChanged;

  @override
  _IconPickerState createState() => _IconPickerState();
}

class _IconPickerState extends FormFieldState<String> {
  TextEditingController _stateController;
  Widget _icon;

  @override
  IconPicker get widget => super.widget as IconPicker;

  TextEditingController get _effectiveController =>
      widget.controller ?? _stateController;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _stateController = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }

    if (_effectiveController.text != null && _effectiveController.text != '') {
      widget.iconCollection.forEach((lsName, loIcon) {
        if (lsName.contains(_effectiveController.text)) {
          setValue(
              '{"iconName": "$lsName", "codePoint": ${loIcon.codePoint}, "fontFamily": "${loIcon.fontFamily}"}');

          if (widget.icon != null && loIcon != null) {
            _icon = Icon(loIcon);
          }

          return;
        }
      });
    }
  }

  @override
  void didUpdateWidget(IconPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _stateController =
            TextEditingController.fromValue(oldWidget.controller.value);
      }

      if (widget.controller != null) {
        if (oldWidget.controller == null) {
          _stateController = null;
        }
      }
    }

    if (_effectiveController.text != null && _effectiveController.text != '') {
      widget.iconCollection.forEach((lsName, loIcon) {
        if (lsName.contains(_effectiveController.text)) {
          setValue(
              '{"iconName": "$lsName", "codePoint": ${loIcon.codePoint}, "fontFamily": "${loIcon.fontFamily}"}');

          if (widget.icon != null) {
            _icon = Icon(loIcon);
          }

          return;
        }
      });
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);

    super.dispose();
  }

  @override
  void reset() {
    super.reset();

    setState(() {
      _effectiveController.text = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  void onChangedHandler(String value) {
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }

    didChange(value);
  }

  Future<void> _showIconPickerDialog() async {
    Map<String, dynamic> lmIconPicked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return IconPickerDialog(
          title: widget.title,
          cancelBtn: widget.cancelBtn,
          iconCollection: widget.iconCollection,
          enableSearch: widget.enableSearch,
          searchHint: widget.searchHint,
        );
      },
    );

    if (lmIconPicked != null) {
      if (!mounted) return;

      int liCodePoint = lmIconPicked['icon'].codePoint;
      String lsFontFamily = lmIconPicked['icon'].fontFamily;
      String lsIconName = lmIconPicked['name'];
      _effectiveController.text = lsIconName;

      String lsValue =
          '{"iconName": "$lsIconName", "codePoint": $liCodePoint, "fontFamily": "$lsFontFamily"}';
      onChangedHandler(lsValue);

      if (widget.icon != null) {
        setState(() {
          _icon = Icon(lmIconPicked['icon']);
        });
      }
    }
  }
}

class IconPickerDialog extends StatefulWidget {
  final String title;
  final String cancelBtn;
  final bool enableSearch;
  final String searchHint;
  final Map<String, IconData> iconCollection;

  IconPickerDialog(
      {Key key,
      this.title,
      this.cancelBtn,
      this.iconCollection,
      this.enableSearch = true,
      this.searchHint})
      : super(key: key);

  @override
  _IconPickerDialogState createState() => _IconPickerDialogState();
}

class _IconPickerDialogState extends State<IconPickerDialog> {
  TextEditingController _oCtrlSearchQuery = TextEditingController();
  Map<String, IconData> _mIconsShow = <String, IconData>{};
  int _iQtIcons = -1;

  @override
  void initState() {
    super.initState();

    _oCtrlSearchQuery.addListener(_search);
    _loadIcons();
  }

  @override
  void dispose() {
    _oCtrlSearchQuery.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _titleDialog(),
      content: _content(),
      actions: <Widget>[
        FlatButton(
          padding: EdgeInsets.only(right: 20),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(widget.cancelBtn ?? 'CANCEL'),
        ),
      ],
    );
  }

  Widget _titleDialog() {
    if (!widget.enableSearch || _iQtIcons == 0) {
      return Text(widget.title);
    }

    return Column(
      children: <Widget>[
        Text(widget.title ?? 'Select an icon'),
        TextField(
          controller: _oCtrlSearchQuery,
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: widget.searchHint ?? 'Search icon',
          ),
        ),
      ],
    );
  }

  void _loadIcons() {
    setState(() {
      _mIconsShow.clear();
      _mIconsShow.addAll(widget.iconCollection);
      _iQtIcons = _mIconsShow.length;
    });
  }

  Widget _content() {
    if (_iQtIcons == -1) {
      return Center(child: CircularProgressIndicator());
    } else if (_iQtIcons == 0) {
      return _showEmpty();
    }

    return _listIcons();
  }

  Widget _listIcons() {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Wrap(
          spacing: 10,
          children: _buildIconList(),
        )
      ]),
    );
  }

  List<Widget> _buildIconList() {
    List<Widget> llIcons = <Widget>[];

    _mIconsShow.forEach((lsName, loIcon) {
      Widget loIten = IconButton(
        onPressed: () {
          Navigator.pop(context, {"name": lsName, "icon": loIcon});
        },
        icon: Icon(loIcon),
      );

      llIcons.add(loIten);
    });

    return llIcons;
  }

  Widget _showEmpty() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(0, 0),
          child: Icon(
            Icons.apps,
            size: 50,
          ),
        ),
      ],
    );
  }

  void _search() {
    String lsQuery = _oCtrlSearchQuery.text;

    if (lsQuery.length > 2) {
      lsQuery.toLowerCase();

      setState(() {
        _mIconsShow.clear();

        widget.iconCollection.forEach((lsName, loIcon) {
          if (lsName.contains(lsQuery)) {
            _mIconsShow[lsName] = loIcon;
          }
        });

        _iQtIcons = _mIconsShow.length;
      });
    } else {
      setState(() {
        _mIconsShow.clear();
        _mIconsShow.addAll(widget.iconCollection);

        _iQtIcons = _mIconsShow.length;
      });
    }
  }
}

class MaterialIcons {
  static const Map<String, IconData> mIcons = {
    'threesixty': Icons.threesixty,
    'threed_rotation': Icons.threed_rotation,
    'four_k': Icons.four_k,
    'ac_unit': Icons.ac_unit,
    'access_alarm': Icons.access_alarm,
    'access_alarms': Icons.access_alarms,
    'access_time': Icons.access_time,
    'accessibility': Icons.accessibility,
    'accessibility_new': Icons.accessibility_new,
    'accessible': Icons.accessible,
    'accessible_forward': Icons.accessible_forward,
    'account_balance': Icons.account_balance,
    'account_balance_wallet': Icons.account_balance_wallet,
    'account_box': Icons.account_box,
    'account_circle': Icons.account_circle,
    'adb': Icons.adb,
    'add': Icons.add,
    'add_a_photo': Icons.add_a_photo,
    'add_alarm': Icons.add_alarm,
    'add_alert': Icons.add_alert,
    'add_box': Icons.add_box,
    'add_call': Icons.add_call,
    'add_circle': Icons.add_circle,
    'add_circle_outline': Icons.add_circle_outline,
    'add_comment': Icons.add_comment,
    'add_location': Icons.add_location,
    'add_photo_alternate': Icons.add_photo_alternate,
    'add_shopping_cart': Icons.add_shopping_cart,
    'add_to_home_screen': Icons.add_to_home_screen,
    'add_to_photos': Icons.add_to_photos,
    'add_to_queue': Icons.add_to_queue,
    'adjust': Icons.adjust,
    'airline_seat_flat': Icons.airline_seat_flat,
    'airline_seat_flat_angled': Icons.airline_seat_flat_angled,
    'airline_seat_individual_suite': Icons.airline_seat_individual_suite,
    'airline_seat_legroom_extra': Icons.airline_seat_legroom_extra,
    'airline_seat_legroom_normal': Icons.airline_seat_legroom_normal,
    'airline_seat_legroom_reduced': Icons.airline_seat_legroom_reduced,
    'airline_seat_recline_extra': Icons.airline_seat_recline_extra,
    'airline_seat_recline_normal': Icons.airline_seat_recline_normal,
    'airplanemode_active': Icons.airplanemode_active,
    'airplanemode_inactive': Icons.airplanemode_inactive,
    'airplay': Icons.airplay,
    'airport_shuttle': Icons.airport_shuttle,
    'alarm': Icons.alarm,
    'alarm_add': Icons.alarm_add,
    'alarm_off': Icons.alarm_off,
    'alarm_on': Icons.alarm_on,
    'album': Icons.album,
    'all_inclusive': Icons.all_inclusive,
    'all_out': Icons.all_out,
    'alternate_email': Icons.alternate_email,
    'android': Icons.android,
    'announcement': Icons.announcement,
    'apps': Icons.apps,
    'archive': Icons.archive,
    'arrow_back': Icons.arrow_back,
    'arrow_back_ios': Icons.arrow_back_ios,
    'arrow_downward': Icons.arrow_downward,
    'arrow_drop_down': Icons.arrow_drop_down,
    'arrow_drop_down_circle': Icons.arrow_drop_down_circle,
    'arrow_drop_up': Icons.arrow_drop_up,
    'arrow_forward': Icons.arrow_forward,
    'arrow_forward_ios': Icons.arrow_forward_ios,
    'arrow_left': Icons.arrow_left,
    'arrow_right': Icons.arrow_right,
    'arrow_upward': Icons.arrow_upward,
    'art_track': Icons.art_track,
    'aspect_ratio': Icons.aspect_ratio,
    'assessment': Icons.assessment,
    'assignment': Icons.assignment,
    'assignment_ind': Icons.assignment_ind,
    'assignment_late': Icons.assignment_late,
    'assignment_return': Icons.assignment_return,
    'assignment_returned': Icons.assignment_returned,
    'assignment_turned_in': Icons.assignment_turned_in,
    'assistant': Icons.assistant,
    'assistant_photo': Icons.assistant_photo,
    'atm': Icons.atm,
    'attach_file': Icons.attach_file,
    'attach_money': Icons.attach_money,
    'attachment': Icons.attachment,
    'audiotrack': Icons.audiotrack,
    'autorenew': Icons.autorenew,
    'av_timer': Icons.av_timer,
    'backspace': Icons.backspace,
    'backup': Icons.backup,
    'battery_alert': Icons.battery_alert,
    'battery_charging_full': Icons.battery_charging_full,
    'battery_full': Icons.battery_full,
    'battery_std': Icons.battery_std,
    'battery_unknown': Icons.battery_unknown,
    'beach_access': Icons.beach_access,
    'beenhere': Icons.beenhere,
    'block': Icons.block,
    'bluetooth': Icons.bluetooth,
    'bluetooth_audio': Icons.bluetooth_audio,
    'bluetooth_connected': Icons.bluetooth_connected,
    'bluetooth_disabled': Icons.bluetooth_disabled,
    'bluetooth_searching': Icons.bluetooth_searching,
    'blur_circular': Icons.blur_circular,
    'blur_linear': Icons.blur_linear,
    'blur_off': Icons.blur_off,
    'blur_on': Icons.blur_on,
    'book': Icons.book,
    'bookmark': Icons.bookmark,
    'bookmark_border': Icons.bookmark_border,
    'border_all': Icons.border_all,
    'border_bottom': Icons.border_bottom,
    'border_clear': Icons.border_clear,
    'border_color': Icons.border_color,
    'border_horizontal': Icons.border_horizontal,
    'border_inner': Icons.border_inner,
    'border_left': Icons.border_left,
    'border_outer': Icons.border_outer,
    'border_right': Icons.border_right,
    'border_style': Icons.border_style,
    'border_top': Icons.border_top,
    'border_vertical': Icons.border_vertical,
    'branding_watermark': Icons.branding_watermark,
    'brightness_1': Icons.brightness_1,
    'brightness_2': Icons.brightness_2,
    'brightness_3': Icons.brightness_3,
    'brightness_4': Icons.brightness_4,
    'brightness_5': Icons.brightness_5,
    'brightness_6': Icons.brightness_6,
    'brightness_7': Icons.brightness_7,
    'brightness_auto': Icons.brightness_auto,
    'brightness_high': Icons.brightness_high,
    'brightness_low': Icons.brightness_low,
    'brightness_medium': Icons.brightness_medium,
    'broken_image': Icons.broken_image,
    'brush': Icons.brush,
    'bubble_chart': Icons.bubble_chart,
    'bug_report': Icons.bug_report,
    'build': Icons.build,
    'burst_mode': Icons.burst_mode,
    'business': Icons.business,
    'business_center': Icons.business_center,
    'cached': Icons.cached,
    'cake': Icons.cake,
    'calendar_today': Icons.calendar_today,
    'calendar_view_day': Icons.calendar_view_day,
    'call': Icons.call,
    'call_end': Icons.call_end,
    'call_made': Icons.call_made,
    'call_merge': Icons.call_merge,
    'call_missed': Icons.call_missed,
    'call_missed_outgoing': Icons.call_missed_outgoing,
    'call_received': Icons.call_received,
    'call_split': Icons.call_split,
    'call_to_action': Icons.call_to_action,
    'camera': Icons.camera,
    'camera_alt': Icons.camera_alt,
    'camera_enhance': Icons.camera_enhance,
    'camera_front': Icons.camera_front,
    'camera_rear': Icons.camera_rear,
    'camera_roll': Icons.camera_roll,
    'cancel': Icons.cancel,
    'card_giftcard': Icons.card_giftcard,
    'card_membership': Icons.card_membership,
    'card_travel': Icons.card_travel,
    'casino': Icons.casino,
    'cast': Icons.cast,
    'cast_connected': Icons.cast_connected,
    'category': Icons.category,
    'center_focus_strong': Icons.center_focus_strong,
    'center_focus_weak': Icons.center_focus_weak,
    'change_history': Icons.change_history,
    'chat': Icons.chat,
    'chat_bubble': Icons.chat_bubble,
    'chat_bubble_outline': Icons.chat_bubble_outline,
    'check': Icons.check,
    'check_box': Icons.check_box,
    'check_box_outline_blank': Icons.check_box_outline_blank,
    'check_circle': Icons.check_circle,
    'check_circle_outline': Icons.check_circle_outline,
    'chevron_left': Icons.chevron_left,
    'chevron_right': Icons.chevron_right,
    'child_care': Icons.child_care,
    'child_friendly': Icons.child_friendly,
    'chrome_reader_mode': Icons.chrome_reader_mode,
    'class_': Icons.class_,
    'clear': Icons.clear,
    'clear_all': Icons.clear_all,
    'close': Icons.close,
    'closed_caption': Icons.closed_caption,
    'cloud': Icons.cloud,
    'cloud_circle': Icons.cloud_circle,
    'cloud_done': Icons.cloud_done,
    'cloud_download': Icons.cloud_download,
    'cloud_off': Icons.cloud_off,
    'cloud_queue': Icons.cloud_queue,
    'cloud_upload': Icons.cloud_upload,
    'code': Icons.code,
    'collections': Icons.collections,
    'collections_bookmark': Icons.collections_bookmark,
    'color_lens': Icons.color_lens,
    'colorize': Icons.colorize,
    'comment': Icons.comment,
    'compare': Icons.compare,
    'compare_arrows': Icons.compare_arrows,
    'computer': Icons.computer,
    'confirmation_number': Icons.confirmation_number,
    'contact_mail': Icons.contact_mail,
    'contact_phone': Icons.contact_phone,
    'contacts': Icons.contacts,
    'content_copy': Icons.content_copy,
    'content_cut': Icons.content_cut,
    'content_paste': Icons.content_paste,
    'control_point': Icons.control_point,
    'control_point_duplicate': Icons.control_point_duplicate,
    'copyright': Icons.copyright,
    'create': Icons.create,
    'create_new_folder': Icons.create_new_folder,
    'credit_card': Icons.credit_card,
    'crop': Icons.crop,
    'crop_16_9': Icons.crop_16_9,
    'crop_3_2': Icons.crop_3_2,
    'crop_5_4': Icons.crop_5_4,
    'crop_7_5': Icons.crop_7_5,
    'crop_din': Icons.crop_din,
    'crop_free': Icons.crop_free,
    'crop_landscape': Icons.crop_landscape,
    'crop_original': Icons.crop_original,
    'crop_portrait': Icons.crop_portrait,
    'crop_rotate': Icons.crop_rotate,
    'crop_square': Icons.crop_square,
    'dashboard': Icons.dashboard,
    'data_usage': Icons.data_usage,
    'date_range': Icons.date_range,
    'dehaze': Icons.dehaze,
    'delete': Icons.delete,
    'delete_forever': Icons.delete_forever,
    'delete_outline': Icons.delete_outline,
    'delete_sweep': Icons.delete_sweep,
    'departure_board': Icons.departure_board,
    'description': Icons.description,
    'desktop_mac': Icons.desktop_mac,
    'desktop_windows': Icons.desktop_windows,
    'details': Icons.details,
    'developer_board': Icons.developer_board,
    'developer_mode': Icons.developer_mode,
    'device_hub': Icons.device_hub,
    'device_unknown': Icons.device_unknown,
    'devices': Icons.devices,
    'devices_other': Icons.devices_other,
    'dialer_sip': Icons.dialer_sip,
    'dialpad': Icons.dialpad,
    'directions': Icons.directions,
    'directions_bike': Icons.directions_bike,
    'directions_boat': Icons.directions_boat,
    'directions_bus': Icons.directions_bus,
    'directions_car': Icons.directions_car,
    'directions_railway': Icons.directions_railway,
    'directions_run': Icons.directions_run,
    'directions_subway': Icons.directions_subway,
    'directions_transit': Icons.directions_transit,
    'directions_walk': Icons.directions_walk,
    'disc_full': Icons.disc_full,
    'dns': Icons.dns,
    'do_not_disturb': Icons.do_not_disturb,
    'do_not_disturb_alt': Icons.do_not_disturb_alt,
    'do_not_disturb_off': Icons.do_not_disturb_off,
    'do_not_disturb_on': Icons.do_not_disturb_on,
    'dock': Icons.dock,
    'domain': Icons.domain,
    'done': Icons.done,
    'done_all': Icons.done_all,
    'done_outline': Icons.done_outline,
    'donut_large': Icons.donut_large,
    'donut_small': Icons.donut_small,
    'drafts': Icons.drafts,
    'drag_handle': Icons.drag_handle,
    'drive_eta': Icons.drive_eta,
    'dvr': Icons.dvr,
    'edit': Icons.edit,
    'edit_attributes': Icons.edit_attributes,
    'edit_location': Icons.edit_location,
    'eject': Icons.eject,
    'email': Icons.email,
    'enhanced_encryption': Icons.enhanced_encryption,
    'equalizer': Icons.equalizer,
    'error': Icons.error,
    'error_outline': Icons.error_outline,
    'euro_symbol': Icons.euro_symbol,
    'ev_station': Icons.ev_station,
    'event': Icons.event,
    'event_available': Icons.event_available,
    'event_busy': Icons.event_busy,
    'event_note': Icons.event_note,
    'event_seat': Icons.event_seat,
    'exit_to_app': Icons.exit_to_app,
    'expand_less': Icons.expand_less,
    'expand_more': Icons.expand_more,
    'explicit': Icons.explicit,
    'explore': Icons.explore,
    'exposure': Icons.exposure,
    'exposure_neg_1': Icons.exposure_neg_1,
    'exposure_neg_2': Icons.exposure_neg_2,
    'exposure_plus_1': Icons.exposure_plus_1,
    'exposure_plus_2': Icons.exposure_plus_2,
    'exposure_zero': Icons.exposure_zero,
    'extension': Icons.extension,
    'face': Icons.face,
    'fast_forward': Icons.fast_forward,
    'fast_rewind': Icons.fast_rewind,
    'fastfood': Icons.fastfood,
    'favorite': Icons.favorite,
    'favorite_border': Icons.favorite_border,
    'featured_play_list': Icons.featured_play_list,
    'featured_video': Icons.featured_video,
    'feedback': Icons.feedback,
    'fiber_dvr': Icons.fiber_dvr,
    'fiber_manual_record': Icons.fiber_manual_record,
    'fiber_new': Icons.fiber_new,
    'fiber_pin': Icons.fiber_pin,
    'fiber_smart_record': Icons.fiber_smart_record,
    'file_download': Icons.file_download,
    'file_upload': Icons.file_upload,
    'filter': Icons.filter,
    'filter_1': Icons.filter_1,
    'filter_2': Icons.filter_2,
    'filter_3': Icons.filter_3,
    'filter_4': Icons.filter_4,
    'filter_5': Icons.filter_5,
    'filter_6': Icons.filter_6,
    'filter_7': Icons.filter_7,
    'filter_8': Icons.filter_8,
    'filter_9': Icons.filter_9,
    'filter_9_plus': Icons.filter_9_plus,
    'filter_b_and_w': Icons.filter_b_and_w,
    'filter_center_focus': Icons.filter_center_focus,
    'filter_drama': Icons.filter_drama,
    'filter_frames': Icons.filter_frames,
    'filter_hdr': Icons.filter_hdr,
    'filter_list': Icons.filter_list,
    'filter_none': Icons.filter_none,
    'filter_tilt_shift': Icons.filter_tilt_shift,
    'filter_vintage': Icons.filter_vintage,
    'find_in_page': Icons.find_in_page,
    'find_replace': Icons.find_replace,
    'fingerprint': Icons.fingerprint,
    'first_page': Icons.first_page,
    'fitness_center': Icons.fitness_center,
    'flag': Icons.flag,
    'flare': Icons.flare,
    'flash_auto': Icons.flash_auto,
    'flash_off': Icons.flash_off,
    'flash_on': Icons.flash_on,
    'flight': Icons.flight,
    'flight_land': Icons.flight_land,
    'flight_takeoff': Icons.flight_takeoff,
    'flip': Icons.flip,
    'flip_to_back': Icons.flip_to_back,
    'flip_to_front': Icons.flip_to_front,
    'folder': Icons.folder,
    'folder_open': Icons.folder_open,
    'folder_shared': Icons.folder_shared,
    'folder_special': Icons.folder_special,
    'font_download': Icons.font_download,
    'format_align_center': Icons.format_align_center,
    'format_align_justify': Icons.format_align_justify,
    'format_align_left': Icons.format_align_left,
    'format_align_right': Icons.format_align_right,
    'format_bold': Icons.format_bold,
    'format_clear': Icons.format_clear,
    'format_color_fill': Icons.format_color_fill,
    'format_color_reset': Icons.format_color_reset,
    'format_color_text': Icons.format_color_text,
    'format_indent_decrease': Icons.format_indent_decrease,
    'format_indent_increase': Icons.format_indent_increase,
    'format_italic': Icons.format_italic,
    'format_line_spacing': Icons.format_line_spacing,
    'format_list_bulleted': Icons.format_list_bulleted,
    'format_list_numbered': Icons.format_list_numbered,
    'format_list_numbered_rtl': Icons.format_list_numbered_rtl,
    'format_paint': Icons.format_paint,
    'format_quote': Icons.format_quote,
    'format_shapes': Icons.format_shapes,
    'format_size': Icons.format_size,
    'format_strikethrough': Icons.format_strikethrough,
    'format_textdirection_l_to_r': Icons.format_textdirection_l_to_r,
    'format_textdirection_r_to_l': Icons.format_textdirection_r_to_l,
    'format_underlined': Icons.format_underlined,
    'forum': Icons.forum,
    'forward': Icons.forward,
    'forward_10': Icons.forward_10,
    'forward_30': Icons.forward_30,
    'forward_5': Icons.forward_5,
    'free_breakfast': Icons.free_breakfast,
    'fullscreen': Icons.fullscreen,
    'fullscreen_exit': Icons.fullscreen_exit,
    'functions': Icons.functions,
    'g_translate': Icons.g_translate,
    'gamepad': Icons.gamepad,
    'games': Icons.games,
    'gavel': Icons.gavel,
    'gesture': Icons.gesture,
    'get_app': Icons.get_app,
    'gif': Icons.gif,
    'golf_course': Icons.golf_course,
    'gps_fixed': Icons.gps_fixed,
    'gps_not_fixed': Icons.gps_not_fixed,
    'gps_off': Icons.gps_off,
    'grade': Icons.grade,
    'gradient': Icons.gradient,
    'grain': Icons.grain,
    'graphic_eq': Icons.graphic_eq,
    'grid_off': Icons.grid_off,
    'grid_on': Icons.grid_on,
    'group': Icons.group,
    'group_add': Icons.group_add,
    'group_work': Icons.group_work,
    'hd': Icons.hd,
    'hdr_off': Icons.hdr_off,
    'hdr_on': Icons.hdr_on,
    'hdr_strong': Icons.hdr_strong,
    'hdr_weak': Icons.hdr_weak,
    'headset': Icons.headset,
    'headset_mic': Icons.headset_mic,
    'headset_off': Icons.headset_off,
    'healing': Icons.healing,
    'hearing': Icons.hearing,
    'help': Icons.help,
    'help_outline': Icons.help_outline,
    'high_quality': Icons.high_quality,
    'highlight': Icons.highlight,
    'highlight_off': Icons.highlight_off,
    'history': Icons.history,
    'home': Icons.home,
    'hot_tub': Icons.hot_tub,
    'hotel': Icons.hotel,
    'hourglass_empty': Icons.hourglass_empty,
    'hourglass_full': Icons.hourglass_full,
    'http': Icons.http,
    'https': Icons.https,
    'image': Icons.image,
    'image_aspect_ratio': Icons.image_aspect_ratio,
    'import_contacts': Icons.import_contacts,
    'import_export': Icons.import_export,
    'important_devices': Icons.important_devices,
    'inbox': Icons.inbox,
    'indeterminate_check_box': Icons.indeterminate_check_box,
    'info': Icons.info,
    'info_outline': Icons.info_outline,
    'input': Icons.input,
    'insert_chart': Icons.insert_chart,
    'insert_comment': Icons.insert_comment,
    'insert_drive_file': Icons.insert_drive_file,
    'insert_emoticon': Icons.insert_emoticon,
    'insert_invitation': Icons.insert_invitation,
    'insert_link': Icons.insert_link,
    'insert_photo': Icons.insert_photo,
    'invert_colors': Icons.invert_colors,
    'invert_colors_off': Icons.invert_colors_off,
    'iso': Icons.iso,
    'keyboard': Icons.keyboard,
    'keyboard_arrow_down': Icons.keyboard_arrow_down,
    'keyboard_arrow_left': Icons.keyboard_arrow_left,
    'keyboard_arrow_right': Icons.keyboard_arrow_right,
    'keyboard_arrow_up': Icons.keyboard_arrow_up,
    'keyboard_backspace': Icons.keyboard_backspace,
    'keyboard_capslock': Icons.keyboard_capslock,
    'keyboard_hide': Icons.keyboard_hide,
    'keyboard_return': Icons.keyboard_return,
    'keyboard_tab': Icons.keyboard_tab,
    'keyboard_voice': Icons.keyboard_voice,
    'kitchen': Icons.kitchen,
    'label': Icons.label,
    'label_important': Icons.label_important,
    'label_outline': Icons.label_outline,
    'landscape': Icons.landscape,
    'language': Icons.language,
    'laptop': Icons.laptop,
    'laptop_chromebook': Icons.laptop_chromebook,
    'laptop_mac': Icons.laptop_mac,
    'laptop_windows': Icons.laptop_windows,
    'last_page': Icons.last_page,
    'launch': Icons.launch,
    'layers': Icons.layers,
    'layers_clear': Icons.layers_clear,
    'leak_add': Icons.leak_add,
    'leak_remove': Icons.leak_remove,
    'lens': Icons.lens,
    'library_add': Icons.library_add,
    'library_books': Icons.library_books,
    'library_music': Icons.library_music,
    'lightbulb_outline': Icons.lightbulb_outline,
    'line_style': Icons.line_style,
    'line_weight': Icons.line_weight,
    'linear_scale': Icons.linear_scale,
    'link': Icons.link,
    'link_off': Icons.link_off,
    'linked_camera': Icons.linked_camera,
    'list': Icons.list,
    'live_help': Icons.live_help,
    'live_tv': Icons.live_tv,
    'local_activity': Icons.local_activity,
    'local_airport': Icons.local_airport,
    'local_atm': Icons.local_atm,
    'local_bar': Icons.local_bar,
    'local_cafe': Icons.local_cafe,
    'local_car_wash': Icons.local_car_wash,
    'local_convenience_store': Icons.local_convenience_store,
    'local_dining': Icons.local_dining,
    'local_drink': Icons.local_drink,
    'local_florist': Icons.local_florist,
    'local_gas_station': Icons.local_gas_station,
    'local_grocery_store': Icons.local_grocery_store,
    'local_hospital': Icons.local_hospital,
    'local_hotel': Icons.local_hotel,
    'local_laundry_service': Icons.local_laundry_service,
    'local_library': Icons.local_library,
    'local_mall': Icons.local_mall,
    'local_movies': Icons.local_movies,
    'local_offer': Icons.local_offer,
    'local_parking': Icons.local_parking,
    'local_pharmacy': Icons.local_pharmacy,
    'local_phone': Icons.local_phone,
    'local_pizza': Icons.local_pizza,
    'local_play': Icons.local_play,
    'local_post_office': Icons.local_post_office,
    'local_printshop': Icons.local_printshop,
    'local_see': Icons.local_see,
    'local_shipping': Icons.local_shipping,
    'local_taxi': Icons.local_taxi,
    'location_city': Icons.location_city,
    'location_disabled': Icons.location_disabled,
    'location_off': Icons.location_off,
    'location_on': Icons.location_on,
    'location_searching': Icons.location_searching,
    'lock': Icons.lock,
    'lock_open': Icons.lock_open,
    'lock_outline': Icons.lock_outline,
    'looks': Icons.looks,
    'looks_3': Icons.looks_3,
    'looks_4': Icons.looks_4,
    'looks_5': Icons.looks_5,
    'looks_6': Icons.looks_6,
    'looks_one': Icons.looks_one,
    'looks_two': Icons.looks_two,
    'loop': Icons.loop,
    'loupe': Icons.loupe,
    'low_priority': Icons.low_priority,
    'loyalty': Icons.loyalty,
    'mail': Icons.mail,
    'mail_outline': Icons.mail_outline,
    'map': Icons.map,
    'markunread': Icons.markunread,
    'markunread_mailbox': Icons.markunread_mailbox,
    'maximize': Icons.maximize,
    'memory': Icons.memory,
    'menu': Icons.menu,
    'merge_type': Icons.merge_type,
    'message': Icons.message,
    'mic': Icons.mic,
    'mic_none': Icons.mic_none,
    'mic_off': Icons.mic_off,
    'minimize': Icons.minimize,
    'missed_video_call': Icons.missed_video_call,
    'mms': Icons.mms,
    'mobile_screen_share': Icons.mobile_screen_share,
    'mode_comment': Icons.mode_comment,
    'mode_edit': Icons.mode_edit,
    'monetization_on': Icons.monetization_on,
    'money_off': Icons.money_off,
    'monochrome_photos': Icons.monochrome_photos,
    'mood': Icons.mood,
    'mood_bad': Icons.mood_bad,
    'more': Icons.more,
    'more_horiz': Icons.more_horiz,
    'more_vert': Icons.more_vert,
    'motorcycle': Icons.motorcycle,
    'mouse': Icons.mouse,
    'move_to_inbox': Icons.move_to_inbox,
    'movie': Icons.movie,
    'movie_creation': Icons.movie_creation,
    'movie_filter': Icons.movie_filter,
    'multiline_chart': Icons.multiline_chart,
    'music_note': Icons.music_note,
    'music_video': Icons.music_video,
    'my_location': Icons.my_location,
    'nature': Icons.nature,
    'nature_people': Icons.nature_people,
    'navigate_before': Icons.navigate_before,
    'navigate_next': Icons.navigate_next,
    'navigation': Icons.navigation,
    'near_me': Icons.near_me,
    'network_cell': Icons.network_cell,
    'network_check': Icons.network_check,
    'network_locked': Icons.network_locked,
    'network_wifi': Icons.network_wifi,
    'new_releases': Icons.new_releases,
    'next_week': Icons.next_week,
    'nfc': Icons.nfc,
    'no_encryption': Icons.no_encryption,
    'no_sim': Icons.no_sim,
    'not_interested': Icons.not_interested,
    'not_listed_location': Icons.not_listed_location,
    'note': Icons.note,
    'note_add': Icons.note_add,
    'notification_important': Icons.notification_important,
    'notifications': Icons.notifications,
    'notifications_active': Icons.notifications_active,
    'notifications_none': Icons.notifications_none,
    'notifications_off': Icons.notifications_off,
    'notifications_paused': Icons.notifications_paused,
    'offline_bolt': Icons.offline_bolt,
    'offline_pin': Icons.offline_pin,
    'ondemand_video': Icons.ondemand_video,
    'opacity': Icons.opacity,
    'open_in_browser': Icons.open_in_browser,
    'open_in_new': Icons.open_in_new,
    'open_with': Icons.open_with,
    'outlined_flag': Icons.outlined_flag,
    'pages': Icons.pages,
    'pageview': Icons.pageview,
    'palette': Icons.palette,
    'pan_tool': Icons.pan_tool,
    'panorama': Icons.panorama,
    'panorama_fish_eye': Icons.panorama_fish_eye,
    'panorama_horizontal': Icons.panorama_horizontal,
    'panorama_vertical': Icons.panorama_vertical,
    'panorama_wide_angle': Icons.panorama_wide_angle,
    'party_mode': Icons.party_mode,
    'pause': Icons.pause,
    'pause_circle_filled': Icons.pause_circle_filled,
    'pause_circle_outline': Icons.pause_circle_outline,
    'payment': Icons.payment,
    'people': Icons.people,
    'people_outline': Icons.people_outline,
    'perm_camera_mic': Icons.perm_camera_mic,
    'perm_contact_calendar': Icons.perm_contact_calendar,
    'perm_data_setting': Icons.perm_data_setting,
    'perm_device_information': Icons.perm_device_information,
    'perm_identity': Icons.perm_identity,
    'perm_media': Icons.perm_media,
    'perm_phone_msg': Icons.perm_phone_msg,
    'perm_scan_wifi': Icons.perm_scan_wifi,
    'person': Icons.person,
    'person_add': Icons.person_add,
    'person_outline': Icons.person_outline,
    'person_pin': Icons.person_pin,
    'person_pin_circle': Icons.person_pin_circle,
    'personal_video': Icons.personal_video,
    'pets': Icons.pets,
    'phone': Icons.phone,
    'phone_android': Icons.phone_android,
    'phone_bluetooth_speaker': Icons.phone_bluetooth_speaker,
    'phone_forwarded': Icons.phone_forwarded,
    'phone_in_talk': Icons.phone_in_talk,
    'phone_iphone': Icons.phone_iphone,
    'phone_locked': Icons.phone_locked,
    'phone_missed': Icons.phone_missed,
    'phone_paused': Icons.phone_paused,
    'phonelink': Icons.phonelink,
    'phonelink_erase': Icons.phonelink_erase,
    'phonelink_lock': Icons.phonelink_lock,
    'phonelink_off': Icons.phonelink_off,
    'phonelink_ring': Icons.phonelink_ring,
    'phonelink_setup': Icons.phonelink_setup,
    'photo': Icons.photo,
    'photo_album': Icons.photo_album,
    'photo_camera': Icons.photo_camera,
    'photo_filter': Icons.photo_filter,
    'photo_library': Icons.photo_library,
    'photo_size_select_actual': Icons.photo_size_select_actual,
    'photo_size_select_large': Icons.photo_size_select_large,
    'photo_size_select_small': Icons.photo_size_select_small,
    'picture_as_pdf': Icons.picture_as_pdf,
    'picture_in_picture': Icons.picture_in_picture,
    'picture_in_picture_alt': Icons.picture_in_picture_alt,
    'pie_chart': Icons.pie_chart,
    'pie_chart_outlined': Icons.pie_chart_outlined,
    'pin_drop': Icons.pin_drop,
    'place': Icons.place,
    'play_arrow': Icons.play_arrow,
    'play_circle_filled': Icons.play_circle_filled,
    'play_circle_outline': Icons.play_circle_outline,
    'play_for_work': Icons.play_for_work,
    'playlist_add': Icons.playlist_add,
    'playlist_add_check': Icons.playlist_add_check,
    'playlist_play': Icons.playlist_play,
    'plus_one': Icons.plus_one,
    'poll': Icons.poll,
    'polymer': Icons.polymer,
    'pool': Icons.pool,
    'portable_wifi_off': Icons.portable_wifi_off,
    'portrait': Icons.portrait,
    'power': Icons.power,
    'power_input': Icons.power_input,
    'power_settings_new': Icons.power_settings_new,
    'pregnant_woman': Icons.pregnant_woman,
    'present_to_all': Icons.present_to_all,
    'print': Icons.print,
    'priority_high': Icons.priority_high,
    'public': Icons.public,
    'publish': Icons.publish,
    'query_builder': Icons.query_builder,
    'question_answer': Icons.question_answer,
    'queue': Icons.queue,
    'queue_music': Icons.queue_music,
    'queue_play_next': Icons.queue_play_next,
    'radio': Icons.radio,
    'radio_button_checked': Icons.radio_button_checked,
    'radio_button_unchecked': Icons.radio_button_unchecked,
    'rate_review': Icons.rate_review,
    'receipt': Icons.receipt,
    'recent_actors': Icons.recent_actors,
    'record_voice_over': Icons.record_voice_over,
    'redeem': Icons.redeem,
    'redo': Icons.redo,
    'refresh': Icons.refresh,
    'remove': Icons.remove,
    'remove_circle': Icons.remove_circle,
    'remove_circle_outline': Icons.remove_circle_outline,
    'remove_from_queue': Icons.remove_from_queue,
    'remove_red_eye': Icons.remove_red_eye,
    'remove_shopping_cart': Icons.remove_shopping_cart,
    'reorder': Icons.reorder,
    'repeat': Icons.repeat,
    'repeat_one': Icons.repeat_one,
    'replay': Icons.replay,
    'replay_10': Icons.replay_10,
    'replay_30': Icons.replay_30,
    'replay_5': Icons.replay_5,
    'reply': Icons.reply,
    'reply_all': Icons.reply_all,
    'report': Icons.report,
    'report_off': Icons.report_off,
    'report_problem': Icons.report_problem,
    'restaurant': Icons.restaurant,
    'restaurant_menu': Icons.restaurant_menu,
    'restore': Icons.restore,
    'restore_from_trash': Icons.restore_from_trash,
    'restore_page': Icons.restore_page,
    'ring_volume': Icons.ring_volume,
    'room': Icons.room,
    'room_service': Icons.room_service,
    'rotate_90_degrees_ccw': Icons.rotate_90_degrees_ccw,
    'rotate_left': Icons.rotate_left,
    'rotate_right': Icons.rotate_right,
    'rounded_corner': Icons.rounded_corner,
    'router': Icons.router,
    'rowing': Icons.rowing,
    'rss_feed': Icons.rss_feed,
    'rv_hookup': Icons.rv_hookup,
    'satellite': Icons.satellite,
    'save': Icons.save,
    'save_alt': Icons.save_alt,
    'scanner': Icons.scanner,
    'scatter_plot': Icons.scatter_plot,
    'schedule': Icons.schedule,
    'school': Icons.school,
    'score': Icons.score,
    'screen_lock_landscape': Icons.screen_lock_landscape,
    'screen_lock_portrait': Icons.screen_lock_portrait,
    'screen_lock_rotation': Icons.screen_lock_rotation,
    'screen_rotation': Icons.screen_rotation,
    'screen_share': Icons.screen_share,
    'sd_card': Icons.sd_card,
    'sd_storage': Icons.sd_storage,
    'search': Icons.search,
    'security': Icons.security,
    'select_all': Icons.select_all,
    'send': Icons.send,
    'sentiment_dissatisfied': Icons.sentiment_dissatisfied,
    'sentiment_neutral': Icons.sentiment_neutral,
    'sentiment_satisfied': Icons.sentiment_satisfied,
    'sentiment_very_dissatisfied': Icons.sentiment_very_dissatisfied,
    'sentiment_very_satisfied': Icons.sentiment_very_satisfied,
    'settings': Icons.settings,
    'settings_applications': Icons.settings_applications,
    'settings_backup_restore': Icons.settings_backup_restore,
    'settings_bluetooth': Icons.settings_bluetooth,
    'settings_brightness': Icons.settings_brightness,
    'settings_cell': Icons.settings_cell,
    'settings_ethernet': Icons.settings_ethernet,
    'settings_input_antenna': Icons.settings_input_antenna,
    'settings_input_component': Icons.settings_input_component,
    'settings_input_composite': Icons.settings_input_composite,
    'settings_input_hdmi': Icons.settings_input_hdmi,
    'settings_input_svideo': Icons.settings_input_svideo,
    'settings_overscan': Icons.settings_overscan,
    'settings_phone': Icons.settings_phone,
    'settings_power': Icons.settings_power,
    'settings_remote': Icons.settings_remote,
    'settings_system_daydream': Icons.settings_system_daydream,
    'settings_voice': Icons.settings_voice,
    'share': Icons.share,
    'shop': Icons.shop,
    'shop_two': Icons.shop_two,
    'shopping_basket': Icons.shopping_basket,
    'shopping_cart': Icons.shopping_cart,
    'short_text': Icons.short_text,
    'show_chart': Icons.show_chart,
    'shuffle': Icons.shuffle,
    'shutter_speed': Icons.shutter_speed,
    'signal_cellular_4_bar': Icons.signal_cellular_4_bar,
    'signal_cellular_connected_no_internet_4_bar':
        Icons.signal_cellular_connected_no_internet_4_bar,
    'signal_cellular_no_sim': Icons.signal_cellular_no_sim,
    'signal_cellular_null': Icons.signal_cellular_null,
    'signal_cellular_off': Icons.signal_cellular_off,
    'signal_wifi_4_bar': Icons.signal_wifi_4_bar,
    'signal_wifi_4_bar_lock': Icons.signal_wifi_4_bar_lock,
    'signal_wifi_off': Icons.signal_wifi_off,
    'sim_card': Icons.sim_card,
    'sim_card_alert': Icons.sim_card_alert,
    'skip_next': Icons.skip_next,
    'skip_previous': Icons.skip_previous,
    'slideshow': Icons.slideshow,
    'slow_motion_video': Icons.slow_motion_video,
    'smartphone': Icons.smartphone,
    'smoke_free': Icons.smoke_free,
    'smoking_rooms': Icons.smoking_rooms,
    'sms': Icons.sms,
    'sms_failed': Icons.sms_failed,
    'snooze': Icons.snooze,
    'sort': Icons.sort,
    'sort_by_alpha': Icons.sort_by_alpha,
    'spa': Icons.spa,
    'space_bar': Icons.space_bar,
    'speaker': Icons.speaker,
    'speaker_group': Icons.speaker_group,
    'speaker_notes': Icons.speaker_notes,
    'speaker_notes_off': Icons.speaker_notes_off,
    'speaker_phone': Icons.speaker_phone,
    'spellcheck': Icons.spellcheck,
    'star': Icons.star,
    'star_border': Icons.star_border,
    'star_half': Icons.star_half,
    'stars': Icons.stars,
    'stay_current_landscape': Icons.stay_current_landscape,
    'stay_current_portrait': Icons.stay_current_portrait,
    'stay_primary_landscape': Icons.stay_primary_landscape,
    'stay_primary_portrait': Icons.stay_primary_portrait,
    'stop': Icons.stop,
    'stop_screen_share': Icons.stop_screen_share,
    'storage': Icons.storage,
    'store': Icons.store,
    'store_mall_directory': Icons.store_mall_directory,
    'straighten': Icons.straighten,
    'streetview': Icons.streetview,
    'strikethrough_s': Icons.strikethrough_s,
    'style': Icons.style,
    'subdirectory_arrow_left': Icons.subdirectory_arrow_left,
    'subdirectory_arrow_right': Icons.subdirectory_arrow_right,
    'subject': Icons.subject,
    'subscriptions': Icons.subscriptions,
    'subtitles': Icons.subtitles,
    'subway': Icons.subway,
    'supervised_user_circle': Icons.supervised_user_circle,
    'supervisor_account': Icons.supervisor_account,
    'surround_sound': Icons.surround_sound,
    'swap_calls': Icons.swap_calls,
    'swap_horiz': Icons.swap_horiz,
    'swap_horizontal_circle': Icons.swap_horizontal_circle,
    'swap_vert': Icons.swap_vert,
    'swap_vertical_circle': Icons.swap_vertical_circle,
    'switch_camera': Icons.switch_camera,
    'switch_video': Icons.switch_video,
    'sync': Icons.sync,
    'sync_disabled': Icons.sync_disabled,
    'sync_problem': Icons.sync_problem,
    'system_update': Icons.system_update,
    'system_update_alt': Icons.system_update_alt,
    'tab': Icons.tab,
    'tab_unselected': Icons.tab_unselected,
    'table_chart': Icons.table_chart,
    'tablet': Icons.tablet,
    'tablet_android': Icons.tablet_android,
    'tablet_mac': Icons.tablet_mac,
    'tag_faces': Icons.tag_faces,
    'tap_and_play': Icons.tap_and_play,
    'terrain': Icons.terrain,
    'text_fields': Icons.text_fields,
    'text_format': Icons.text_format,
    'text_rotate_up': Icons.text_rotate_up,
    'text_rotate_vertical': Icons.text_rotate_vertical,
    'text_rotation_angledown': Icons.text_rotation_angledown,
    'text_rotation_angleup': Icons.text_rotation_angleup,
    'text_rotation_down': Icons.text_rotation_down,
    'text_rotation_none': Icons.text_rotation_none,
    'textsms': Icons.textsms,
    'texture': Icons.texture,
    'theaters': Icons.theaters,
    'thumb_down': Icons.thumb_down,
    'thumb_up': Icons.thumb_up,
    'thumbs_up_down': Icons.thumbs_up_down,
    'time_to_leave': Icons.time_to_leave,
    'timelapse': Icons.timelapse,
    'timeline': Icons.timeline,
    'timer': Icons.timer,
    'timer_10': Icons.timer_10,
    'timer_3': Icons.timer_3,
    'timer_off': Icons.timer_off,
    'title': Icons.title,
    'toc': Icons.toc,
    'today': Icons.today,
    'toll': Icons.toll,
    'tonality': Icons.tonality,
    'touch_app': Icons.touch_app,
    'toys': Icons.toys,
    'track_changes': Icons.track_changes,
    'traffic': Icons.traffic,
    'train': Icons.train,
    'tram': Icons.tram,
    'transfer_within_a_station': Icons.transfer_within_a_station,
    'transform': Icons.transform,
    'transit_enterexit': Icons.transit_enterexit,
    'translate': Icons.translate,
    'trending_down': Icons.trending_down,
    'trending_flat': Icons.trending_flat,
    'trending_up': Icons.trending_up,
    'trip_origin': Icons.trip_origin,
    'tune': Icons.tune,
    'turned_in': Icons.turned_in,
    'turned_in_not': Icons.turned_in_not,
    'tv': Icons.tv,
    'unarchive': Icons.unarchive,
    'undo': Icons.undo,
    'unfold_less': Icons.unfold_less,
    'unfold_more': Icons.unfold_more,
    'update': Icons.update,
    'usb': Icons.usb,
    'verified_user': Icons.verified_user,
    'vertical_align_bottom': Icons.vertical_align_bottom,
    'vertical_align_center': Icons.vertical_align_center,
    'vertical_align_top': Icons.vertical_align_top,
    'vibration': Icons.vibration,
    'video_call': Icons.video_call,
    'video_label': Icons.video_label,
    'video_library': Icons.video_library,
    'videocam': Icons.videocam,
    'videocam_off': Icons.videocam_off,
    'videogame_asset': Icons.videogame_asset,
    'view_agenda': Icons.view_agenda,
    'view_array': Icons.view_array,
    'view_carousel': Icons.view_carousel,
    'view_column': Icons.view_column,
    'view_comfy': Icons.view_comfy,
    'view_compact': Icons.view_compact,
    'view_day': Icons.view_day,
    'view_headline': Icons.view_headline,
    'view_list': Icons.view_list,
    'view_module': Icons.view_module,
    'view_quilt': Icons.view_quilt,
    'view_stream': Icons.view_stream,
    'view_week': Icons.view_week,
    'vignette': Icons.vignette,
    'visibility': Icons.visibility,
    'visibility_off': Icons.visibility_off,
    'voice_chat': Icons.voice_chat,
    'voicemail': Icons.voicemail,
    'volume_down': Icons.volume_down,
    'volume_mute': Icons.volume_mute,
    'volume_off': Icons.volume_off,
    'volume_up': Icons.volume_up,
    'vpn_key': Icons.vpn_key,
    'vpn_lock': Icons.vpn_lock,
    'wallpaper': Icons.wallpaper,
    'warning': Icons.warning,
    'watch': Icons.watch,
    'watch_later': Icons.watch_later,
    'wb_auto': Icons.wb_auto,
    'wb_cloudy': Icons.wb_cloudy,
    'wb_incandescent': Icons.wb_incandescent,
    'wb_iridescent': Icons.wb_iridescent,
    'wb_sunny': Icons.wb_sunny,
    'wc': Icons.wc,
    'web': Icons.web,
    'web_asset': Icons.web_asset,
    'weekend': Icons.weekend,
    'whatshot': Icons.whatshot,
    'widgets': Icons.widgets,
    'wifi': Icons.wifi,
    'wifi_lock': Icons.wifi_lock,
    'wifi_tethering': Icons.wifi_tethering,
    'work': Icons.work,
    'wrap_text': Icons.wrap_text,
    'youtube_searched_for': Icons.youtube_searched_for,
    'zoom_in': Icons.zoom_in,
    'zoom_out': Icons.zoom_out,
    'zoom_out_map': Icons.zoom_out_map,
  };
}
