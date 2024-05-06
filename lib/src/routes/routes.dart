import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shuttle/src/app/screens/home_screen.dart';
import 'package:shuttle/src/features/auth_and_user/domain/entities/user_entity.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/screens/explore_screen.dart';
import 'package:shuttle/src/features/auth_and_user/presentation/screens/profile_screen.dart';
import 'package:shuttle/src/features/chat/presentation/screens/chat_screen.dart';
import 'package:shuttle/src/routes/route_path_constants.dart';
import '../features/auth_and_user/presentation/screens/contacts_screen.dart';
import '../features/auth_and_user/presentation/screens/log_in_screen.dart';
import '../features/auth_and_user/presentation/screens/signup_screen_one.dart';
import '../features/auth_and_user/presentation/screens/signup_screen_two.dart';
import 'initial_screen_setup/initial_screen.dart';

/// Creating route configuration with go router.
class AppRoute {
  final GoRouter routerGo = GoRouter(initialLocation: '/', routes: <RouteBase>[
    // Initial route
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const InitialScreen();
      },
    ),
    GoRoute(
      path: logInPath,
      name: logIn,
      builder: (BuildContext context, GoRouterState state) {
        return const LogInScreen();
      },
    ),
    GoRoute(
        path: singUpScreenOnePath,
        name: singUpScreenOne,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpScreenOne();
        },
        routes: [
          GoRoute(
            path: singUpScreenTwoPath,
            name: singUpScreenTwo,
            builder: (BuildContext context, GoRouterState state) {
              return SignUpScreenTwo(
                  name: state.pathParameters['name']!,
                  email: state.pathParameters['email']!);
            },
          ),
        ]),
    GoRoute(
        path: homeScreenPath,
        name: homeScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: chatScreenPath,
            name: chatScreen,
            builder: (BuildContext context, GoRouterState state) {
              return ChatScreen(
                chatId: state.pathParameters['chat_id']!,
                name: state.pathParameters['name']!,
                profilePic: state.extra as String?,
              );
            },
          ),
          GoRoute(
              path: contactsScreenPath,
              name: contactsScreen,
              builder: (BuildContext context, GoRouterState state) {
                return const ContactsScreen();
              },
              routes: [
                GoRoute(
                    path: exploreScreenPath,
                    name: exploreScreen,
                    builder: (BuildContext context, GoRouterState state) {
                      return const ExploreScreen();
                    },
                    routes: [
                      GoRoute(
                        path: profileScreenPath,
                        name: profileScreen,
                        builder: (BuildContext context, GoRouterState state) {
                          return ProfileScreen(
                            userEntity: state.extra! as UserEntity,
                          );
                        },
                      ),
                    ]),
              ]),
        ]),
  ]);
}
