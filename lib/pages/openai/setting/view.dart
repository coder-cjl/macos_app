import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SettingPage extends StatelessWidget {
  final logic = Get.put(SettingLogic());
  final state = Get.find<SettingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
