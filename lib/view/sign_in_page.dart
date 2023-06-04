import 'dart:convert';
import 'package:http/http.dart' as http;
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

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    try {
      var url =
          Uri.parse('https://simak-back-end.cyclic.app/api/users/' + 'login');
      var requestBody = json.encode({
        "username": data.name,
        "password": data.password,
      });
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: requestBody);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        // Proses response atau lakukan operasi lain setelah POST berhasil
        // var classCode = jsonData['data']['classCode'];
        print('Berhasil Login');
        print(jsonData);
        return null;
      } else {
        print('POST request gagal dengan status code: ${response.statusCode}');
        return jsonData['message'];
      }
    } catch (e) {
      print('Something went wrong while login');
      print(e);
    }
    return null;
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
      messages: LoginMessages(userHint: 'NIM / NIP'),
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
