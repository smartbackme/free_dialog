

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_dialog/src/widget/i_widget.dart';

class EditWidget extends IWidget{
  final TextEditingController _controller;
  Widget? _textField;

  Color? enabled;
  Color? focused;
  Color? text;

  EditWidget(this._controller,{this.enabled,this.focused,this.text}){
    _textField = Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
      child: TextField(
        style: TextStyle(color: text??Colors.black87),
        controller: _controller,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: enabled??Colors.blue),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: focused??Colors.blue),
            )),
      ),
    );
  }

  @override
  toContent() => _controller.text;

  @override
  Widget toWidget() => _textField!;

}