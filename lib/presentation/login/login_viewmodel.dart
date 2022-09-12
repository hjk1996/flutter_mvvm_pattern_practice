import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/data/data_source/remote_data_source.dart';
import 'package:flutter_mvvm/data/repository/repository_impl.dart';
import 'package:flutter_mvvm/domain/repository/repository.dart';
import 'package:flutter_mvvm/domain/usecase/login_usecase.dart';
import 'package:flutter_mvvm/presentation/base/base_viewmodel.dart';
import 'package:flutter_mvvm/presentation/login/login.dart';

class LoginViewModel with ChangeNotifier {
  String? _username;
  String? _password;

  late LoginUseCase? _loginUseCase;

  @override
  void dispose() {
    _loginUseCase = null;
    _username = null;
    _password = null;
    super.dispose();
  }

  void start() {}
}

extension LoginViewModelInputs on LoginViewModel {
  void setUsername(String? username) {
    _username = username;
  }

  void setPassword(String? password) {
    _password = password;
  }

  login() async {
    (await _loginUseCase!.execute(
      LoginUseCaseInput(
        _username!,
        _password!,
      ),
    ))
        .fold(
      (failure) {
        print(failure.message);
      },
      (data) {
        print(data.customer.name);
      },
    );
  }
}
