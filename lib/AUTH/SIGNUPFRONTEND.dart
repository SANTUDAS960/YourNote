import 'package:flutter/material.dart';

import '../HOME/Home.dart';

class SIGNUPFRONTEND extends StatefulWidget {
  const SIGNUPFRONTEND({super.key});

  @override
  State<SIGNUPFRONTEND> createState() => _SIGNUPFRONTENDState();
}

class _SIGNUPFRONTENDState extends State<SIGNUPFRONTEND> {
  bool _obscureText = true; // Initially hide the password
  bool isLogin = true; // Controls whether to show login or signup form

  // Firebase Auth instance

  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top image card
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Card(
                elevation: 8,
                margin: EdgeInsets.zero,
                color: Colors.blue,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(300),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Image.asset(
                    "assets/images/yournode.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Row for Login and SignUp buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = true; // Show login form
                    });
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      // if true then it will work as a Login Page
                      color: isLogin ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = false; // Show sign-up form
                    });
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: !isLogin ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Conditional rendering of Login or SignUp form
            isLogin ? buildLoginForm() : buildSignUpForm(),
          ],
        ),
      ),
    );
  }

  // Login Form
  buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Card(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter your Email",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Enter your password",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SignUp Form
  buildSignUpForm() {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Card(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter your Email",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Enter your password",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Confirm your password",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: ()  {
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when not needed
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
