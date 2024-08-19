import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:maerifa/iti_project/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiProvider{
ProductsModel? productList;

final String baseUrl = "https://dummyjson.com";

getCategoryList() async {
  Response categoryList= await Dio().get(
      "$baseUrl/products/category-list"
  );
  return List<String>.from(categoryList.data);
}

getCategoryProducts(String category) async {
  Response response= await Dio().get(
  'https://dummyjson.com/products/category/$category');
  productList = ProductsModel.fromJson(response.data);
  return productList ;
}

 Future<ProductsModel?> getProduct() async{

   SharedPreferences prefs = await SharedPreferences.getInstance();

Response response= await Dio().get("$baseUrl/products",
queryParameters: {
  "limit" : 35,
  "select" : "id,title,price,description,thumbnail,category"
},
// options: Options(
//   headers: {
//     "Authorization":"Bearer ${prefs.getString("userToken")}"
//   }
// )
);
log(response.data.toString());
productList = ProductsModel.fromJson(response.data);
return productList ;

  }

Future<Response?> userLogin({required String username ,required String password}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
   FormData userData= FormData.fromMap({
    "username":username,
    "password" :password
  });
  try{
 Response response = await Dio().post('$baseUrl/auth/login',
        data: userData);
    await prefs.setString("userToken", response.data['token']);
    String? userToken = prefs.getString("userToken");
    print("userToken is '$userToken'");
    return response;
  }
  catch(e){
    if(e is DioException){
      print(e.response?.data);
    }
    print(e);
  }
}
}