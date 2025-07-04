import 'package:carea_app/core/common/widgets/loader.dart';
import 'package:carea_app/core/theme/app_pallete.dart';
import 'package:carea_app/core/theme/text_style.dart';
import 'package:carea_app/core/utils/show_snackbar.dart';
import 'package:carea_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carea_app/features/auth/presentation/pages/signup_page.dart';
import 'package:carea_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:carea_app/features/food/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: SvgPicture.asset('assets/icons/logo.svg', height: 30),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      showSnackBar(context, state.message);
                    } else if (state is AuthSuccess) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const MainPage()),
                        (_) => false,
                      );
                      // context.read<AuthBloc>().add(AuthIsUserLoggedIn());
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(child: const Loader());
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SizedBox(height: constraints.maxHeight * 0.1),
                          SizedBox(height: constraints.maxHeight * 0.1),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Login to your account",
                                  style: TextStyles.header1,
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  "Good to see you again, enter your details\nbelow to continue ordering.",
                                  style: TextStyles.body,
                                  // textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.05),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Email",
                                      style: TextStyles.body,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                AuthField(
                                  hintText: "Email",
                                  controller: _emailController,
                                ),
                                const SizedBox(height: 16.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Password",
                                      style: TextStyles.body,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5.0),

                                AuthField(
                                  hintText: "Password",
                                  isObscureText: true,
                                  controller: _passwordController,
                                ),
                                const SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                        AuthLogin(
                                          email: _emailController.text.trim(),
                                          password:
                                              _passwordController.text.trim(),
                                        ),
                                      );
                                      _formKey.currentState!.save();
                                      // Navigate to the main screen
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: AppPallete.primary,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(
                                      double.infinity,
                                      48,
                                    ),
                                    // shape: const StadiumBorder(),
                                  ),
                                  child: Text(
                                    "Sign in",
                                    style: TextStyles.body,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                TextButton(
                                  onPressed: () {
                                    // Navigate to the sign up screen
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const SignupPage(),
                                      ),
                                    );
                                  },
                                  child: Text.rich(
                                    const TextSpan(
                                      text: "Don’t have an account? ",
                                      children: [
                                        TextSpan(
                                          text: "Sign Up",
                                          style: TextStyle(
                                            color: Color(0xFF00BF6D),
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white, // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: const BorderSide(
                                        color: AppPallete.border,
                                        width: 1,
                                      ),
                                    ),
                                    elevation: 0, // Subtle shadow
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    minimumSize: const Size(
                                      double.infinity,
                                      48,
                                    ),
                                    // Full-width button
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",
                                        width: 20,
                                      ),
                                      const SizedBox(width: 20),
                                      const Text(
                                        'Sign in with Google',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
