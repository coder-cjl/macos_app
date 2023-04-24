import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_mac/pages/openai/chat/model.dart';
import 'package:get/get.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'logic.dart';

class OtherPage extends StatelessWidget {
  final logic = Get.put(OtherLogic());
  final state = Get.find<OtherLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        title: const Text("Other"),
        actions: [
          ToolBarIconButton(
            label: "send",
            icon: const MacosIcon(Icons.send),
            showLabel: false,
            tooltipMessage: "发送",
            onPressed: () {
              logic.sendText();
            },
          ),
        ],
      ),
      backgroundColor: Colors.black12,
      children: [
        ContentArea(
          builder: (context, controller) {
            return Column(
              children: [
                Expanded(
                  child: Obx(
                    () => ListViewObserver(
                      controller: state.observerController,
                      child: ListView.builder(
                        controller: state.scrollController,
                        // physics: const NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount: state.items.value.length,
                        itemBuilder: (context, index) {
                          TextModel item = state.items.value[index];
                          return _content(item);
                        },
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                          width: Get.width - 300,
                          child: MacosTextField(
                            // controller: state.input,
                            onSubmitted: (value) {
                              // logic.sendText(SendType.me);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        PushButton(
                          buttonSize: ButtonSize.large,
                          onPressed: () {
                            // logic.sendText(SendType.other);
                          },
                          child: const Text("Send"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Markdown(
                    //     data:
                    //         "Flutter Dio是基于Dart语言的网络请求库，它本身并不支持VPN代理，但我们可以通过第三方库flutter_proxy_provider来实现VPN代理。\n\n首先，在pubspec.yaml文件中添加flutter_proxy_provider依赖：\n\n```\ndependencies:\n  flutter_proxy_provider: ^0.1.0\n```\n\n接着，在使用Dio发送请求时，设置代理即可。示例代码如下：\n\n```dart\nimport 'package:dio/dio.dart';\nimport 'package:flutter_proxy_provider/flutter_proxy_provider.dart';\n\nvoid main() async {\n  final proxy = await ProxyProvider.detect();\n  print(proxy);\n\n  final dio = Dio();\n  dio.options.baseUrl = \"https://example.com\";\n\n  if (proxy != null) {\n    dio.httpClientAdapter = HttpClientAdapterProxy(\n      host: proxy.host,\n      port: proxy.port,\n    );\n  }\n\n  final response = await dio.get('/api');\n  print(response);\n}\n```\n\n示例代码中使用ProxyProvider来检测设备中的系统代理，如果有代理就设置Dio的httpClientAdapter为HttpClientAdapterProxy。\n\n设置完代理后就可以像普通请求一样使用Dio发送请求了。"),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _content(TextModel item) {
    String prefix = item.sendType == SendType.me ? "Q" : "A";
    Color textColor =
        item.sendType == SendType.me ? Colors.black : Colors.green;
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            // Markdown(
            //   data: "$prefix: ${item?.content}" ?? "",
            // ),
            Expanded(
              child: Text(
                "$prefix: ${item?.content}" ?? "",
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
