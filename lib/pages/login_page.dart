import 'package:app_tugas_akhir_mobile/firebase_auth_implementation/firebase_auth_service.dart';
import 'package:app_tugas_akhir_mobile/pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authService = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SvgPicture.asset("assets/Group_1.svg"),
                SizedBox(height: 30.0),
                Text(
                  "Selamat Datang",
                  style: GoogleFonts.mPlusRounded1c(
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(41, 137, 158, 1),
                    ),
                  ),
                ),
                Text(
                  "di aplikasi saya Grace Oscarissa Amianie",
                  style: GoogleFonts.mPlusRounded1c(
                    textStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(41, 137, 158, 1),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField("EMAIL", (value) => _email = value,
                              email: true),
                          SizedBox(height: 10.0),
                          _buildTextField(
                              "PASSWORD", (value) => _password = value,
                              password: true),
                          SizedBox(height: 20.0),
                          Center(
                            child: Container(
                              width: 162.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(86, 225, 255, 1),
                                    Color.fromRGBO(6, 88, 106, 1),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    User? user = await _authService
                                        .loginWithEmailAndPassword(
                                            _email, _password);

                                    if (user != null) {
                                      Map<String, dynamic>? userData =
                                          await _authService.getUserData(user);

                                      if (userData != null) {
                                        // Navigasi ke HomePage
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) => HomePage(
                                            nama: userData['nama'],
                                            nim: userData['nim'],
                                            noWhatsapp: userData['noWhatsapp'],
                                            email: userData['email'],
                                          ),
                                        ));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('User data not found')),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Login gagal, silakan coba lagi')),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  "Log In",
                                  style: GoogleFonts.mPlusRounded1c(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Belum Punya Akun? ",
                                style: GoogleFonts.mPlusRounded1c(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                                },
                                child: Text(
                                  "Sign up",
                                  style: GoogleFonts.mPlusRounded1c(
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(58, 187, 216, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                SvgPicture.asset("assets/Group_2.svg"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onSaved,
      {bool email = false, bool password = false}) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(86, 84, 84, 1),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 10.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Color.fromRGBO(58, 187, 216, 1),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
        ),
        obscureText: password,
        keyboardType: email ? TextInputType.emailAddress : TextInputType.text,
        onSaved: (value) => onSaved(value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }
}
