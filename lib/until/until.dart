import 'package:flutter/cupertino.dart';

class untils {
  static void fildFocus(
      BuildContext context, FocusNode currentNode, FocusNode nextFocus) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
