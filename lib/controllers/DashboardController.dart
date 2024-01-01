
import 'package:get/get.dart';

import '../models/House.dart';
import '../services/service_api.dart';

class HomeController extends GetxController{
  var houses = <House>[].obs;
  var upperHouses = <House>[].obs;
  final _isLoading = true.obs;

  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  bool get isLoading => _isLoading.value;

  set selectedMenu(int index){
    _selectedIndex.value = index;
  }


  @override
  void onInit() async{
    super.onInit();
    await getUpperHouses();
    await getPopularHouses();
  }

  Future<void>getUpperHouses() async{
    try{
      _isLoading(true);
      var result = await ServiceApi().getUpperHouses();
      upperHouses.value = result;
    }finally{
      _isLoading(true);
    }
  }

  Future<void>getPopularHouses() async{
    try{
      _isLoading(true);
      var result = await ServiceApi().getHouses();
      houses.value = result;
    }finally{
      _isLoading(false);
    }
  }

}