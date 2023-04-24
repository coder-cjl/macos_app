import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_mac/pages/openai/auido/view.dart';
import 'package:flutter_chatgpt_mac/pages/openai/chat/view.dart';
import 'package:flutter_chatgpt_mac/pages/openai/image/view.dart';
import 'package:flutter_chatgpt_mac/pages/openai/login/manager.dart';
import 'package:flutter_chatgpt_mac/pages/openai/login/view.dart';
import 'package:flutter_chatgpt_mac/pages/other/view.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        maxWidth: 200,
        topOffset: 20,
        builder: (context, controller) {
          return Obx(
            () => SidebarItems(
              items: const [
                SidebarItem(
                  label: Text("ChatGPT"),
                  disclosureItems: [
                    SidebarItem(
                      label: Text("Text"),
                      leading: MacosIcon(CupertinoIcons.text_bubble),
                    ),
                    SidebarItem(
                      label: Text("Image"),
                      leading: MacosIcon(CupertinoIcons.photo),
                    ),
                    SidebarItem(
                      label: Text("Audio"),
                      leading: MacosIcon(CupertinoIcons.music_albums),
                    ),
                  ],
                ),
                SidebarItem(
                  label: Text("Other"),
                ),
              ],
              currentIndex: state.currentIndex.value,
              onChanged: (index) {
                state.currentIndex.value = index;
              },
            ),
          );
        },
      ),
      child: Obx(
        () => IndexedStack(
          index: state.currentIndex.value,
          children: [
            Obx(
              () => UserOpenAiUtils.instance.isLoginObs.value
                  ? MacosScaffold(
                      toolBar: ToolBar(
                        title: const Text("文字助手"),
                        actions: [
                          ToolBarIconButton(
                            label: "Exit",
                            icon: const MacosIcon(
                                CupertinoIcons.person_add_solid),
                            showLabel: false,
                            tooltipMessage: "Exit",
                            onPressed: () {
                              logic.chatgptLogout();
                            },
                          ),
                        ],
                      ),
                      backgroundColor: Colors.black12,
                      children: [
                        ContentArea(
                          builder: (context, controller) {
                            return ChatPage();
                          },
                        ),
                      ],
                    )
                  : ContentArea(builder: (context, controller) {
                      return LoginPage();
                    }),
            ),
            Obx(
              () => UserOpenAiUtils.instance.isLoginObs.value
                  ? MacosScaffold(
                      toolBar: ToolBar(
                        title: const Text("图片助手"),
                        actions: [
                          ToolBarIconButton(
                            label: "Exit",
                            icon: const MacosIcon(
                                CupertinoIcons.person_add_solid),
                            showLabel: false,
                            tooltipMessage: "Exit",
                            onPressed: () {
                              logic.chatgptLogout();
                            },
                          ),
                        ],
                      ),
                      backgroundColor: Colors.black12,
                      children: [
                        ContentArea(
                          builder: (context, controller) {
                            return ImagePage();
                          },
                        ),
                      ],
                    )
                  : ContentArea(builder: (context, controller) {
                      return LoginPage();
                    }),
            ),
            Obx(
              () => UserOpenAiUtils.instance.isLoginObs.value
                  ? ContentArea(
                      builder: (context, controller) {
                        return AuidoPage();
                      },
                    )
                  : ContentArea(builder: (context, controller) {
                      return LoginPage();
                    }),
            ),
            OtherPage(),
          ],
        ),
      ),
    );
  }
}
