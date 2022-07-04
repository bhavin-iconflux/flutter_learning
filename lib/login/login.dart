import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/api_constants.dart';
import 'package:flutter_learning/utils/color.dart';
import 'package:flutter_learning/utils/request_params.dart';
import 'package:flutter_learning/utils/spacings.dart';
import 'package:flutter_learning/utils/string.dart';
import 'package:flutter_learning/utils/text_style.dart';
import 'package:flutter_learning/utils/utils.dart';
import 'package:flutter_learning/widgets/button.dart';
import 'package:flutter_learning/widgets/text_field.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> callLoginAPI(String userName, String password) async {
    Utils.hideKeyBoard(context);
    if (validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await http.post(
            Uri.parse(ApiConstants.baseUrl + ApiConstants.login),
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
            },
            body: jsonEncode(<String, String>{
              RequestParams.userName: userName,
              RequestParams.password: password,
              RequestParams.authProviderId: 'internal:aax-zvolt'
            }));
        if (response.statusCode == 200) {
          Utils.showSnackBar(
              context,
              Strings.strLoginSuccess +
                  jsonDecode(response.body)['access_token']);
        } else if (response.statusCode == 401) {
          Utils.showSnackBar(context, jsonDecode(response.body)['message']);
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        Utils.showSnackBar(context, e.toString());
      }
    }
  }

  bool validate() {
    if (_userNameController.value.text.isEmpty) {
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
      body: SingleChildScrollView(
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
                controller: _userNameController,
              ),
              const SizedBox(height: Spacings.medium),
              CustomTextField(
                hint: Strings.lblPassword,
                label: Strings.lblPassword,
                obscureText: true,
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
                      callLoginAPI(_userNameController.value.text,
                          _passwordController.value.text);
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
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }
}
