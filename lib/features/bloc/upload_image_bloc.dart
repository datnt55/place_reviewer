import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

import '../../../utilities/network_response_result.dart';
import '../../domain/repository/upload/upload_image_repository.dart';

@injectable
class UploadImageCubit extends Cubit<ResponseResult<String>> {

  final UploadImageRepository uploadImageRepository;

  UploadImageCubit(this.uploadImageRepository) : super(const ResponseResult.success(data: 'https://35express.org/wp-content/uploads/2021/02/tieu-su-cua-lisa-blackpink-35express.jpg'));

  void uploadImage(String path, String fileName) async{
    emit(const ResponseResult.loading());
    var response = await uploadImageRepository.uploadImage(path, fileName);
    if (response.isSuccess){
      emit(ResponseResult.success(data: response.onSucceed.files?.first.fileUrl ??''));
    }
  }
}