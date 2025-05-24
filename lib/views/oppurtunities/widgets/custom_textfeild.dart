import 'package:flutter/material.dart';

class CustomTextfeild extends StatelessWidget {
  final String title;
  final String? hinttext;
  final bool isrequired;
  final double? height;
  final double width;
  final EdgeInsets? padding;
  final TextInputType? keyboardtype;
   CustomTextfeild({
    this.height,
    this.padding,
    this.keyboardtype,
    required this.width,
    required this.title,
    this.hinttext,
    required this.isrequired,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height?? 70,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title,style: Theme.of(context).textTheme.headlineMedium,),
              SizedBox(width: 6,),
              isrequired?Text("*",style: TextStyle(color: Colors.red),):SizedBox(width: 0,),
            ],
          ),
          SizedBox(height: 8,),
          TextField(
            keyboardType: keyboardtype,
            cursorColor: Colors.black,
            decoration: InputDecoration(             
               isDense: true,
               focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
              ),
              contentPadding:padding ?? EdgeInsets.all(12),        
              hintText: hinttext,
              hintStyle: Theme.of(context).textTheme.labelMedium
            ),
          ),
        ],
      ),
    );
  }
}