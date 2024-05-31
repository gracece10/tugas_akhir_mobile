import 'package:app_tugas_akhir_mobile/firebase_auth_implementation/firebase_auth_service.dart';
import 'package:app_tugas_akhir_mobile/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _authService = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();

  String _nama = '';
  String _nim = '';
  String _noWhatsapp = '';
  String _email = '';
  String _password = '';

  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _noWhatsappController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _noWhatsappController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                Text(
                  "Sign Up",
                  style: GoogleFonts.mPlusRounded1c(
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(41, 137, 158, 1),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
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
                          _buildTextField("NAMA", (value) => _nama = value,
                              controller: _namaController),
                          SizedBox(height: 15.0),
                          _buildTextField("NIM", (value) => _nim = value,
                              controller: _nimController),
                          SizedBox(height: 15.0),
                          _buildTextField(
                              "NO WHATSAPP", (value) => _noWhatsapp = value,
                              controller: _noWhatsappController),
                          SizedBox(height: 15.0),
                          _buildTextField("EMAIL", (value) => _email = value,
                              email: true, controller: _emailController),
                          SizedBox(height: 15.0),
                          _buildTextField(
                              "PASSWORD", (value) => _password = value,
                              password: true, controller: _passwordController),
                          SizedBox(height: 15.0),
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
                                    try {
                                      User? user = await _authService
                                          .signUpWithEmailAndPassword(
                                        email: _email,
                                        password: _password,
                                        name: _nama,
                                        nim: _nim,
                                        phoneNumber: _noWhatsapp,
                                      );

                                      if (user != null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Berhasil Terdaftar')),
                                        );
                                        setState(() {
                                          _clearForm();
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Pendaftaran gagal, silakan coba lagi')),
                                        );
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Error: ${e.message}')),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  "Sign Up",
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
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sudah Punya Akun? ",
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
                                      builder: (context) => LoginPage()));
                                },
                                child: Text(
                                  "Login",
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
      {bool email = false,
      bool password = false,
      required TextEditingController controller}) {
    return Container(
      width: double.infinity,
      height: 40.0,
      child: TextFormField(
        controller: controller,
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

  void _clearForm() {
    _namaController.clear();
    _nimController.clear();
    _noWhatsappController.clear();
    _emailController.clear();
    _passwordController.clear();
  }
}
