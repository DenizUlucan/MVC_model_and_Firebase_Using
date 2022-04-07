import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItems { kullanicilar, profil }

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItems, TabItemData> tumTablar = {
    TabItems.kullanicilar:
        TabItemData("Kullanıcılar", Icons.supervised_user_circle),
    TabItems.profil: TabItemData("Profil", Icons.person),
  };
}
