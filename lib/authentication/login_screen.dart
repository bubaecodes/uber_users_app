import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_users_app/authentication/signup_screen.dart';
import 'package:uber_users_app/global/global_var.dart';
import 'package:uber_users_app/pages/home_page.dart';
import 'package:uber_users_app/widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  signInFormValidation(){
    if(!emailTextEditingController.text.contains('@')){
      displaySnackBar('Please enter a valid email', context);
    } else if (passwordTextEditingController.text.trim().length < 5){
      displaySnackBar('Please enter a stronger password', context);
    } else{
      signInUser();
    }
  }

  Future<UserCredential?> signInUser() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => LoadingDialog(messageText: 'Logging you in ...'),
    );

    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
      );

      /// save user data in realtime database
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(userCredential.user!.uid);
      userRef.once().then((snap) {
        if(snap.snapshot.value != null){
          if((snap.snapshot.value as Map)['blockStatus'] == "no"){
            userName = (snap.snapshot.value as Map)['name'];
            Navigator.push(context, MaterialPageRoute(builder: (e)=> HomePage()));
          } else{
            FirebaseAuth.instance.signOut();
            displaySnackBar('Your are blocked. Contact admin: bubae@gmail.com', context);
          }
        } else {
          displaySnackBar('Please create an account.', context);
        }
      });
    

      Navigator.pop(context);
      displaySnackBar('Account registered successfully!', context);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => HomePage())
      // );

      return userCredential;
    } catch (e) {
      Navigator.pop(context);
      displaySnackBar(e.toString(), context);
      return null;
    }
  }

  void displaySnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png'),

              Text(
                'Login as a User',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// text fields + buttons
              Padding(
                padding: EdgeInsets.all(22),
                child: Column(
                  children: [
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'User Email',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          )
                      ),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),
                    ),
                    SizedBox(height: screenHeight / 40),
                    TextField(
                      controller: passwordTextEditingController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'User Password',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          )
                      ),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),
                    ),

                    SizedBox(height: screenHeight / 30),

                    ElevatedButton(
                        onPressed: (){
                          signInFormValidation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 10
                          ),
                        ),
                        child: const Text('Login')
                    )
                  ],
                ),
              ),

              SizedBox(height: screenHeight / 28),

              /// text button
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (e)=> SignupScreen()));
                  },
                  child: Text(
                    'Don\'t have an Account? Register Here',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
