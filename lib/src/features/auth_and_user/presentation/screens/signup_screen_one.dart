import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/constants.dart';
import '../../../../routes/route_path_constants.dart';
import '../bloc/profile_pic_bloc/profile_image_bloc.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/image_source_selector_dialog.dart';

// Icon Size
const double iconSize = 25;

class SignUpScreenOne extends StatefulWidget {
  const SignUpScreenOne({super.key});

  @override
  State<SignUpScreenOne> createState() => _SignUpScreenOneState();
}

class _SignUpScreenOneState extends State<SignUpScreenOne> {
  // Controller for first name
  late TextEditingController nameController;

  // Controller for email.
  late TextEditingController emailController;

  // Setting global key for input validation.
  final formKeySignUpOne = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();

    emailController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();

    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // Setting form widget with global key.
                  child: Form(
                    key: formKeySignUpOne,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            // Consuming profile image selector provider.
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: iconSize / 2),
                              // Circle avatar for displaying selected profile image.
                              child: BlocBuilder<ProfileImageBloc,
                                  ProfileImageState>(
                                builder: (context, state) {
                                  if (state is ProfileImageSelected) {
                                    return CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: screenSize.width * 0.20,
                                        backgroundImage: MemoryImage(
                                            state.profileImageBytes!));
                                  } else {
                                    return CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: screenSize.width * 0.20,
                                        backgroundImage: const AssetImage(
                                          profilePicPlaceholder,
                                        ));
                                  }
                                },
                              ),
                            ),
                            Positioned(
                                //Evaluation for fixing icon at centre
                                left: (screenSize.width * 0.20) - iconSize / 2,
                                //right: screen.screenWidth * 0.15,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const ProfileImagesSourceSelector();
                                        });
                                  },
                                  child: const Icon(
                                    Icons.add_a_photo_sharp,
                                    size: iconSize,
                                  ),
                                )),
                          ],
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                        // Text field for first name.
                        AuthTextField(
                            myFieldController: nameController,
                            myKeyboardInputType: TextInputType.text,
                            myHintText: 'Name',
                            myLabelText: 'Name',
                            myWidth: double.infinity),
                        const SizedBox(
                          height: 20,
                        ),

                        // Text field for email.
                        AuthTextField(
                            myFieldController: emailController,
                            myKeyboardInputType: TextInputType.emailAddress,
                            myHintText: 'Email',
                            myLabelText: 'Email',
                            myWidth: double.infinity),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthButton(
                            onPressed: () {
                              final form = formKeySignUpOne.currentState!;
                              if (form.validate()) {
                                context
                                    .goNamed(singUpScreenTwo, pathParameters: {
                                  'name': nameController.text.trim(),
                                  'email': emailController.text.trim(),
                                });
                              }
                            },
                            text: 'Next  ➔'),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Have an account?'),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.goNamed(logIn);
                              },
                              child: const Text(
                                'Log In',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
