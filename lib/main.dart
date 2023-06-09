import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:meme_hub/constants.dart';
import 'package:meme_hub/controllers/media_controller.dart';
import 'package:meme_hub/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
  Get.put(MediaController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            color: kPrimaryColor,
            child: SpinKitFoldingCube(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.white : Colors.white,
                  ),
                );
              },
            )),
      ),
      overlayOpacity: 0.4,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth',
        initialRoute: AppRoutes.welcome,
        getPages: AppRoutes.pages,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
