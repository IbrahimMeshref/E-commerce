
import 'dart:math'as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dblocalcart/hivo.dart';
import '../home/LocalDB.dart';
import '../home/itemscreen.dart';
class Carts extends StatefulWidget {
  const Carts({Key? key}) : super(key: key);

  @override
  State<Carts> createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  int weight=1;double tot=0.0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 247, 1),
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: Text("My Cart",style:TextStyle(fontSize: 19,color: Color.fromRGBO(43, 43, 43, 1)),),
        leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child:InkWell(
              onTap: () {
                Navigator.pop(context);
                setState(() {});
              },
              child: CircleAvatar(child: Icon( Icons.arrow_back_ios_outlined,color: Colors.grey,),backgroundColor: Color.fromRGBO(255, 255, 255, 1),),

            )
        ),
      ),
      body:StoragedataCart.cart.isNotEmpty ?
      ListView.separated(itemBuilder: (context,index)=>Dismissible(
        onDismissed: (val){
          StoragedataCart.deletcart(index);
          setState(() {

          });
        },
        background: Container(
          height: height*0.12,
        ),
        secondaryBackground:Container(
          padding: EdgeInsets.only(left: width*0.83),
          child: Icon(CupertinoIcons.delete,size: 35,color: Colors.white,),
            decoration: BoxDecoration(
                color: Color(0XFFFF1900),borderRadius:BorderRadius.circular(15)
            ),
        ),
        key: UniqueKey(),
        child: Container(
          margin: EdgeInsets.only(top: height*0.02),
          child: Row(
            children: [
              SizedBox(width: width*0.03,),
              Container(
                width: width*0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Color(0xff0D6EFD),),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: height*0.001,),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          weight=int.parse(StoragedataCart.cart[index]["number"]);
                          weight++;
                          StoragedataCart.cart[index]["number"]=weight.toString();
                          StoragedataCart.updatecart();
                        });
                      }, icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 23,
                    ),
                    ),
                    SizedBox(height: height*0.01,),
                    Text(
                      StoragedataCart.cart[index]["number"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),

                    ),
                    SizedBox(height: height*0.001,),
                    IconButton(
                      icon: Icon(
                        Icons.minimize,
                        color: Colors.white,
                        size: 23,
                      ),
                      onPressed: () {
                        setState(() {
                          weight=int.parse(StoragedataCart.cart[index]["number"]);
                          if (weight > 1) {
                            weight--;
                            StoragedataCart.cart[index]["number"]=weight.toString();
                            StoragedataCart.updatecart();
                          }
                        });
                      },

                    ),

                  ],
                ),

              ),
              SizedBox(width: width*0.02,),
              Container(
                width: width*0.73,
                height: height*0.16,
               // margin: EdgeInsets.all(t),
                padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.02),
                decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(15) ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height:height*0.12 ,width: width*0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xfb0abab),
                        ),
                        child: /* RotationTransition(
                          turns: AlwaysStoppedAnimation(15/170),
                            child:*/ Center(child: Image.asset(StoragedataCart.cart[index]["image"],fit: BoxFit.contain,height: height*0.9,width: width*0.9,))
                       // )
                    ),
                    SizedBox(width: width*0.05,),
                    Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(StoragedataCart.cart[index]["name"],style: TextStyle(fontSize: 16,color:Color.fromRGBO(43, 43, 43, 1))
                            ),
                            SizedBox(height: height*0.01),
                            Text('\$ ${double.parse(StoragedataCart.cart[index]["price"])*double.parse(StoragedataCart.cart[index]["number"])}',style: TextStyle(fontSize: 20,color:Colors.black,
                            fontWeight: FontWeight.bold,

                            )),

                          ],
                        ),
                      width: width*0.3,
                      padding: EdgeInsets.only(top: height*0.03),

                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),  itemCount: StoragedataCart.cart.length,
        separatorBuilder :(BuildContext context, int index) => SizedBox(height: height*0.010,),scrollDirection: Axis.vertical,
      ):Text(''),
      bottomNavigationBar:Container(
        height: height*0.31,
        color: Colors.white,
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.04),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Subtotal',
                    style: TextStyle(
                      color: Color(0xff707B81),
                      fontSize: 17
                    ),
                  ),
                  Spacer(),
                  Text('\$711',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ],
              ),
              SizedBox(height: height*0.02,),
              Row(
                children: [
                  Text('Delivery',
                    style: TextStyle(
                        color: Color(0xff707B81),
                        fontSize: 17
                    ),
                  ),
                  Spacer(),
                  Text('\$60',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.03,),
              Image.asset('assets/images/icons/Vector 1785.png'),
              SizedBox(height: height*0.02,),
              Row(
                children: [
                  Text('Total Cost',
                    style: TextStyle(
                        color: Color(0xff2B2B2B),
                        fontSize: 17
                    ),
                  ),
                  Spacer(),
                  Text('\$60',
                    style: TextStyle(
                      color: Color(0xff0D6EFD),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.03,),
              ElevatedButton(onPressed: () {},
                  child: Text('Checkout',style: TextStyle(
                    fontWeight: FontWeight.normal
                  ),),style:ElevatedButton.styleFrom(
                  minimumSize: Size(width*0.9, height*0.06),
                  backgroundColor: Color(0xff0D6EFD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0), // Adjust the border radius here
                  ),
                ) ,

              )
            ],
          ),
        ),
      ) ,

    );
  }
}
