import 'package:chat_app/customs/custom_bottom_navigation.dart';
import 'package:chat_app/customs/kullanicilar.dart';
import 'package:chat_app/customs/profil.dart';
import 'package:chat_app/customs/tabs_item.dart';
import 'package:chat_app/locator.dart';
import 'package:chat_app/model/UserM.dart';
import 'package:chat_app/services/auth_base.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/viewmodel/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final UserM? user;

  HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

TabItems _currentTab = TabItems.kullanicilar;
Map<TabItems, Widget> tumSayfalar() {
  return {
    TabItems.kullanicilar: KullanicilarPage(),
    TabItems.profil: ProfilPage(),
  };
}

class _HomePageState extends State<HomePage> {
  Map<TabItems, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItems.kullanicilar: GlobalKey<NavigatorState>(),
    TabItems.profil: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: MyCustomBottomNavigation(
        navigatorKeys: navigatorKeys,
        sayfaOlusturucu: tumSayfalar(),
        currentTab: _currentTab,
        onSelected: (secilenTab) {
          print("Secilen tab İtem" + secilenTab.toString());
          if (secilenTab == _currentTab) {
            navigatorKeys[secilenTab]!
                .currentState!
                .popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentTab = secilenTab;
            });
          }
        },
      ),
    );
  }
}
