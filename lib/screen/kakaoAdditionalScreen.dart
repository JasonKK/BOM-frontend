import 'package:flutter/material.dart';

class additionalPage extends StatelessWidget {
  const additionalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: kakaoAdditionalPage());
  }
}

class kakaoAdditionalPage extends StatefulWidget {
  const kakaoAdditionalPage({Key? key}) : super(key: key);

  @override
  State<kakaoAdditionalPage> createState() => _kakaoAdditionalPageState();
}

class _kakaoAdditionalPageState extends State<kakaoAdditionalPage> {
  // final formKey = GlobalKey<FormState>();
  //
  // String name = '';
  // String email = '';
  // String password = '';
  // String address = '';
  // String nickname = '';

  Widget build(BuildContext context) {
    return Scaffold();
  }
}
//   return DefaultAppbarLayout(
//     child: Form(
//       key: this.formKey,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             renderTextFormField(
//               label: '이름',
//               onSaved: (val) {},
//               validator: (val) {
//                 if(val.length < 1) {
//                   return '이름은 필수사항입니다.';
//                 }
//
//                 if(val.length < 2) {
//                   return '이름은 두글자 이상 입력 해주셔야합니다.';
//                 }
//
//                 return null;
//               },
//             ),
//             renderTextFormField(
//               label: '이메일',
//               onSaved: (val) {
//               },
//               validator: (val) {
//                 if(val.length < 1) {
//                   return '이메일은 필수사항입니다.';
//                 }
//
//                 if(!RegExp(
//                     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//                     .hasMatch(val)){
//                   return '잘못된 이메일 형식입니다.';
//                 }
//
//                 return null;
//               },
//             ),
//             renderTextFormField(
//               label: '비밀번호',
//               onSaved: (val) {},
//               validator: (val) {
//                 if(val.length < 1) {
//                   return '비밀번호는 필수사항입니다.';
//                 }
//
//                 if(val.length < 8){
//                   return '8자 이상 입력해주세요!';
//                 }
//                 return null;
//               },
//             ),
//             renderTextFormField(
//               label: '주소',
//               onSaved: (val) {},
//               validator: (val) {
//                 if(val.length < 1) {
//                   return '주소는 필수사항입니다.';
//                 }
//                 return null;
//               },
//             ),
//             renderTextFormField(
//               label: '닉네임',
//               onSaved: (val) {},
//               validator: (val) {
//                 if(val.length < 1) {
//                   return '닉네임은 필수사항입니다.';
//                 }
//                 if(val.length < 8) {
//                   return '닉네임은 8자 이상 입력해주세요!';
//                 }
//                 return null;
//               },
//             ),
//             renderButton(),
//           ],
//         ),
//       ),
//     ),
//   );
// }
