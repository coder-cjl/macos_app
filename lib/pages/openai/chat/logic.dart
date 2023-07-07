import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_mac/pages/network/api.dart';
import 'package:flutter_chatgpt_mac/pages/network/url.dart';
import 'package:get/get.dart';
import 'package:luca_flutter_common/luca_loading.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'model.dart';
import 'state.dart';

class ChatLogic extends GetxController {
  final ChatState state = ChatState();

  final String demo =
      "在swift开发中，可以使用系统提供的Network Extension框架来设置VPN代理。以下是一些基本的代码示例：\n\n```\n//1.创建一个NEVPNManager对象\nlet vpnManager = NEVPNManager.shared()\n\n//2.配置VPN协议，并将其添加到VPNManager中\nlet vpnProtocol = NEVPNProtocolIKEv2()\nvpnProtocol.username = \"your vpn username\"\nvpnProtocol.passwordReference = keychain.getVPNPassword() //从钥匙串中获取VPN密码\nvpnProtocol.serverAddress = \"your vpn server address\"\nvpnProtocol.remoteIdentifier = \"your vpn remote identifier\"\nvpnProtocol.localIdentifier = \"your vpn local identifier\"\nvpnProtocol.useExtendedAuthentication = true\nvpnProtocol.disconnectOnSleep = false\nvpnManager.protocolConfiguration = vpnProtocol;\n\n//3.设置VPN管理器的描述，并启用它\nvpnManager.localizedDescription = \"My VPN\"\nvpnManager.isEnabled = true\n\n//4.启动VPN连接\nvpnManager.connection.startVPNTunnel()\n```\n\n以上示例代码创建了一个`NEVPNManager`对象，并使用IKEv2协议配置了一个VPN。然后，设置了VPN管理器的描述并启用它。最后，启动VPN连接。注意，在此之前，需要正确地配置VPN服务器和相关的安全协议，如证书、密码等。";

  @override
  void onInit() {
    state.observerController =
        ListObserverController(controller: state.scrollController);

    Future.delayed(const Duration(seconds: 1), () {
      var item = TextModel(sendType: SendType.me, content: "这是问题");
      state.items.value.add(item);
      state.items.refresh();
      toBottomOffset();

      Future.delayed(const Duration(seconds: 2), () {
        var item = TextModel(sendType: SendType.other, content: demo);
        state.items.value.add(item);
        state.items.refresh();
        toBottomOffset();
      });
    });

    super.onInit();
  }

  void sendText() {
    String txt = state.input.text.trim();
    if (txt.isEmpty) {
      LucaLoading.showToast("请输入提问内容");
      return;
    }
    var item = TextModel(sendType: SendType.me, content: txt);
    state.items.value.add(item);
    state.input.clear();
    state.items.refresh();
    toBottomOffset();
    _req(txt);
  }

  void toBottomOffset() {
    state.observerController?.jumpTo(index: state.items.length - 1);
  }

  void _req(String content) async {
    LucaLoading.show(timeout: 60);
    var res = await Api().post(
      ApiURL.chatText,
      data: {
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content": content,
          },
        ],
      },
    );

    if (res.isSuccessful()) {
      LucaLoading.dismiss();
      List choices = res.data["choices"];
      if (choices.isNotEmpty) {
        String? answer = choices.first["message"]["content"];
        if (answer != null) {
          TextModel item = TextModel(sendType: SendType.other, content: answer);
          state.items.add(item);
          state.items.refresh();
          toBottomOffset();
        }
      }
    } else {
      LucaLoading.showToast(res.message);
    }
  }

  Widget parse(TextModel item) {
    String content = item.content ?? "";
    List<Widget> columns = [];
    List<Widget> rows = [];
    List<Widget> childColumns = [];

    if (item.sendType == SendType.me) {
      columns.add(
        const SizedBox(
          height: 5,
        ),
      );
      var avatar = _avatar("Q", Colors.blueAccent);
      var child = Text(
        content,
        style: const TextStyle(
          color: Colors.black,
        ),
      );
      rows.add(
        const SizedBox(
          width: 5,
        ),
      );
      rows.add(avatar);
      rows.add(
        const SizedBox(
          width: 5,
        ),
      );
      childColumns.add(
        const SizedBox(
          height: 3,
        ),
      );
      childColumns.add(child);
      childColumns.add(
        const SizedBox(
          height: 10,
        ),
      );

      var childColumn = Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: childColumns,
        ),
      );
      rows.add(childColumn);
      rows.add(
        const SizedBox(
          width: 20,
        ),
      );
      var row = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      );
      columns.add(row);

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns,
      );
    } else {
      final patten = RegExp("```([a-zA-Z]*)\\n([\\s\\S]*?)```");
      final matches = patten.allMatches(content);
      int currentIndex = 0;

      for (Match match in matches) {
        if (match.start > currentIndex) {
          final start = content.substring(currentIndex, match.start);
          var child = SelectableText(
            start,
            enableInteractiveSelection: true,
            style: const TextStyle(
              color: Colors.black,
            ),
          );
          if (currentIndex == 0) {
            var avatar = _avatar("A", Colors.redAccent);
            columns.add(
              const SizedBox(
                height: 5,
              ),
            );
            rows.add(
              const SizedBox(
                width: 5,
              ),
            );
            rows.add(avatar);
            rows.add(
              const SizedBox(
                width: 5,
              ),
            );
            childColumns.add(
              const SizedBox(
                height: 3,
              ),
            );
            childColumns.add(child);
          } else {
            childColumns.add(child);
          }

          String? code = match.group(2);
          if (code != null) {
            final language = match.group(1);
            var child2 = Column(
              children: [
                Container(
                  height: 30,
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    color: Color(0xFF343541),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                  ),
                  child: Text(
                    language ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    // color: Color.fromARGB(1, 52, 53, 65),
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7)),
                  ),
                  child: SelectableText(
                    code ?? "",
                    enableInteractiveSelection: true,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
            childColumns.add(child2);
          }
        }
        currentIndex = match.end;
      }

      if (currentIndex < content.length) {
        final p = content.substring(currentIndex);
        var child = SelectableText(
          p,
          enableInteractiveSelection: true,
          style: const TextStyle(
            color: Colors.black,
          ),
        );
        if (currentIndex == 0) {
          var avatar = _avatar("A", Colors.redAccent);
          columns.add(
            const SizedBox(
              height: 5,
            ),
          );
          rows.add(
            const SizedBox(
              width: 5,
            ),
          );
          rows.add(avatar);
          rows.add(
            const SizedBox(
              width: 5,
            ),
          );
          childColumns.add(
            const SizedBox(
              height: 3,
            ),
          );
          childColumns.add(child);
        } else {
          childColumns.add(child);
        }
      }

      childColumns.add(
        const SizedBox(
          height: 10,
        ),
      );

      var childColumn = Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: childColumns,
        ),
      );
      rows.add(childColumn);
      rows.add(
        const SizedBox(
          width: 20,
        ),
      );
      var row = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      );
      columns.add(row);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns,
      );
    }
  }

  Widget _avatar(String name, Color c) {
    return Container(
      width: 25,
      height: 25,
      // color: Colors.red,
      decoration: BoxDecoration(
        color: c,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Center(
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.05,
          ),
        ),
      ),
    );
  }
}
