import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_users_app/authentication/login_screen.dart';
import 'package:uber_users_app/pages/home_page.dart';
import 'package:uber_users_app/widgets/loading_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController userPhoneTextEditingController = TextEditingController();

  // CommonMethods cMethods = CommonMethods();
  //
  // checkIfNetworkIsAvailable(){
  //   cMethods.checkConnectivity(context);
  //
  //   signUpFormValidation();
  // }

  signUpFormValidation(){
    if (userNameTextEditingController.text.trim().length < 5) {
      displaySnackBar('Your name must be at least 6 or more characters.', context);
      return;
    } else if(!emailTextEditingController.text.contains("@")){
      displaySnackBar('Please enter a valid email.', context);
      return;
    } else if(passwordTextEditingController.text.trim().length < 5) {
      displaySnackBar('Your password must be at least 6 or more characters', context);
      return;
    } else {
      /// register user
      registerNewUser();
    }
  }

  // signUpFormValidation(){
  //   if (userNameTextEditingController.text.trim().length < 3) {
  //     displaySnackBar('Your name must be at least 4 or more characters.', context);
  //   } else if(userNameTextEditingController.text.trim().length < 7) {
  //     displaySnackBar('Your name must be at least 8 or more characters.', context);
  //   } else if(!emailTextEditingController.text.contains("@")){
  //     displaySnackBar('Please enter a valid email.', context);
  //   } else if(passwordTextEditingController.text.trim().length < 5) {
  //     displaySnackBar('Your name must be at least 6 or more characters', context);
  //   } else {
  //     /// register user
  //     registerNewUser();
  //   }
  // }

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

  // registerNewUser() async {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) => LoadingDialog(messageText: 'Registering your account...'),
  //   );
  //
  //   final User? userFirebase = (
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: emailTextEditingController.text.trim(),
  //         password: passwordTextEditingController.text.trim(),
  //     ).catchError((errorMessage) {
  //       displaySnackBar(errorMessage.toString(), context);
  //     })
  //   ).user;
  // }

  Future <UserCredential?> registerNewUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => LoadingDialog(messageText: 'Registering your account...'),
    );
    print('first');

    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      );

      print('second');
      /// save user data in realtime database
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(userCredential.user!.uid);

      print('third');

      Map userDataMap = {
        "name": userNameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": userPhoneTextEditingController.text.trim(),
        "id": userCredential.user!.uid,
        "blockStatus": "no",
      };
      print('fourth');
      await userRef.set(userDataMap);

      print('fifth');

      Navigator.pop(context);
      displaySnackBar('Account registered successfully!', context);
      
      Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HomePage())
      );

      return userCredential;

    } catch (e) {
      Navigator.pop(context);
      displaySnackBar(e.toString(), context);
      return null;
    }


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
                'Create a User\'s Account',
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
                      controller: userNameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'User Name',
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
                      controller: userPhoneTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'User Phone',
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
                        signUpFormValidation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 10
                        ),
                      ),
                      child: const Text('Sign Up')
                    )
                  ],
                ),
              ),

              SizedBox(height: screenHeight / 28),

              /// text button
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (e)=> LoginScreen()));
                },
                child: Text(
                  'Already have an Account? Login Here',
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
