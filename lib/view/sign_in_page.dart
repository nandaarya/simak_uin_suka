import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:simak_uin_suka/theme.dart';
import 'package:simak_uin_suka/view/main_page.dart';

const users = {
  'mahasiswa@gmail.com': 'mahasiswa',
  'dosen@gmail.com': 'dosen',
  '21106050048': '21106050048'
};

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  String? _usernameValidator(String? username) {
    if (username == null || username.isEmpty) {
      return 'Masukkan NIM/NIP';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      loginAfterSignUp: true,
      userType: LoginUserType.name,
      userValidator: _usernameValidator,
      title: 'SIMAK UIN SUKA',
      logo: const AssetImage('assets/images/logo_uin.png'),
      messages: LoginMessages(
        userHint: 'NIM / NIP'
      ),
      theme: LoginTheme(
        titleStyle: h1,
        headerMargin: defaultMargin,
        authButtonPadding: EdgeInsets.all(2 * defaultPadding),
      ),
      onLogin: _authUser,
      onSignup: _signupUser,
      //
      // loginProviders: <LoginProvider>[
      //   LoginProvider(
      //     icon: FontAwesomeIcons.google,
      //     label: 'Google',
      //     callback: () async {
      //       debugPrint('start google sign in');
      //       await Future.delayed(loginTime);
      //       debugPrint('stop google sign in');
      //       return null;
      //     },
      //   ),
      // ],
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MainPage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}