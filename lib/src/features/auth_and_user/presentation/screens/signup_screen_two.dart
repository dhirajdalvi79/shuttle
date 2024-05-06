import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/widgets/circular_loading_indicator.dart';
import '../../../../app/widgets/message_dialog.dart';
import '../../../../core/utils/constants.dart';
import '../../../../routes/route_path_constants.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/profile_pic_bloc/profile_image_bloc.dart';
import '../utilities/constants.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';

class SignUpScreenTwo extends StatefulWidget {
  const SignUpScreenTwo({
    super.key,
    required this.name,
    required this.email,
  });

  final String name;

  final String email;

  @override
  State<SignUpScreenTwo> createState() => _SignUpScreenTwoState();
}

class _SignUpScreenTwoState extends State<SignUpScreenTwo> {
  // Controller for username
  late TextEditingController usernameController;

  // Controller for password
  late TextEditingController passwordController;

  // Controller for date
  late TextEditingController dateController;

  // Setting global key of second screen for input validation.
  final formKeySignUpTwo = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    dateController = TextEditingController();
  }

  // Returns formatted date from string.
  DateTime getDateTimeFromString({required String data}) {
    List stringList = data.split(' ');
    DateTime convertedDate = DateTime(int.parse(stringList[0]),
        toNumericalMonthValue[stringList[1]]!, int.parse(stringList[2]));
    return convertedDate;
  }

  String getPostDataDate({required String data}) {
    List stringList = data.split(' ');

    String postDataDate =
        '${stringList[0]}-${toNumericalMonthValue[stringList[1]]}-${stringList[2]}';

    return postDataDate;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    dateController.dispose();
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
              if (state is SignUpSuccess) {
                context.goNamed(homeScreen);
              } else if (state is SignUpFailure) {
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
                  // Setting form widget with global key.
                  child: Form(
                    key: formKeySignUpTwo,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text field for username.
                        AuthTextField(
                            myFieldController: usernameController,
                            myKeyboardInputType: TextInputType.text,
                            myHintText: 'Username',
                            myLabelText: 'Username',
                            myWidth: double.infinity),
                        const SizedBox(
                          height: 20,
                        ),
                        // Text field for password.
                        AuthTextField(
                          myFieldController: passwordController,
                          myKeyboardInputType: TextInputType.visiblePassword,
                          myHintText: 'Password',
                          myLabelText: 'Password',
                          myWidth: double.infinity,
                          myObscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Text field for date.
                        AuthTextField(
                          myFieldController: dateController,
                          myKeyboardInputType: TextInputType.datetime,
                          myHintText: 'Date',
                          myLabelText: 'Date',
                          myWidth: double.infinity,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthButton(
                            onPressed: () {
                              final profileImageBloc =
                                  context.read<ProfileImageBloc>();
                              final form = formKeySignUpTwo.currentState!;
                              if (form.validate()) {
                                final authBloc = context.read<AuthBloc>();
                                authBloc.add(SignUpEvent(
                                    userName: usernameController.text.trim(),
                                    name: widget.name,
                                    email: widget.email,
                                    bio: '',
                                    password: passwordController.text.trim(),
                                    profileImageUrl:
                                        profileImageBloc.state.profileImagePath,
                                    birthDate: getDateTimeFromString(
                                        data: dateController.text)));
                              }
                            },
                            text: 'Sign Up'),
                        const SizedBox(
                          height: 20,
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
