import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String title;
  final String? hinttext;
  final bool isrequired;
  final double? height;
  final double width;
  final EdgeInsets? padding;
  final TextInputType? keyboardtype;
  final TextEditingController controller;
   final String? Function(String?)? validator;
   CustomTextfield({
    required this.controller,
    this.validator,
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
      height:height?? 90,
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
          TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: keyboardtype,
            cursorColor: Colors.black,
            decoration: InputDecoration(             
            errorStyle: TextStyle(height: 0),
               isDense: true,
                border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
              ),
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