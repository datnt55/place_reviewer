import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_reviewer/di/injection.dart';
import 'package:place_reviewer/features/bloc/upload_image_bloc.dart';
import 'package:place_reviewer/navigation_service.dart';

import '../../utilities/network_response_result.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, top: 16),
              child: InkResponse(
                child: Icon(Icons.close),
                onTap: () {
                  getIt<NavigationService>().pop();
                },
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  BlocProvider(
                    create: (_) => getIt<UploadImageCubit>(),
                    child: BlocBuilder<UploadImageCubit, ResponseResult<String>>(builder: (context, response) {
                      if (response.isLoading) {
                        Container(
                          width: 120.0,
                          height: 120.0,
                          child: CircularProgressIndicator(),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.red,
                          ),
                        );
                      } else if (response.isSuccess){
                        return GestureDetector(
                          onTap:() => _showActionSheet(context),
                          child: CachedNetworkImage(
                            imageUrl: response.onSucceed,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 4, color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.red,
                                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        );
                      }
                      return Container();
                    }),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Cristino Ronaldo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    'cristino_ronaldo@gmail.com',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  ListTile(
                    title: const Text('My Places'),
                    leading: Icon(Icons.place),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black12,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  ListTile(
                    title: const Text('My Favourite'),
                    leading: Icon(Icons.favorite),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black12,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  ListTile(
                    title: const Text('Change Password'),
                    leading: Icon(Icons.password),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],

              ),
            )),
            InkWell(
              child: Container(
                height: 48,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Đăng xuất',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              onTap: () {
                getIt<NavigationService>().showLogin();
              },
            )
          ],
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(BuildContext context, ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (context.mounted) {
      context.read<UploadImageCubit>().uploadImage(pickedFile?.path ?? '', pickedFile?.name ?? '');
    }
  }

  void _showActionSheet(BuildContext rootContext) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              _onImageButtonPressed(rootContext, ImageSource.gallery);
              dispose();
            },
            child: const Text('Thay đổi ảnh đại diện'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Hủy'),
        ),
      ),
    );
  }
}
