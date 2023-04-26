import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../utilities/network_response_result.dart';

@injectable
class LoginCubit extends Cubit<bool> {

  LoginCubit() : super(false);

  void doLogin() async{
    emit(true);
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(false);
    });
  }
}