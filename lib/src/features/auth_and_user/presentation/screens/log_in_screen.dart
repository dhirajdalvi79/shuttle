import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/widgets/circular_loading_indicator.dart';
import '../../../../app/widgets/message_dialog.dart';
import '../../../../core/utils/constants.dart';
import '../../../../routes/route_path_constants.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Reason for putting Asset image outside scaffold because while interacting with the TextFormField
        // this image (which is acting as background image) gets scale down.
        Image.asset(
          authBackgroundImageAssetPath,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: scaffoldBackgroundColor,
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LogInSuccess) {
                context.goNamed(homeScreen);
              } else if (state is LogInFailure) {
                context.pop();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MessageDialog(message: state.message);
                    });
              } else if (state is AuthLoading) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CircularLoadingIndicator();
                    });
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          appIconAssetPath,
                          height: 170,
                          width: 170,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AuthTextField(
                            myFieldController: emailController,
                            myKeyboardInputType: TextInputType.emailAddress,
                            myHintText: 'Email',
                            myLabelText: 'Email',
                            myWidth: double.infinity),
                        const SizedBox(
                          height: 25,
                        ),
                        AuthTextField(
                            myFieldController: passwordController,
                            myKeyboardInputType: TextInputType.visiblePassword,
                            myHintText: 'Password',
                            myLabelText: 'Password',
                            myWidth: double.infinity),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthButton(
                            onPressed: () async {
                              final form = loginFormKey.currentState!;
                              if (form.validate()) {
                                final authBloc = context.read<AuthBloc>();
                                authBloc.add(LogInEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim()));
                              }
                            },
                            text: 'Log In'),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.goNamed(singUpScreenOne);
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
