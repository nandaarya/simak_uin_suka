import 'package:flutter/material.dart';
import 'package:simak_uin_suka/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {


    Widget header() {
      return Container(
        alignment: AlignmentDirectional.centerStart,
        height: 100,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            )),
        child: Text(
          'Profil',
          style: h1,
        ),
      );
    }
    
    Widget profile() {
      return Container(
        height: 200,
        padding: EdgeInsets.all(defaultPadding),
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            const Icon(Icons.account_circle, size: 100,),
            Text('Nanda Arya Putra', style: h2,),
            Text('21106050048', style: h2,),
            Text('User Mahasiswa', style: h2,)
          ],
        ),
      );
    }

    Widget setting() {
      return Container(
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Ubah Bahasa', style: h2,),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Container(height: 1, color: primaryColor,),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Ubah Data', style: h2,),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Container(height: 1, color: primaryColor,),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Ubah Kata Sandi', style: h2,),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Container(height: 1, color: primaryColor,),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Logout', style: h2.copyWith(color: Colors.red),),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Container(height: 1, color: primaryColor,),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [header(), const SizedBox(height: 24), profile(), const SizedBox(height: 24), setting()],
      ),
    );
  }
}
