import 'package:flutter/material.dart';
import 'package:mothering_business_network/login.dart';
import 'package:mothering_business_network/utils.dart';

class SuccessfulRegistration extends StatelessWidget {
  const SuccessfulRegistration({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   "Change Password",
        //   textAlign: TextAlign.center,
        //   style: SafeGoogleFont(
        //     'Poppins SemiBold',
        //     fontSize: 34 * ffem,
        //     fontWeight: FontWeight.w400,
        //     height: 1.2575 * ffem / fem,
        //     color: Color(0xff9BA6BF),
        //   ),
        // ),
        // centerTitle: true,
        backgroundColor: Color(0xff45536A),
        leading: IconButton(
          icon:
          Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xff9BA6BF)),
          onPressed: () =>  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => Login(),
          ), (route) => false),
        ),
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomRight,
        //       colors: <Color>[Color(0xff000000), Color(0xff000000)],
        //     ),
        //   ),
        // ),
        elevation: 0.5,
      ),
      backgroundColor: Color(0xff45536A),
      body: Container(
          decoration: BoxDecoration (
            gradient: LinearGradient (
              begin: Alignment(0.184, 1),
              end: Alignment(0.184, -1),
              colors: <Color>[Color(0xff000000), Color(0x00000000)],
              stops: <double>[0, 1],
            ),
          ),
          child: Column(
            children:[
              SizedBox(
                height: 80,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  'assets/MBN_Logo.png',
                  // height: 170,
                  width: 110,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
              padding: const EdgeInsets.fromLTRB(25,60,10,0),
              child: Text('Welcome to MBN India. You have successfully registered. Our team will get back to you   in 48 hours!!!' , style: SafeGoogleFont(
                'Poppins',
                fontSize: 26 * ffem,
                fontWeight: FontWeight.w500,
                height: 1.5 * ffem / fem,
                color: Colors.grey,
              ),
              ),
            ),]
          )
        // GestureDetector(
        //   onTap: () {
        //     FocusScope.of(context).requestFocus(new FocusNode());
        //   },
        //   child: Form(
        //     key: _formKey,
        //     child: Column(
        //       children: [
        //         SizedBox(
        //           height: 10,
        //         ),
        //         Container(
        //           // emailorphnmbrCKV (234:30)
        //           margin:
        //           EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 15 * fem),
        //           padding:
        //           EdgeInsets.fromLTRB(25 * fem, 5 * fem, 25 * fem, 16 * fem),
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //             // border: Border.all(color: Color(0xd8e3e6ef)),
        //             // color: Color(0xff111111),
        //             borderRadius: BorderRadius.circular(5 * fem),
        //           ),
        //           child: TextFormField(
        //             controller: emailController,
        //             validator: (value) {
        //               if (value.isEmpty && !isEmail(value)) {
        //                 return 'Please enter your password in correct format';
        //               }
        //               return null;
        //             },
        //             style: SafeGoogleFont(
        //               'Poppins',
        //               fontSize: 16 * ffem,
        //               fontWeight: FontWeight.w400,
        //               height: 1.5 * ffem / fem,
        //               color: Colors.grey,
        //             ),
        //             decoration: InputDecoration(
        //                 labelText: 'Email',
        //                 labelStyle: new TextStyle(
        //                   color: Colors.grey,
        //                 ),
        //                 focusedBorder: UnderlineInputBorder(
        //                   borderSide: BorderSide(color: Colors.white),
        //                 ),
        //                 enabledBorder: UnderlineInputBorder(
        //                   borderSide: BorderSide(color: Colors.white),
        //                 ),
        //                 prefixIcon: Icon(
        //                   Icons.mail_outlined,
        //                   color: Colors.white,
        //                 ),
        //                 border: UnderlineInputBorder(
        //                     borderSide: BorderSide(color: Colors.white))),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Container(
        //           padding:
        //           EdgeInsets.fromLTRB(25 * fem, 5 * fem, 25 * fem, 16 * fem),
        //           child: GestureDetector(
        //             onTap: () {
        //               if (_formKey.currentState.validate()) {
        //                 getPostApi();
        //                 // postRequest(
        //                 //   emailController.text,
        //                 // );
        //                 // print(field);
        //                 // if(cred!.=='success'){
        //                 //
        //                 // }
        //
        //               }
        //             },
        //             child: Container(
        //               // btn123 (234:33)
        //               width: double.infinity,
        //               height: 55 * fem,
        //               decoration: BoxDecoration(
        //                 color: Color(0xff368596),
        //                 borderRadius: BorderRadius.circular(10 * fem),
        //               ),
        //               child: Center(
        //                 child: Text(
        //                   'Submit',
        //                   textAlign: TextAlign.center,
        //                   style: SafeGoogleFont(
        //                     'Poppins Medium',
        //                     fontSize: 16 * ffem,
        //                     fontWeight: FontWeight.w400,
        //                     height: 1.2575 * ffem / fem,
        //                     letterSpacing: 1.6 * fem,
        //                     color: Color(0xffffffff),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
