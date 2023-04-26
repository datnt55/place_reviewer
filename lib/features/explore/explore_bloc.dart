import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

import '../../../utilities/network_response_result.dart';

@injectable
class LocationCubit extends Cubit<ResponseResult<LocationData>> {

  LocationCubit() : super(const ResponseResult.loading());

  void getLocation() async{
    var location = Location();
    var serviceEnable = await location.serviceEnabled();
    if (!serviceEnable){
      serviceEnable = await location.requestService();
      if (!serviceEnable){
        emit(const ResponseResult.error(exception: 'Không cấp quyền truy cập vị trí'));
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied){
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted){
        emit(const ResponseResult.error(exception: 'Không cấp quyền truy cập vị trí'));
      }
    }

    var userLocation = await location.getLocation();
    
    emit(ResponseResult.success(data: userLocation));
  }
}