import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/login_bloc/bloc/login_bloc.dart';
import 'package:flutter_learning/login_bloc/bloc/login_event.dart';
import 'package:flutter_learning/login_bloc/bloc/login_state.dart';
import '../../network/resources/repository.dart';
import '../../utils/color.dart';
import '../../utils/spacings.dart';
import '../../utils/string.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

class LoginUsingBlockScreen extends StatelessWidget {
  LoginUsingBlockScreen({Key? key}) : super(key: key);
  final Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(_repository),
      child: const LoginUsingBlock(),
    );
  }
}

class LoginUsingBlock extends StatefulWidget {
  const LoginUsingBlock({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginUsingBlock> {
  bool isLoading = false;
  final TextEditingController _userNameController =
      TextEditingController(text: 'christoph+43@autosense.ch');
  final TextEditingController _passwordController =
      TextEditingController(text: 'Chris1234!');
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  bool validate() {
    if (!Utils.isValidEmail(_userNameController.value.text)) {
      Utils.showSnackBar(context, Strings.errorUserName);
      return false;
    } else if (_passwordController.value.text.isEmpty) {
      Utils.showSnackBar(context, Strings.errorPassword);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.colorF3F3F2,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState state) {
            if (state is LoginSuccess) {
              Utils.showSnackBar(context,
                  '${jsonDecode((state.getResponse?.result).toString())['access_token']}');
            } else if (state is LoginFailure) {
              Utils.showSnackBar(
                  context,
                  (state.networkError ?? state.getError?.error?.message)
                      .toString());
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            bloc: loginBloc,
            builder: (BuildContext context, LoginState state) {
              if (state is LoginInitial) {
                return getLoginWidget();
              } else if (state is LoginLoading) {
                return getLoginWidget(isLoading: true);
              } else if (state is LoginFailure) {
                return getLoginWidget();
              } else if (state is LoginSuccess) {
                return getLoginWidget();
              } else {
                return Container();
              }
            },
          ),
        ));
  }

  SingleChildScrollView getLoginWidget({bool isLoading = false}) {
    return (SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Spacings.medium, horizontal: Spacings.medium),
          child: Column(
            children: [
              const SizedBox(
                height: Spacings.xxxLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/zvolt_icon.png',
                  )
                ],
              ),
              const SizedBox(height: Spacings.xxxxLarge),
              const Text(Strings.lblLogin, style: TextStyles.titleH2),
              const SizedBox(height: Spacings.large),
              CustomTextField(
                hint: Strings.lblUsername,
                label: Strings.lblUsername,
                isEnabled: !isLoading,
                controller: _userNameController,
              ),
              const SizedBox(height: Spacings.medium),
              CustomTextField(
                hint: Strings.lblPassword,
                label: Strings.lblPassword,
                obscureText: true,
                isEnabled: !isLoading,
                controller: _passwordController,
              ),
              const SizedBox(height: Spacings.medium),
              SizedBox(
                  width: double.infinity,
                  child: ButtonElevated(
                    backgroundColor: Palette.color2167AE,
                    text: Strings.lblPrimary,
                    isLoading: isLoading,
                    press: () {
                      if (validate()) {
                        loginBloc.add(DoLoginWithUserNameAndPassword(
                            username: _userNameController.value.text,
                            password: _passwordController.value.text));
                      }
                    },
                  )),
              const SizedBox(height: Spacings.xLarge),
              const Text(Strings.lblForgotPassword,
                  style: TextStyles.textSmall),
              const SizedBox(height: Spacings.xLarge),
              const Text(Strings.lblCreateAccount, style: TextStyles.textSmall),
              const SizedBox(height: Spacings.xxxxLarge),
              Text.rich(
                TextSpan(
                  text: Strings.lblByUsingYouAgree,
                  style:
                      const TextStyle(fontSize: 12, color: Palette.color575757),
                  children: <InlineSpan>[
                    TextSpan(
                        text: Strings.lblTermsOfUse,
                        style: const TextStyle(color: Palette.color2167AE),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => debugPrint('Terms of Use')),
                    const TextSpan(
                      text: Strings.lblConfirmThatYou,
                    ),
                    TextSpan(
                        text: Strings.lblPrivacyPolicies,
                        style: const TextStyle(color: Palette.color2167AE),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => debugPrint('Privacy Policies')),
                  ],
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }
}
