// ignore_for_file: prefer_final_fields, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/models/opportunity_model.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/widgets/custom_dropdown.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/widgets/custom_multi_selector.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/widgets/custom_text_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

class OpportunityCard extends StatefulWidget {
  String? title;
  String? selectedCategory;
  String? organizationName;
  List<String> eligibility;
  String? duration;
  DateTime? lastDate;
  String? payout;
  String? location;
  DateTime? eventDate;
  String? about;
  String? otherInfo;
  String? buttonText;
  String? url;
  bool isImportant;
  String uid;

  OpportunityCard({
    required this.title,
    required this.selectedCategory,
    required this.organizationName,
    required this.eligibility,
    required this.duration,
    required this.lastDate,
    required this.payout,
    required this.location,
    required this.eventDate,
    required this.about,
    required this.otherInfo,
    required this.buttonText,
    required this.url,
    required this.isImportant,
    required this.uid,
    super.key
  });

  @override
  State<OpportunityCard> createState() => _OpportunityCardState();
}

class _OpportunityCardState extends State<OpportunityCard> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _organizationController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _payoutController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  TextEditingController _otherInfoController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  String _lastValue = '';

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title ?? "";
    _organizationController.text = widget.organizationName ?? "";
    _durationController.text = widget.duration ?? "";
    _payoutController.text = widget.payout ?? "";
    _locationController.text = widget.location ?? "";
    _aboutController.text = widget.about ?? "";
    _otherInfoController.text = widget.otherInfo ?? "• ";
    _urlController.text = widget.url ?? "";
  }

  List<DropdownMenuItem<String>> items = [
    DropdownMenuItem(value: "Internship", child: Text("Internship")),
    DropdownMenuItem(value: "Hackathon", child: Text("Hackathon")), 
    DropdownMenuItem(value: "Competition", child: Text("Competition")),
    DropdownMenuItem(value: "Challenge", child: Text("Challenge")),
    DropdownMenuItem(value: "Job", child: Text("Job")),
    DropdownMenuItem(value: "Others", child: Text("Others")),
  ];

  final _items = [
    "2025", "2026", "2027", "2028", "Female",
  ].map((e) => MultiSelectItem<String>(e, e)).toList();

  // Show date for last date
  Future<void> pickDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context, 
      initialDate: widget.lastDate ?? DateTime.now(),
      firstDate: DateTime.now(),  
      lastDate: DateTime(2050)
    );

    if(date != null) {
      setState(() {
        widget.lastDate = date;
      });
    }
  }

  // show date for event date
  Future<void> pickEventDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context, 
      initialDate: widget.eventDate ?? DateTime.now(),
      firstDate: DateTime.now(),  
      lastDate: DateTime(2050)
    );

    if(date != null) {
      setState(() {
        widget.eventDate = date;
      });
    }
  }

  // customize other info
  void _onChanged() {
    final currentValue = _otherInfoController.text;

    // Check if Enter was pressed (i.e., a new line was added)
    if (currentValue.length > _lastValue.length &&
        currentValue.endsWith('\n')) {
      final newText = "$currentValue• ";
      _otherInfoController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    _lastValue = _otherInfoController.text;
  }

  // Add Opportunity
  Future<String?> addOpportunity() async {
    final provider = Provider.of<FirestoreProvider>(context, listen: false);

    if(widget.lastDate == null || _titleController.text == "" || widget.selectedCategory == null || _organizationController.text == "" || widget.eligibility.isEmpty || _urlController.text == "")  {
      CustomError("error").showToast(context, "Please fill out the required fields");
      return "";
    }

    final opportunity = OpportunityModel(
      title: _titleController.text, 
      category: widget.selectedCategory ?? 'Others', 
      organization: _organizationController.text, 
      eligibility: widget.eligibility.join(', '), 
      duration: _durationController.text, 
      lastdate: widget.lastDate ?? DateTime.now(),
      payout: _payoutController.text, 
      location: _locationController.text,
      eventDate: widget.eventDate,
      about: _aboutController.text, 
      otherInfo: _otherInfoController.text, 
      isTopPick: widget.isImportant, 
      url: _urlController.text,
      timestamp: DateTime.timestamp(),
      uid: "",
    );

    try {
      final res = await provider.addOppurtunity(opportunity);
      if(res == null) {
        CustomError("success").showToast(context, "Oppurtunity Added");
      } else {
        print(res);
        CustomError("error").showToast(context, res);
      }
    } catch(e) {
      CustomError("error").showToast(context, "Unknown error occured. Please try again later.");
    }
  }

  Future<String?> updateOpportunity() async {
    final provider = Provider.of<FirestoreProvider>(context, listen: false);

    if(widget.lastDate == null || _titleController.text == "" || widget.selectedCategory == null || _organizationController.text == "" || widget.eligibility.isEmpty || _urlController.text == "")  {
      CustomError("error").showToast(context, "Please fill out the required fields");
      return "";
    }

    final opportunity = OpportunityModel(
      title: _titleController.text, 
      category: widget.selectedCategory ?? 'Others', 
      organization: _organizationController.text, 
      eligibility: widget.eligibility.join(', '), 
      duration: _durationController.text, 
      lastdate: widget.lastDate ?? DateTime.now(),
      payout: _payoutController.text, 
      location: _locationController.text,
      eventDate: widget.eventDate,
      about: _aboutController.text, 
      otherInfo: _otherInfoController.text, 
      isTopPick: widget.isImportant, 
      url: _urlController.text,
      timestamp: DateTime.timestamp(),
      uid: widget.uid,
    );

    try {
      final res = await provider.updateOpportunity(opportunity);
      if(res == null) {
        CustomError("success").showToast(context, "Oppurtunity Updated");
      } else {
        print(res);
        CustomError("error").showToast(context, res);
      }
    } catch(e) {
      CustomError("error").showToast(context, "Unknown error occured. Please try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<FirestoreProvider>(context);

    return  Container(
        width: MediaQuery.of(context).size.width * 0.7,
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              // Title 
          
              Text("Oppurtunity Title *", style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.grey.shade900,
                fontWeight: FontWeight.w600
              ),),
              SizedBox(height: 10,),
              CustomTextBar(hintText: "Eg. Google Summer of Code (GSOC)", controller: _titleController, width: 1080,),
              SizedBox(height: 20,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          
                  // CATEGORY
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Category *", style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 10,),
                      CustomDropdown(items: items, selectedValue: widget.selectedCategory, onChanged: (value) {
                        setState(() {
                          widget.selectedCategory = value;
                        });
                      },),
                    ],
                  ),
          
                  // ORGANIZATION
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Organization *", style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 10,),
                      CustomTextBar(hintText: "Eg. Google", controller: _organizationController, width: 320,),
                    ],
                  ),
          
                  // ELIGIBILITY
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Eligibility *", style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 10,),
                      CustomMultiSelector(items: _items, selectedtems: widget.eligibility, onConfirm: (values) {
                        setState(() {
                          widget.eligibility = List<String>.from(values);
                        });
                      },)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          
                  // DURATION
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Duration", style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 10,),
                      CustomTextBar(hintText: "Eg. 3Months", controller: _durationController, width: 320,),
                    ],
                  ),
          
                  // LAST DATE
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Last Date *", style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          pickDate(context);
                        },
                        child: Container(
                          height: 50,
                          width: 320,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade600,
                            ),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.lastDate != null
                                    ? widget.lastDate!.toLocal().toString().split(' ')[0]
                                    : "Select Date",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Icon(Icons.date_range_outlined),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          
                  // PAYOUT
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Payout", style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 10,),
                      CustomTextBar(hintText: "Eg. No Stipend, 30k", controller: _payoutController, width: 320,),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          
                  // LOCATION
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Location", style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 10,),
                      CustomTextBar(hintText: "Eg. Hyderabad, Remote, Onsite", controller: _locationController, width: 320,),
                    ],
                  ),
          
                  // DATE OF THE EVENT
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date of Event", style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          pickEventDate(context);
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            height: 50,
                            width: 320,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade600,
                              ),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.eventDate != null
                                      ? widget.eventDate!.toLocal().toString().split(' ')[0]
                                      : "Select Date of Event",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                widget.eventDate == null ? Icon(Icons.date_range_outlined)
                                                  : MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.eventDate = null;
                                                        });
                                                      },
                                                      child: Icon(Icons.highlight_remove)),
                                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(width: 320,)
                ],
              ),
              SizedBox(height: 20,),

              // URL of the Opportunity
              Text("URL *", style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.grey.shade900,
                fontWeight: FontWeight.w600
              ),),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _urlController,
                      minLines: 1,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "URL",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade900,
                            width: 1,
                          )
                        )
                      ),
                    ),
                  ),
                ],  
              ),
              SizedBox(height: 20,),
          
              // ABOUT THE OPPORTUNITY
          
              Text("About", style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.grey.shade900,
                fontWeight: FontWeight.w600
              ),),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _aboutController,
                      minLines: 5,
                      maxLines: 50,
                      decoration: InputDecoration(
                        hintText: "About the Oppurtunity",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade900,
                            width: 1,
                          )
                        )
                      ),
                    ),
                  ),
                ],  
              ),
              SizedBox(height: 20,),
          
          
              // OTHER INFO
              Text("Other Info", style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.grey.shade900,
                fontWeight: FontWeight.w600
              ),),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _otherInfoController,
                      onChanged: (_) => _onChanged(),
                      minLines: 5,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Anything related to the Opportunity",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade900,
                            width: 1,
                          )
                        )
                      ),
                    ),
                  ),
                ],  
              ),
              SizedBox(height: 20,),

              // IS IMPORTANT
              Row(
                children: [
                  Checkbox(
                    value: widget.isImportant, 
                    onChanged: (value) {
                      setState(() {
                        widget.isImportant = value ?? false;
                      });
                    },
                    activeColor: CustomColors().primary,
                    semanticLabel: "Mark this opportunity as important",
                  ),

                  Text("Mark this opportunity as Important", style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w500
                  ),)
                ],
              ),
              SizedBox(height: 20,),
              
              // ADD OR CANCEL
              Row(
                spacing: 10,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                        if(widget.uid != "") {
                          final res = await updateOpportunity();
                          if(res == null) {
                            Navigator.of(context).pop();
                          }
                        } else {
                          final res = await addOpportunity();
                          if(res == null) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Container(
                        height: 50, 
                        width: 240,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: CustomColors().primary,
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: !provider.isLoading!
                        ? Text(widget.buttonText ?? 'Add', style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),)
                        : SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                    ),
                  ),

                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 160,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Text("Cancel", style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: CustomColors().primaryText,
                          fontWeight: FontWeight.w500
                        ),),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
}