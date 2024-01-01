
import 'package:get/get.dart';

class DetailsController extends GetxController{

  var isFavorite = false.obs;

  set tagAsFavorite(value){
    isFavorite(!value);
  }
}