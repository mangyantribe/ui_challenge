
import 'package:get/get.dart';

class PhotoViewerController extends GetxController{

  final photos = <String>[].obs;
  final _galleryCurrentIndex = 0.obs;
  int get galleryCurrentIndex => _galleryCurrentIndex.value;

  set selectedPhoto(int index){
    _galleryCurrentIndex.value = index;
  }

  @override
  void onInit() async{
    super.onInit();
    photos.value = Get.arguments;
  }
}