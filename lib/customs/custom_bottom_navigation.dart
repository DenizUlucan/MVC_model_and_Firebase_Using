import 'package:chat_app/customs/tabs_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomBottomNavigation extends StatefulWidget {
  final TabItems currentTab;
  final ValueChanged<TabItems> onSelected;
  final Map<TabItems, Widget> sayfaOlusturucu;
  final Map<TabItems, GlobalKey<NavigatorState>> navigatorKeys;

  const MyCustomBottomNavigation({
    Key? key,
    required this.currentTab,
    required this.onSelected,
    required this.sayfaOlusturucu,
    required this.navigatorKeys,
  }) : super(key: key);

  @override
  State<MyCustomBottomNavigation> createState() =>
      _MyCustomBottomNavigationState();
}

class _MyCustomBottomNavigationState extends State<MyCustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          _navItemOlustur(TabItems.kullanicilar),
          _navItemOlustur(TabItems.profil)
        ], onTap: (index) => widget.onSelected(TabItems.values[index])),
        tabBuilder: (context, index) {
          final gosterilecekItem = TabItems.values[index];
          return CupertinoTabView(
            navigatorKey: widget.navigatorKeys[gosterilecekItem],
            builder: (context) {
              return widget.sayfaOlusturucu[gosterilecekItem] as Widget;
            },
          );
        });
  }

  BottomNavigationBarItem _navItemOlustur(TabItems tabItems) {
    final olusturulacakTab = TabItemData.tumTablar[tabItems];
    return BottomNavigationBarItem(
      icon: Icon(olusturulacakTab!.icon),
      label: olusturulacakTab.title,
    );
  }
}
