import 'package:app_ecommerce/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app_ecommerce_setup/app_ecommerce_setup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_ecommerce_admin/bloc/sidebar/sidebar_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  if (!kIsWeb) {
    setup();
  }
  await EasyLocalization.ensureInitialized();
  AppRouteWeb.setupRouter();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('id', 'ID'),
      ],
      path: 'language',
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<SidebarBloc>(
            create: (context) => SidebarBloc(),
          ),
        ],
        child: MaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: "WEB HAMBURIN",
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRouteName.splash,
          onGenerateRoute: AppRouteWeb.router.generator,
        ),
      );
    } else {
      final router = locator.get<AppRoute>().router;
      return MultiBlocProvider(
        providers: const [],
        child: MaterialApp.router(
          scrollBehavior: MyCustomScrollBehavior(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
          debugShowCheckedModeBanner: false,
          title: "Hamburin",
        ),
      );
    }
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
