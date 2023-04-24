import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.put(LoginLogic());
  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "ChatGPT OpenAi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 40,
            width: Get.width,
          ),
          SizedBox(
            width: 200,
            child: MacosTextField(
              controller: state.token,
              placeholder: "secret key",
            ),
          ),
          SizedBox(
            height: 10,
            width: Get.width,
          ),
          SizedBox(
            width: 200,
            child: MacosTextField(
              controller: state.proxy,
              placeholder: "PROXY localhost:7890",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PushButton(
            buttonSize: ButtonSize.large,
            onPressed: () {
              logic.login();
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
