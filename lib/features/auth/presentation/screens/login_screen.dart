import 'package:flutter/material.dart';
import 'package:uyishi/features/auth/presentation/controller/auth_provider.dart';
import 'package:uyishi/features/auth/presentation/screens/register_screen.dart';
import 'package:uyishi/features/home/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 5),
                Text(
                  "Enter your email to start shopping and get awesome deals today!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.phone, color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 3),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: _isPasswordHidden,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock, color: Colors.black54),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 3),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(
                        340,
                        50,
                      )),
                  onPressed: () async {
                    await authProvider.loginWithPhone(
                      phoneNumber: phoneController.text.trim(),
                      password: passwordController.text.trim(),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(authProvider.message),
                      ),
                    );

                    if (authProvider.message.contains("succcesfuly")) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    }
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                    Text("or"),
                    Container(
                      width: 150,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: 340,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google.png",
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 10),
                      Text("Log In with Google")
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 340,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook, color: Colors.blue),
                      SizedBox(width: 10),
                      Text("Log In with Google")
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  ),
                  child: Text(
                    "Don't have an account? Register",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
