import 'package:flutter/material.dart';
import 'package:maerifa/iti_project/product_model.dart';
import 'api_provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}
class _CategoriesScreenState extends State<CategoriesScreen> {
  ApiProvider apiProvider = ApiProvider();
  ProductsModel? productList;
  List? categoryList;
  String chosenCategory = 'beauty';
  bool loading = true;
  @override
  initState() {
    getdata();
    super.initState();
  }
  getdata() async {
    productList = await ApiProvider().getCategoryProducts(chosenCategory);
    categoryList = await ApiProvider().getCategoryList();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
          title: Text("Choose Your Category",
            style: TextStyle(
              // fontSize: 20),
            ),
          )),
      body:
      loading == true?
      Center(child: CircularProgressIndicator()):
      Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height *.06,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    chosenCategory =
                    categoryList![index];
                    productList = await ApiProvider().getCategoryProducts(chosenCategory);
                    setState((){});
                  },
                  child: Container(
                      width: 120,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent[700],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text('${categoryList![index]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width *.04),
                        ),
                      ),

                  ),
                );
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width *.02),
          Expanded(
            child: ListView.builder(
                itemCount: productList!.products!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      // leading: CircleAvatar(
                      //   child: Icon(Icons.person),
                      // ),
                      title: Text(productList!.products![index].title.toString()),
                      subtitle: Text(productList!.products![index].description.toString(),
                      maxLines: 2,style: TextStyle(color: Colors.lightBlue),),
                      trailing: Container(
                        width: MediaQuery.of(context).size.height *0.14,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Center(child: Text(productList!.products![index].price.toString()
                            ,style: TextStyle(color: Colors.white)),
                              ),
                              decoration: BoxDecoration(
                                color : Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(10)
                              ),
                                width: MediaQuery.of(context).size.height *0.045,
                              height: MediaQuery.of(context).size.height *0.03,
                            ),
                            CircleAvatar(
                                radius: MediaQuery.of(context).size.height *0.035,
                                child: Image.network("${productList!.products![index].thumbnail}")),
                          ],
                        ),
                      )
                  );
                }))
        ],
      ),


    );
  }

}