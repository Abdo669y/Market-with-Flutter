import 'package:flutter/material.dart';
import 'package:maerifa/iti_project/categories.dart';
import 'package:maerifa/iti_project/product_model.dart';
import 'profile.dart';
import 'api_provider.dart';
ProductsModel? productList;
 bool loading = true;
class Home_ITI extends StatefulWidget {
  const Home_ITI({super.key});
  @override
  State<Home_ITI> createState() => _Home_ITIState();
}
class _Home_ITIState extends State<Home_ITI> {
  ApiProvider apiProvider = ApiProvider();

  List? categoryList;
  String chosenCategory = 'beauty';
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomeBuild(),
    const CategoriesScreen(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar:AppBar(
           centerTitle: true,
              title: Text("Market",
                style: TextStyle(
                  color: Colors.orange[700],
                  fontSize: MediaQuery.of(context).size.height *0.045,
                ),
              )),
          body: pages[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.orange,
            currentIndex: currentIndex,
            onTap:(index){setState(() {
              currentIndex = index;});},
            items: [
          BottomNavigationBarItem(
          icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Categories',
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
      ),
      ]),
      
      ),
    );
  }

}

class HomeBuild extends StatefulWidget {
  const HomeBuild({super.key});

  @override
  State<HomeBuild> createState() => _HomeBuildState();
}

class _HomeBuildState extends State<HomeBuild> {
  getdata() async {
    productList = await ApiProvider().getProduct();
    setState(() {
      loading = false;
    });
  }
  @override
  void initState() {
    setState(() {
      getdata();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return const Center(child: CircularProgressIndicator());
    }else{
      return ListView.builder(
          itemCount: productList!.products!.length,
          itemBuilder: (context, index) {
            return ListTile(
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
          });
    }

  }
}
