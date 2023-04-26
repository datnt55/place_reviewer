import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:place_reviewer/features/login/login_bloc.dart';
import 'package:place_reviewer/navigation_service.dart';

import '../../di/injection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<LoginCubit>(),
        child: BlocConsumer<LoginCubit, bool>(
          listener:(context, response) async{
            debugPrint('LOADING $response');
            if (response == true){
              await EasyLoading.show(
                status: 'loading...',
                maskType: EasyLoadingMaskType.black,
              );
            }else{
              await EasyLoading.dismiss();
              getIt<NavigationService>().navigateTo('home');
            }
          },
          builder: (context, response) {
            debugPrint('LOADING builder $response');
            return Container(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
                color: Colors.blue.shade400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: const Text("WELCOME", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,color: Colors.white),),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: const Text("Please login to your account", style: TextStyle(color : Colors.white70, fontWeight: FontWeight.bold, fontSize: 16),),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: TextFormField(
                              controller: userNameController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Username',
                                  prefixIcon: Icon(Icons.person)
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: !_passwordVisible, //This will obscure text dynamically
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.key),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                var userName = userNameController.text;
                                var password = passwordController.text;
                                context.read<LoginCubit>().doLogin();
                                debugPrint('EasyLoading show ${userName} - ${password}');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                onPrimary: Colors.white,
                                shadowColor: Colors.blue.shade300,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                minimumSize: const Size(100, 48), //////// HERE
                              ),
                              child: const Text('Login')),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text('Don\'t have an account yet?', style: TextStyle(color: Colors.white),),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Center(
                            child: Text('Sign up now',
                              style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,),),
                          ),
                        ],
                      ),
                      onTap: () => getIt<NavigationService>().navigateTo('register'),
                    )
                  ],
                )

            );
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}