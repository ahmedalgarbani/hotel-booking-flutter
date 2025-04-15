import 'package:flutter/material.dart';

Widget hotelCard(
    {required String image, required String name, required String date}) {
  return Column(
    children: [
    
      Container(
        width: double.infinity,
        height: 105,
        margin: EdgeInsets.only(
          left: 10,
          top: 5,
          right: 10,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 2,
                spreadRadius: 1,
                color: Colors.grey,
                blurStyle: BlurStyle.solid,
              )
            ]),
        child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: Container(
              
                  margin: EdgeInsets.only(left: 5, top: 2, bottom: 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                ),
            Expanded(child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
                children: [
                  Text(name),
                  Row(children: [ 
                    Icon(Icons.location_on,color: Colors.grey,size: 15,),
                    Text(date,style: TextStyle(color:Colors.grey),),

                  ],),
                  
                ],
              ),
            )),
            Expanded(child:Container(
              margin: EdgeInsets.only(left: 30,top: 5),
              child: Column(
                children: [Text(r"$200"),],
              )
            ) )
            
           
          ],
        ),
      ),
     
    ],
  );
}


Widget titleNearby() {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    alignment: Alignment.bottomLeft,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Near By Hotel",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          "See All",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}
