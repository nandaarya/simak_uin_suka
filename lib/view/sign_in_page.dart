import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simak_uin_suka/theme.dart';
import 'package:simak_uin_suka/view/main_page.dart';

const users = {
  'mahasiswa@gmail.com': 'mahasiswa',
  'dosen@gmail.com': 'dosen',
  '21106050048': '21106050048'
};

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    checkIfAlreadyLogin();
    super.initState();
  }

  Duration get loginTime => const Duration(milliseconds: 2250);

  void checkIfAlreadyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      if (prefs.getString('username') != null &&
          prefs.getString('password') != null &&
          prefs.getString('email') != null &&
          prefs.getString('name') != null &&
          prefs.getString('nim_nip') != null &&
          prefs.getString('role') != null) {
        // Semua nilai prefs.getString() tidak null dan sudah memiliki nilai
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    }
  }

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    try {
      var url =
          Uri.parse('https://simak-back-end.cyclic.app/api/users/' 'login');
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
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', jsonData['data']['user']['username']);
          prefs.setString('password', jsonData['data']['user']['password']);
          prefs.setString('email', jsonData['data']['user']['email']);
          prefs.setString('name', jsonData['data']['user']['name']);
          prefs.setString('nim_nip', jsonData['data']['user']['nim_nip']);
          prefs.setString('role', jsonData['data']['user']['role']);

          debugPrint("Data username lokal: ${prefs.getString('username')}");
          debugPrint("Data password lokal: ${prefs.getString('password')}");
          debugPrint("Data email lokal: ${prefs.getString('email')}");
          debugPrint("Data nama lokal: ${prefs.getString('name')}");
          debugPrint("Data nim_nip lokal: ${prefs.getString('nim_nip')}");
          debugPrint("Data role lokal: ${prefs.getString('role')}");
        } catch (e) {
          debugPrint('Error accessing SharedPreferences: $e');
        }
        debugPrint('Berhasil Login');
        return null;
      } else {
        debugPrint(
            'POST request gagal dengan status code: ${response.statusCode}');
        return jsonData['message'];
      }
    } catch (e) {
      debugPrint('Something went wrong while login');
      // print(e);
    }
    return null;
  }

  Future<String?> _signupUser(SignupData data) async {
    debugPrint(
        'Signup Name: ${data.name}, Password: ${data.password}, ${data.additionalSignupData}');
    final additionalData = data.additionalSignupData!;
    final email = additionalData['email'].toString();
    final fullName = additionalData['fullName'].toString();
    final nimNip = additionalData['nim_nip'].toString();
    final role = additionalData['role'].toString();

    debugPrint(
        'Email: $email, Full Name: $fullName, NIM/NIP: $nimNip, Role: $role');
    try {
      var url = Uri.parse(
          'https://simak-back-end.cyclic.app/api/users/' 'register');
      var requestBody = json.encode({
        "username": data.name,
        "password": data.password,
        "email": email,
        "name": fullName,
        "nim_nip": nimNip,
        "role": role,
      });
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: requestBody);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 201) {
        // Proses response atau lakukan operasi lain setelah POST berhasil;
        debugPrint('Akun berhasil ditambahkan');
        return null;
      } else {
        debugPrint(
            'POST request gagal dengan status code: ${response.statusCode}');
        return jsonData['message'];
      }
    } catch (e) {
      debugPrint('Something went wrong while adding user');
      // print(e);
    }
    return null;
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
      loginAfterSignUp: false,
      userType: LoginUserType.name,
      userValidator: _usernameValidator,
      title: 'SIMAK UIN SUKA',
      logo: const AssetImage('assets/images/logo_uin.png'),
      messages: LoginMessages(
          userHint: 'Username', signUpSuccess: 'Akun berhasil didaftarkan'),
      theme: LoginTheme(
        titleStyle: h1,
        headerMargin: defaultMargin,
        authButtonPadding: EdgeInsets.all(2 * defaultPadding),
      ),
      hideForgotPasswordButton: true,
      additionalSignupFields: [
        UserFormField(
          keyName: 'email',
          displayName: 'Email',
          icon: const Icon(FontAwesomeIcons.envelope),
          fieldValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan email Anda!';
            }
            if (!value.contains('@') || !value.endsWith('uin-suka.ac.id')) {
              return 'Gunakan email UIN Sunan Kalijaga!';
            }
            return null;
          },
        ),
        UserFormField(
          keyName: 'fullName',
          displayName: 'Nama',
          icon: const Icon(FontAwesomeIcons.user),
          fieldValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan nama Anda!';
            }
            return null;
          },
        ),
        UserFormField(
          keyName: 'nim_nip',
          displayName: 'NIM / NIP',
          icon: const Icon(FontAwesomeIcons.idCard),
          fieldValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan NIM/NIP Anda!';
            }
            return null;
          },
        ),
        UserFormField(
          keyName: 'role',
          displayName: 'Status (mahasiswa/dosen)',
          icon: const Icon(FontAwesomeIcons.users),
          fieldValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Masukkan role Anda!';
            }
            if (value != 'mahasiswa' && value != 'dosen') {
              return 'Status harus mahasiswa atau dosen!';
            }
            return null;
          },
        ),
      ],
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
      //     providerNeedsSignUpCallback: () {
      //       // put here your logic to conditionally show the additional fields
      //       return Future.value(true);
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
