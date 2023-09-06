import 'package:flutter/material.dart';

class Text_utlis{
  Text medium20(size, text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: size, fontWeight: FontWeight.w500,),
    );
  }
}