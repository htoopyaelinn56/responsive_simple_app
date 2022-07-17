import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

const Color mainColor = Colors.deepPurple;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        defaultScale: false,
        minWidth: 450,
        defaultName: MOBILE,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(400, name: MOBILE),
          const ResponsiveBreakpoint.resize(600, name: MOBILE),
          const ResponsiveBreakpoint.resize(850, name: TABLET),
          const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
        ],
        background: Container(
          color: Colors.white,
        ),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xfff2f2f2),
            child: Center(
              child: Container(
                width: 1200,
                height: 250,
                color: const Color(0xfff2f2f2),
                child: ResponsiveRowColumn(
                  rowMainAxisAlignment: MainAxisAlignment.spaceAround,
                  columnMainAxisAlignment: MainAxisAlignment.center,
                  layout: ResponsiveWrapper.of(context).isMobile ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
                  children: [
                    ResponsiveRowColumnItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundColor: Color(0xffe6e6e6),
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Color(0xff404040),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Username',
                                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Local Account',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(fontSize: 16, color: mainColor, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const ResponsiveRowColumnItem(child: SizedBox(width: 5, height: 5)),
                    ResponsiveRowColumnItem(
                      child: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(Icons.cloud_outlined, size: 55),
                            Icon(Icons.games, size: 55),
                            Icon(Icons.refresh, size: 55),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(5),
            width: 500,
            child: const TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                  borderRadius: BorderRadius.zero,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: mainColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 1200,
              child: ResponsiveGridView.builder(
                controller: ScrollController(),
                shrinkWrap: true,
                gridDelegate: ResponsiveGridDelegate(
                  childAspectRatio: ResponsiveWrapper.of(context).screenWidth < 560 ? 5 : 3.5,
                  crossAxisSpacing: 30,
                  minCrossAxisExtent: 250,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (_, index) {
                  return SettingWidget(
                    title: _settingList[index].title,
                    desc: _settingList[index].desc,
                    icon: _settingList[index].icon,
                  );
                },
                itemCount: _settingList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    Key? key,
    required this.title,
    required this.desc,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String desc;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: mainColor,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      desc,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingModel {
  final String title;
  final String desc;
  final IconData icon;
  SettingModel({
    required this.title,
    required this.desc,
    required this.icon,
  });
}

List<SettingModel> _settingList = [
  SettingModel(title: 'System', desc: 'Dispaly, sound, notification and power', icon: Icons.laptop_windows_outlined),
  SettingModel(title: 'Device', desc: 'Bluetooth, printers, mouse', icon: Icons.keyboard_alt_outlined),
  SettingModel(title: 'Phone', desc: 'Link your Android, iPhone', icon: Icons.phone_outlined),
  SettingModel(title: 'Network & Internet', desc: 'Wi-Fi, Airplance mode, VPN', icon: Icons.wifi_find_outlined),
  SettingModel(title: 'Personalization', desc: 'Background, lock screen, colors', icon: Icons.edit_note_outlined),
  SettingModel(title: 'Apps', desc: 'Uninstall, defaults, optional features', icon: Icons.app_settings_alt_outlined),
  SettingModel(title: 'Accounts', desc: 'Your accounts, email, sync, work, family', icon: Icons.account_box_outlined),
  SettingModel(title: 'Time & Language', desc: 'Speech, region, date', icon: Icons.timelapse_outlined),
  SettingModel(title: 'Gaming', desc: 'Xbox Game Bar, captures, Game Mode', icon: Icons.gamepad_outlined),
  SettingModel(title: 'Ease of Access', desc: 'Narrator, maginifier, high contrast', icon: Icons.route_outlined),
  SettingModel(title: 'Search', desc: 'Find my files, permission', icon: Icons.search_outlined),
  SettingModel(title: 'Privacy', desc: 'Location, camera, microphone', icon: Icons.privacy_tip_outlined),
  SettingModel(title: 'Update & Security', desc: 'Window Update, recovery, backup', icon: Icons.system_update),
];
