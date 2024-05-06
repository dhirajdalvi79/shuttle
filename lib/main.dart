import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/core/service_locator/injection_container.dart';
import 'package:shuttle/src/core/utils/constants.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/bloc/all_users_bloc/all_users_bloc.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/bloc/get_contacts_bloc/get_contacts_bloc.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/bloc/profile_pic_bloc/profile_image_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/chat_status_update_bloc/chat_status_update_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/get_app_user_bloc/get_app_user_bloc.dart';
import 'package:shuttle/src/features/chat/presentation/bloc/get_user_chat_status_bloc/get_user_chat_status_bloc.dart';
import 'package:shuttle/src/firebase_backend/firebase_initialize.dart';
import 'package:shuttle/src/routes/initial_screen_setup/initial_screen_bloc.dart';
import 'package:shuttle/src/routes/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await init();
  AppRoute appRoute = AppRoute();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                InitialScreenBloc(FirebaseInitSingleton())),
        BlocProvider(create: (BuildContext context) => ProfileImageBloc()),
        BlocProvider(create: (BuildContext context) => sl<AuthBloc>()),
        BlocProvider(create: (BuildContext context) => sl<ChatListBloc>()),
        BlocProvider(create: (BuildContext context) => sl<GetContactsBloc>()),
        BlocProvider(create: (BuildContext context) => sl<AllUsersBloc>()),
        BlocProvider(
            create: (BuildContext context) => sl<ChatStatusUpdateBloc>()),
        BlocProvider(
            create: (BuildContext context) => sl<GetUserChatStatusBloc>()),
        BlocProvider(create: (BuildContext context) => sl<GetAppUserBloc>()),
      ],
      child: MyApp(
        appRoute: appRoute,
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoute});

  final AppRoute appRoute;

  @override
  Widget build(BuildContext context) {
    context
        .watch<InitialScreenBloc>()
        .add(const CheckInitialScreenAuthStateEvent());
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.white),
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.black,
              onPrimary: Colors.white,
              secondary: Colors.black54,
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.redAccent,
              background: Colors.black,
              onBackground: Colors.white,
              surface: Colors.black54,
              onSurface: Colors.white),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: Colors.black.withOpacity(0.9),
            todayForegroundColor:
                const MaterialStatePropertyAll<Color>(actionColor),
            dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.green; // Change to your desired color
              }
              return null; // Use default color for non-selected dates
            }),
            inputDecorationTheme: InputDecorationTheme(
              focusColor: Colors.red,
              floatingLabelStyle: const TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      const BorderSide(width: 1.5, color: Colors.white)),
            ),
            confirmButtonStyle: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll<Color>(actionColor)),
            cancelButtonStyle: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll<Color>(actionColor)),
          )),
      routeInformationParser: appRoute.routerGo.routeInformationParser,
      routerDelegate: appRoute.routerGo.routerDelegate,
      routeInformationProvider: appRoute.routerGo.routeInformationProvider,
    );
  }
}
