import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/auth_provider.dart';
import 'package:worshipsongs/services/size_config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      sleep(Duration(seconds: 2));
      setUpCrashlytics();
      Provider.of<AuthProvider>(context, listen: false).tryToLogin();
    });
  }

  Future setUpCrashlytics() async {
    await Firebase.initializeApp();
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.safeBlockVertical * 20,
            ),
            SvgPicture.asset(
              'assets/logo.svg',
              height: SizeConfig.safeBlockVertical * 25,
            ),
            Center(
              child: Text(
                Strings.of(context).worshipSongs,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FutureBuilder(
                  future: _getVersionText(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('');
                    }
                    return Text(
                      snapshot.data?.toString(),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: AppColors.gray,
                          ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getVersionText() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${Strings.of(context).version}: ${packageInfo.version}';
  }
}
