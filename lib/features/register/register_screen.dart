import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:place_reviewer/features/login/login_bloc.dart';
import 'package:place_reviewer/navigation_service.dart';

import '../../di/injection.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible = false;
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var emailController = TextEditingController();

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
              height: double.infinity,
                color: Colors.blue.shade400,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 54),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16,  top: 100, right: 16),
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
                              SizedBox(height: 38,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  controller: userNameController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Tài khoản',
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
                                    labelText: 'Nhập mật khẩu',
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
                                    labelText: 'Nhập lại mật khẩu',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  controller: userNameController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.email_outlined)
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
                                  child: const Text('Đăng ký')),
                              const SizedBox(
                                height: 8.0,
                              ),
                            ],
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl: '',
                          imageBuilder: (context, imageProvider) => Container(
                            width: 148.0,
                            height: 148.0,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                              border: Border.all(color: Colors.white, width: 8),
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Container(
                            width: 148.0,
                            height: 148.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                              color: Colors.grey.shade300,
                              border: Border.all(color: Colors.white, width: 8),
                              borderRadius: BorderRadius.circular(16),
                            ), child: Image.asset('resource/person.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

            );
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}