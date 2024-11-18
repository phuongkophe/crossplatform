import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickbite/firebase/database.dart';
import 'package:quickbite/pages/details.dart';
import 'package:quickbite/widget/support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  bool milktea = false, sandwich = false, noodles = false, poke_bowl = false;

  Stream? fooditemStream;

ontheload()async{
fooditemStream=await DatabaseMethods().getFoodItem("noodles");
setState((){

  });
}
@override
  void initState() {
    ontheload();
    super.initState();
  }

Widget allItemVertically(){
  return StreamBuilder(stream: fooditemStream, builder: (context, AsyncSnapshot snapshot) {
    return snapshot.hasData? ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: snapshot.data.docs.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index){
DocumentSnapshot ds = snapshot.data.docs[index];
return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(detail: ds["Detail"], name: ds["Name"], price: ds["Price"], image: ds["Image"] ,)));
                      },
                      child: Container(
                margin: const EdgeInsets.only(right: 20.0, bottom: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            ds["Image"],
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  ds["Name"],
                                  style: AppWidget.semiBoldTextFeildStyle(),
                                )),
                            const SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "The richness of the meaty tomato sauce",
                                  style: AppWidget.LightTextFeildStyle(),
                                )),
                            const SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\$"+ds["Price"],
                                  style: AppWidget.semiBoldTextFeildStyle(),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                        ),
                      ),
                    );
    }):CircularProgressIndicator();
  });
}
  
Widget allItem(){
  return StreamBuilder(stream: fooditemStream, builder: (context, AsyncSnapshot snapshot) {
    return snapshot.hasData? ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: snapshot.data.docs.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
DocumentSnapshot ds = snapshot.data.docs[index];
return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(detail: ds["Detail"], name: ds["Name"], price: ds["Price"], image: ds["Image"] ,)));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      ds["Image"],
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(ds["Name"],
                                      style:
                                          AppWidget.semiBoldTextFeildStyle()),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text("Fresh and Healthy",
                                      style: AppWidget.LightTextFeildStyle()),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "\$"+ds["Price"],
                                    style: AppWidget.semiBoldTextFeildStyle(),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    );
    }):CircularProgressIndicator();
  });
}  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello,", style: AppWidget.boldTextFeildStyle()),
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 33, 150, 243),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text("Eat Well Every Day",
                  style: AppWidget.HeadlineTextFeildStyle()),
              Text("Discover and Enjoy Great Food",
                  style: AppWidget.LightTextFeildStyle()),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: showItem()),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 270,
                child: allItem()),
              const SizedBox(
                height: 30.0,
              ),
              
              allItemVertically(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async{
            milktea = true;
            sandwich = false;
            noodles = false;
            poke_bowl = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Milk-Tea");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: milktea
                      ? Color.fromARGB(255, 33, 150, 243)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/milk-tea.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: milktea ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            milktea = false;
            sandwich = true;
            noodles = false;
            poke_bowl = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Sandwich");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: sandwich
                      ? Color.fromARGB(255, 33, 150, 243)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/sandwich.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: sandwich ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            milktea = false;
            sandwich = false;
            noodles = true;
            poke_bowl = false;
            fooditemStream = await DatabaseMethods().getFoodItem("Noodles");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: noodles
                      ? Color.fromARGB(255, 33, 150, 243)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/noodles.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: noodles ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            milktea = false;
            sandwich = false;
            noodles = false;
            poke_bowl = true;
            fooditemStream = await DatabaseMethods().getFoodItem("Poke-Bowl");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: poke_bowl
                      ? Color.fromARGB(255, 33, 150, 243)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/bowl.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: poke_bowl ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
