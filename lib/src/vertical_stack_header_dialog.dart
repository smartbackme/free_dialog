import 'dart:math';

import 'package:flutter/material.dart';

class VerticalStackDialog extends StatelessWidget {
  final String? title;
  final String? desc;
  final Widget? btnOk;
  final Widget? btnCancel;
  final Widget? body;
  final AlignmentGeometry? alignment;
  final bool keyboardAware;
  final double? width;
  final Color? dialogBackgroundColor;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;

  const VerticalStackDialog({
    Key? key,
    this.title,
    this.desc,
    this.btnOk,
    this.btnCancel,
    this.body,
    this.alignment,
    this.keyboardAware = true,
    this.width,
    this.dialogBackgroundColor,
    this.borderSide,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      alignment: alignment,
      padding: EdgeInsets.only(
          bottom: keyboardAware ? mediaQueryData.viewInsets.bottom : 0),
      child: Stack(
        children: <Widget>[
          Container(
            width: width ?? min(mediaQueryData.size.width,mediaQueryData.size.height)*0.8,
            constraints: BoxConstraints(
              maxHeight: mediaQueryData.size.height*0.8,
            ),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ??
                    const BorderRadius.all(
                      Radius.circular(10),
                    ),
                side: borderSide ?? BorderSide.none,
              ),
              elevation: 0.5,
              color: dialogBackgroundColor ?? theme.cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (title != null) ..._titleBody(title!, theme),
                  Flexible(
                    fit: FlexFit.loose,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: body ?? (desc!=null?Padding(padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),child: Text(
                        desc!,
                        textAlign: TextAlign.center,
                      ),):null),
                    ),),
                  if (btnOk != null || btnCancel != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (btnCancel != null)
                            Expanded(
                              child: btnCancel!,
                            ),
                          if (btnCancel != null && btnOk != null)
                            const SizedBox(
                              width: 10,
                            ),
                          if (btnOk != null)
                            Expanded(
                              child: btnOk!,
                            )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _titleBody(String title, ThemeData theme) => [
    const SizedBox(
      height: 20.0,
    ),
    Text(
      title,
      textAlign: TextAlign.center,
      style: theme.textTheme.headline6,
    ),
    const SizedBox(
      height: 15.0,
    ),
  ];
}
