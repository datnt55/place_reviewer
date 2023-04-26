
import 'dart:io';

import '../../../utilities/network_response_result.dart';
import '../../entities/upload_image_response.dart';

abstract class UploadImageRepository{

  Future<ResponseResult<UploadImageResponse>> uploadImage(String path, String fileName);
}