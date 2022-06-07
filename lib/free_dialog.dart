library free_dialog;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_dialog/src/anims/anims.dart';
import 'package:free_dialog/src/free_localizations.dart';
import 'src/vertical_stack_header_dialog.dart';
import 'src/widget/i_widget.dart';

export 'package:free_dialog/src/widget/i_widget.dart';
export 'package:free_dialog/src/widget/edit_widget.dart';
export 'package:free_dialog/src/widget/list_widget.dart';
export 'package:free_dialog/src/free_localizations.dart';

enum AnimType { SCALE, LEFTSLIDE, RIGHSLIDE, BOTTOMSLIDE, TOPSLIDE }
enum DismissType { BTN_OK, BTN_CANCEL, OTHER }
class FreeDialog{
  /// [@required]
  final BuildContext context;

  /// For Autho Hide Dialog after some Duration.
  final Duration? autoHide;

  /// Btn OK props
  final String? btnOkText;
  final Function? btnOkOnPress;
  final Color? btnOkColor;

  /// Btn Cancel props
  final String? btnCancelText;
  final Function? btnCancelOnPress;
  final Color? btnCancelColor;

  /// Dialog Title
  final String? title;

  /// Set the description text of the dialog.
  final String? desc;

  /// Create your own Widget for body, if this property is set title and description will be ignored.
  final Widget? body;

  /// Custom Btn OK
  final Widget? btnOk;

  /// Custom Btn Cancel
  final Widget? btnCancel;

  /// Barrier Dissmisable
  final bool dismissOnTouchOutside;

  /// Callback to execute after dialog get dissmised
  final Function(DismissType type)? onDissmissCallback;

  /// Anim Type can be { SCALE, LEFTSLIDE, RIGHSLIDE, BOTTOMSLIDE, TOPSLIDE }
  final AnimType animType;

  ///Border Radius for the Dialog
  final BorderRadiusGeometry? dialogBorderRadius;

  /// Alignment of the Dialog
  final AlignmentGeometry aligment;

  ///使用根导航控制器而不是当前根导航控制器，可处理跨界面关闭弹窗。
  final bool useRootNavigator;

  ///键盘弹出内容被遮挡时是否跟随移动
  final bool keyboardAware;

  ///Control if Dialog is dissmis by back key.
  final bool dismissOnBackKeyPress;

  ///Max with of entire Dialog.
  final double? width;

  // ///Border Radius for built in buttons.
  // final BorderRadiusGeometry? buttonsBorderRadius;
  //
  // ///TextStyle for built in buttons.
  // final TextStyle? buttonsTextStyle;

  /// Custom background color for dialog
  final Color? dialogBackgroundColor;

  /// 整个弹窗形状
  final BorderSide? borderSide;

  final IWidget? iWidget;

  FreeDialog({
    required this.context,
    this.title,
    this.desc,
    this.body,
    this.btnOk,
    this.btnCancel,
    this.btnOkText,
    this.btnOkOnPress,
    this.btnOkColor,
    this.btnCancelText,
    this.btnCancelOnPress,
    this.btnCancelColor,
    this.onDissmissCallback,
    this.dismissOnTouchOutside = true,
    this.aligment = Alignment.center,
    this.animType = AnimType.SCALE,
    this.useRootNavigator = false,
    this.autoHide,
    this.keyboardAware = true,
    this.dismissOnBackKeyPress = true,
    this.width,
    this.dialogBorderRadius,
    // this.buttonsBorderRadius,
    this.dialogBackgroundColor,
    this.borderSide,
    this.iWidget,
    // this.buttonsTextStyle,
  });

  bool isDissmisedBySystem = false;

  DismissType _dismissType = DismissType.OTHER;

  Future show() => showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: dismissOnTouchOutside,
      builder: (BuildContext context) {
        if (autoHide != null) {
          Future.delayed(autoHide!).then((value) => dismiss());
        }
        switch (animType) {
          case AnimType.SCALE:
            return ScaleFade(
                scale: 0.1,
                fade: true,
                curve: Curves.fastLinearToSlowEaseIn,
                child: _buildDialog);

          case AnimType.LEFTSLIDE:
            return FadeIn(from: SlideFrom.LEFT, child: _buildDialog);

          case AnimType.RIGHSLIDE:
            return FadeIn(from: SlideFrom.RIGHT, child: _buildDialog);

          case AnimType.BOTTOMSLIDE:
            return FadeIn(from: SlideFrom.BOTTOM, child: _buildDialog);

          case AnimType.TOPSLIDE:
            return FadeIn(from: SlideFrom.TOP, child: _buildDialog);

          default:
            return _buildDialog;
        }
      }).then((_) {
    isDissmisedBySystem = true;
    if (onDissmissCallback != null) onDissmissCallback?.call(_dismissType);
  });
  FreeString? strings;
  Widget get _buildDialog  {
    strings = FreeLocalizations.getFreeString(context);
    iWidget?.inFreeDialog(this);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: VerticalStackDialog(
        dialogBackgroundColor: dialogBackgroundColor,
        borderSide: borderSide,
        borderRadius: dialogBorderRadius,
        title: title,
        desc: desc,
        body: body??iWidget?.toWidget(),
        alignment: aligment,
        keyboardAware: keyboardAware,
        width: width,
        btnOk: btnOk ?? (btnOkOnPress != null ? _buildFancyButtonOk : null),
        btnCancel: btnCancel ?? (btnCancelOnPress != null ? _buildFancyButtonCancel : null),
      ),
    );
  }

  Widget get _buildFancyButtonOk => TextButton(
    child: Text(
      btnOkText?? strings!.pressOk!,
      textAlign: TextAlign.center,
      style: TextStyle(color: btnOkColor ?? const Color(0xFF00CA71),fontSize: 18,fontWeight: FontWeight.bold),
    ),
    onPressed: (){
      _dismissType = DismissType.BTN_OK;
      btnOkOnPress?.call(iWidget?.toContent());
      dismiss();
    },
  );


  Widget get _buildFancyButtonCancel => TextButton(
    child: Text(
      btnCancelText?? strings!.pressCancel!,
      textAlign: TextAlign.center,
      style: TextStyle(color: btnCancelColor ?? Colors.red,fontSize: 18,fontWeight: FontWeight.bold),
    ),
    onPressed: (){
      _dismissType = DismissType.BTN_CANCEL;
      btnCancelOnPress?.call();
      dismiss();
    },
  );

  dismiss() {
    if (!isDissmisedBySystem) {
      Navigator.of(context, rootNavigator: useRootNavigator).pop();
    }
  }

  Future<bool> _onWillPop() async => dismissOnBackKeyPress;


}