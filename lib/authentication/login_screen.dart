import 'package:flutter/material.dart';
import 'package:uber_users_app/authentication/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

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
