import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/category_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/views/oppurtunities/widgets/custom_textfeild.dart';
import 'package:provider/provider.dart';

class AddOpportunityCard extends StatefulWidget {
  AddOpportunityCard({super.key});

  @override
  State<AddOpportunityCard> createState() => _AddOpportunityCardState();
}

class _AddOpportunityCardState extends State<AddOpportunityCard> {
  final TextEditingController _controller = TextEditingController();
  String lastValue = '';

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final currentValue = _controller.text;
      if (currentValue.length > lastValue.length &&
          currentValue.endsWith('\n')) {
        _controller.text = currentValue + '• ';
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      } else if (currentValue.isEmpty) {
        _controller.text = '• ';
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }

      lastValue = _controller.text;
    });

    _controller.text = '• ';
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Select',
      'Internship',
      'Hackathon',
      'Challenge',
      'Others'
    ];
    final provider = Provider.of<DropdownProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      height: 700,
      width: width * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextfeild(
              title: "Opportunity Title",
              hinttext: "Eg: Google Summer of Code ( GSoC )",
              isrequired: true,
              width: 500,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Category Dropdown
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Category",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          " *",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Consumer<DropdownProvider>(
                      builder: (context, dropdownProvider, _) {
                        return SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: dropdownProvider.selectedItem,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Select category",
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 14),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            dropdownColor: Colors.white,
                            items: items.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item,
                                    style: GoogleFonts.poppins(fontSize: 14)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                dropdownProvider.setSelectedItem(value);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                CustomTextfeild(
                    width: 250,
                    title: "Company/Org",
                    hinttext: 'Eg: Microsoft',
                    isrequired: true),
                CustomTextfeild(
                    width: 250,
                    title: "Eligibilty",
                    hinttext: "Eg: Female,2027.... etc",
                    isrequired: true)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomTextfeild(
                    width: 250,
                    title: "Duration",
                    hinttext: "Eg: 3 Months",
                    isrequired: false),
                SizedBox(
                  width: 50,
                ),
                CustomTextfeild(
                    width: 250,
                    title: "Deadline",
                    keyboardtype: TextInputType.datetime,
                    hinttext: "Eg:29-05-25",
                    isrequired: true)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomTextfeild(
                    width: 250,
                    title: "Reward/Stipend",
                    hinttext: "Eg: ₹50,000",
                    isrequired: true),
                SizedBox(
                  width: 50,
                ),
                CustomTextfeild(
                    width: 250,
                    title: "Location (Optional)",
                    hinttext: "Eg: Hydrebad",
                    isrequired: false),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "About the Opportunity",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 100,
              width: 650,
              child: TextField(
                expands: false,
                maxLines: null,
                minLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  contentPadding: EdgeInsets.all(12),
                ),
                scrollPhysics: BouncingScrollPhysics(), // Optional
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Other Information ( Optional )",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 100,
              child: TextField(
                controller: _controller,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                scrollPhysics: BouncingScrollPhysics(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: CheckboxListTile(
                title: Text(
                  "Mark as Top Pick",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                value: provider.isChecked,
                onChanged: provider.toggleCheckbox,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  decoration: BoxDecoration(
                    color: CustomColors().primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Add Opurtunity",style: Theme.of(context).textTheme.bodySmall,),
                ),
                SizedBox(width: 20,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Cancel",style: Theme.of(context).textTheme.labelMedium,),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
