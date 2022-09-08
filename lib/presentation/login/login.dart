import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm/presentation/login/login_viewmodel.dart';
import 'package:flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm/presentation/resources/value_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "/login_view";
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _userNameController = TextEditingController();
  final _userPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var _isUserInputValid = false;

  _bind() {
    final _viewModel = Provider.of<LoginViewModel>(context, listen: false);
    _userNameController.addListener(
      () {
        _viewModel.setUsername(_userNameController.text);
      },
    );
    _userPasswordController.addListener(() {
      _viewModel.setPassword(_userPasswordController.text);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<LoginViewModel>(context, listen: false).dispose();
    super.dispose();
  }

  void validateUserInputOnChange(_) {
    final isUsernameValid =
        LoginValidator.validateUserName(_userNameController.text);
    final isPasswordValid =
        LoginValidator.validatePassword(_userPasswordController.text);
    if (isUsernameValid == null && isPasswordValid == null) {
      setState(
        () {
          _isUserInputValid = true;
        },
      );
    } else {
      setState(() {
        _isUserInputValid = false;
      });
    }
  }

  void onButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<LoginViewModel>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Image(image: AssetImage(ImageAssets.splashLogo)),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: TextFormField(
                    controller: _userNameController,
                    keyboardType: TextInputType.emailAddress,
                    // validating logic 다시 짜기
                    validator: LoginValidator.validateUserName,
                    onChanged: validateUserInputOnChange,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      hintText: AppStrings.usernameHint,
                      label: Text(AppStrings.usernameHint),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: TextFormField(
                    controller: _userPasswordController,
                    validator: LoginValidator.validatePassword,
                    onChanged: validateUserInputOnChange,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      hintText: AppStrings.passwordHint,
                      label: Text(AppStrings.passwordHint),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child: ElevatedButton(
                      onPressed: _isUserInputValid ? () {} : null,
                      child: const Text(AppStrings.login),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginValidator {
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }

  static String? validateUserName(String? username) {
    if (username == null || username.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }
}
