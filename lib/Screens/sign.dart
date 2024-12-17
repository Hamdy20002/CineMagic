import 'package:cinemagic/Models/auth.dart';
import 'package:cinemagic/Screens/Tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class signScreen extends StatefulWidget {
  const signScreen({super.key, required this.type});

  final String type;

  @override
  State<signScreen> createState() => _signScreenState();
}

class _signScreenState extends State<signScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true; //Not visiable

  void _sign(bool SignIn) async {
    if (_formKey.currentState!.validate()) {
      final userEmail = _emailController.text;
      final userPassword = _passwordController.text;

      if (SignIn == true) {
        bool res = await authServices()
            .signIn_Fun(email: userEmail, password: userPassword);
        if (res) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (ctx) => tab(
                      is_User: true,
                    )),
          );
        }
      } else {
        bool res = await authServices()
            .signUp_Fun(email: userEmail, password: userPassword);
        if (res) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => signScreen(
                type: "i",
              ),
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool is_SignIn = widget.type == "i"; // Simplified logic

    return Scaffold(
      appBar: AppBar(
        title: Text(
          is_SignIn ? "SignIn" : "SignUp",
          style: TextStyle(
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        // Added SafeArea to prevent layout issues
        child: Center(
          // Added Center to help with layout
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _sign(is_SignIn);
                        },
                        child: Text(
                          is_SignIn ? "SignIn" : "SignUp",
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    if (is_SignIn)
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => signScreen(
                                  type: "u",
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Create new account",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 20.h),
                    if (!is_SignIn)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => signScreen(
                                type: "i",
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Have an email?",
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    if (is_SignIn)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => tab(is_User: false),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_fix_high,
                              size: 12.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "As Anonymous",
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
