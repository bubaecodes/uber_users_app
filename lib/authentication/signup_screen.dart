import 'package:flutter/material.dart';
import 'package:uber_users_app/authentication/login_screen.dart';
import 'package:uber_users_app/methods/common_methods.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController userPhoneEditingController = TextEditingController();

  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvailable(){
    cMethods.checkConnectivity(context);

    signUpFormValidation();
  }

  signUpFormValidation(){
    if (userNameEditingController.text.trim().length < 3) {
      cMethods.displaySnackBar('Your name must be at least 4 or more characters.', context);
    } else if(userNameEditingController.text.trim().length < 7) {
      cMethods.displaySnackBar('Your name must be at least 8 or more characters.', context);
    } else if(!emailEditingController.text.contains("@")){
      cMethods.displaySnackBar('Please enter a valid email.', context);
    } else if(passwordEditingController.text.trim().length < 5) {
      cMethods.displaySnackBar('Your name must be at least 6 or more characters', context);
    } else {
      /// register user

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
                      controller: userNameEditingController,
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
                      controller: userPhoneEditingController,
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
                      controller: emailEditingController,
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
                      controller: passwordEditingController,
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
                        checkIfNetworkIsAvailable();
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
