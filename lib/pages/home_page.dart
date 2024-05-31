import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final String nama;
  final String nim;
  final String noWhatsapp;
  final String email;

  HomePage({
    required this.nama,
    required this.nim,
    required this.noWhatsapp,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/Group_1.svg"),
            SizedBox(height: 30.0),
            Center(
              child: Text(
                "Selamat Anda Berhasil Login!",
                style: GoogleFonts.mPlusRounded1c(
                  textStyle: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(41, 137, 158, 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Nama: $nama',
                    style: GoogleFonts.mPlusRounded1c(
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(41, 137, 158, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'NIM: $nim',
                    style: GoogleFonts.mPlusRounded1c(
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(41, 137, 158, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No WhatsApp: $noWhatsapp',
                    style: GoogleFonts.mPlusRounded1c(
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(41, 137, 158, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Email: $email',
                    style: GoogleFonts.mPlusRounded1c(
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(41, 137, 158, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SvgPicture.asset("assets/Group_2.svg"),
          ],
        ),
      ),
    );
  }
}
