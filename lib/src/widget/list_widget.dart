

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_dialog/free_dialog.dart';
import 'package:free_dialog/src/widget/i_widget.dart';

typedef ClickFunction = void Function(int index);

class ListWidget extends IWidget{

  List<String> data;

  Color? textColor;

  ClickFunction click;

  ListWidget(this.data,this.click,{this.textColor});

  @override
  toContent() => "";

  @override
  Widget toWidget() => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount:data.isEmpty?0:data.length,
      itemBuilder: (BuildContext context, int  position){
        return itemWidget(context,position);
      });

  Widget itemWidget(BuildContext context,int index){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
          height: 45,
          width: double.infinity,
          child: Center(
            child:  Text(
              data[index],
              style: TextStyle(
                  color: textColor??Colors.black
              ),
            ),
          )
      ),
      onTap: (){
        click.call(index);
        freeDialog?.dismiss();
      },
    );
  }


}