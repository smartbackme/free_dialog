

import 'package:flutter/cupertino.dart';

import '../../free_dialog.dart';

abstract class IWidget{

  Widget toWidget();

  dynamic toContent();

  FreeDialog? freeDialog;
  void inFreeDialog(FreeDialog freeDialog) {
    this.freeDialog = freeDialog;
  }
}

