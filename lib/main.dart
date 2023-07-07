import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_mac/pages/home/view.dart';
import 'package:flutter_chatgpt_mac/pages/openai/login/manager.dart';
import 'package:flutter_chatgpt_mac/routers/router.dart';
import 'package:get/get.dart';
import 'package:luca_flutter_common/luca_loading.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();
  await UserOpenAiUtils.instance.setup();

  WindowOptions options = const WindowOptions(
    size: Size(1000, 800),
    maximumSize: Size(1000, 800),
    minimumSize: Size(1000, 800),
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
      initialRoute: Routes.root,
      // home: GetMaterialApp(
      //   home: HomePage(),
      //   initialRoute: Routes.root,
      //   getPages: AppPage.pages,
      //   debugShowCheckedModeBanner: false,
      //   builder: (context, widget) {
      //     return MediaQuery(
      //       data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      //       child: LucaLoading.init()(context, widget),
      //     );
      //   },
      // ),
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
    ),
  );
}
