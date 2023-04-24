import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_mac/pages/home/view.dart';
import 'package:flutter_chatgpt_mac/pages/openai/login/manager.dart';
import 'package:get/get.dart';
import 'package:luca_flutter_common/luca_loading.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();
  await UserOpenAiUtils.instance.setup();

  WindowOptions options = const WindowOptions(
    size: Size(800, 600),
    maximumSize: Size(800, 600),
    minimumSize: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
  );
  await WindowManager.instance.waitUntilReadyToShow(options);

  runApp(
    MacosApp(
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: GetMaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: LucaLoading.init()(context, widget),
          );
        },
      ),
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
    ),
  );
}
