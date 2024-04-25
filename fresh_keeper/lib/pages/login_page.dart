import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresh_keeper/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final StreamSubscription<AuthState> _authStateSubscription;
  bool _isLoading = false;
  bool _redirecting = false;

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/account');
      }
    });
    super.initState();
  }

  Future<void> signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Succesful!')),
        );
        _emailController.clear();
      }
    } on AuthException catch (error) {
      SnackBar(
        content: Text(error.message),
        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 223, 223),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.phone_android_outlined,
                size: 100,
              ),
              const SizedBox(
                height: 75,
              ),
              // Hello
              const Text(
                "Hello,",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const Text(
                "Welcome back!",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Email"),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10.0),

              // password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Password"),
                    ),
                  ),
                ),
              ),

              // sign in
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: GestureDetector(
                  onTap: signIn,
                  child: AbsorbPointer(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 36, 36, 36),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10.0),

              // register
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?"),
                  Text(
                    " Register Now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
  @override
  Future<void> debugFillProperties(properties) async {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('_isLoading', _isLoading));
  }
}
