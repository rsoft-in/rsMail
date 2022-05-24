import 'package:animations/animations.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:rsMail/constants.dart';
import 'package:rsMail/pages/home_page.dart';
import 'package:rsMail/pages/settings.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:rsMail/helpers/globals.dart' as globals;

class EmailApp extends StatefulWidget {
  const EmailApp({Key? key}) : super(key: key);

  @override
  State<EmailApp> createState() => _EmailAppState();
}

class _EmailAppState extends State<EmailApp> {
  int _page = 0;
  final _pageList = [
    const HomePage(),
    const SettingsPage(),
  ];
  _onDrawerItemSelect(int index) {
    setState(() => _page = index);
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = (globals.themeMode == ThemeMode.dark ||
        (brightness == Brightness.dark &&
            globals.themeMode == ThemeMode.system));
    return Scaffold(
      appBar: UniversalPlatform.isDesktop
          ? PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: FlexColor.redWineDarkPrimary.withAlpha(50),
                    child: WindowTitleBarBox(
                      child: Row(
                        children: [
                          Expanded(child: MoveWindow()),
                          const WindowButtons(),
                        ],
                      ),
                    ),
                  ),
                  AppBar(title: const Text(kAppName)),
                ],
              ),
            )
          : AppBar(
              title: const Text(kAppName),
            ),
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.inbox_outlined),
                  selectedIcon: Icon(Icons.inbox_rounded),
                  label: Text('Inbox'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings_rounded),
                  label: Text('Settings'),
                ),
              ],
              selectedIndex: _page,
              onDestinationSelected: _onDrawerItemSelect,
            ),
            Expanded(
              child: PageTransitionSwitcher(
                transitionBuilder: (child, animation, secondaryAnimation) {
                  return FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
                child: _pageList[_page],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WindowIconButtons(
          icon: Icons.minimize_rounded,
          ontap: () {
            appWindow.minimize();
          },
        ),
        WindowIconButtons(
          icon: Icons.check_box_outline_blank_rounded,
          ontap: () {
            appWindow.maximizeOrRestore();
          },
        ),
        WindowIconButtons(
          icon: Icons.close,
          ontap: () {
            appWindow.close();
          },
        ),
      ],
    );
  }
}

class WindowIconButtons extends StatefulWidget {
  final IconData icon;
  final Function ontap;
  const WindowIconButtons({Key? key, required this.icon, required this.ontap})
      : super(key: key);

  @override
  State<WindowIconButtons> createState() => _WindowIconButtonsState();
}

class _WindowIconButtonsState extends State<WindowIconButtons> {
  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool darkModeOn = (globals.themeMode == ThemeMode.dark ||
    //     (brightness == Brightness.dark &&
    //         globals.themeMode == ThemeMode.system));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: InkWell(
        onTap: () => widget.ontap(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            widget.icon,
            size: 12,
          ),
        ),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: Colors.grey.shade100,
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: Colors.grey.shade100);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);
