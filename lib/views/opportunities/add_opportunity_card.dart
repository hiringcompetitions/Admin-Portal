import 'package:flutter/material.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/offer_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/opportunities.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/widgets/custom_textfeild.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/widgets/customdropdown.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddOpportunityCard extends StatefulWidget {
  const AddOpportunityCard({super.key});

  @override
  State<AddOpportunityCard> createState() => _AddOpportunityCardState();
}

class _AddOpportunityCardState extends State<AddOpportunityCard> {
  final _formKey = GlobalKey<FormState>();
  String lastValue = '';
  bool isListenerAdded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final offerProvider = Provider.of<OfferProvider>(context);

    if (!isListenerAdded) {
      offerProvider.otherInfoController.addListener(() {
        final currentValue = offerProvider.otherInfoController.text;

        if (currentValue.isEmpty) {
          offerProvider.otherInfoController.text = '• ';
        } else if (currentValue.length > lastValue.length &&
            currentValue.endsWith('\n')) {
          offerProvider.otherInfoController.text = '$currentValue• ';
        }

        offerProvider.otherInfoController.selection =
            TextSelection.fromPosition(
          TextPosition(offset: offerProvider.otherInfoController.text.length),
        );

        lastValue = offerProvider.otherInfoController.text;
      });

      offerProvider.otherInfoController.text = '• ';
      isListenerAdded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      '2025',
      '2026',
      '2027',
      '2028',
      'Female',
    ];
    final provider = Provider.of<OfferProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final selected = provider.selectedCategories;

    final categories = [
      'Select',
      'Internship',
      'Hackathon',
      'Challenge',
      'Others'
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      width: width * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextfield(
                  controller: provider.titleController,
                  title: "Opportunity Title",
                  hinttext: "Eg: Google Summer of Code (GSoC)",
                  isrequired: true,
                  width: 500,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 15),

                /// Category, Company, Eligibility
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Category",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              const Text(" *",
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 70,
                            width: 250,
                            child: DropdownButtonFormField<String>(
                              value: provider.selectedCategory.isNotEmpty
                                  ? provider.selectedCategory
                                  : null,
                              decoration: InputDecoration(
                                hintText: "Select category",
                                filled: true,
                                fillColor: Colors.grey[100],
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 14),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              items: categories
                                  .map((item) => DropdownMenuItem(
                                      value: item, child: Text(item)))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) provider.setCategory(value);
                              },
                              validator: (value) =>
                                  value == null || value == 'Select'
                                      ? 'Select a valid category'
                                      : null,
                            ),
                          )
                        ]),
                    CustomTextfield(
                      controller: provider.companyController,
                      width: 250,
                      title: "Organization",
                      hinttext: "Eg: Microsoft",
                      isrequired: true,
                      validator: (value) =>
                          value == null || value.isEmpty ? "Required" : null,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 9),
                          child: Row(
                            children: [
                              Text(
                                "Eligibility",
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(width: 3),
                              const Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: 70,
                            width: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MultiSelectTextField(
                                  options: options,
                                  hinttext: "Select Eligibility"),
                            )),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 15),

                /// Duration + Deadline
                Row(
                  children: [
                    CustomTextfield(
                      controller: provider.durationController,
                      width: 250,
                      title: "Duration",
                      hinttext: "Eg: 3 Months",
                      isrequired: false,
                    ),
                    const SizedBox(width: 50),
                    CustomTextfield(
                      icon: Icons.calendar_month_outlined,
                      validator: (value) {
                        return value == null || value.isEmpty
                            ? "required"
                            : null;
                      },
                      controller: provider.deadlineController,
                      width: 250,
                      title: "Last Date",
                      hinttext: "Eg: 2025-09-24",
                      isrequired: true,
                      onTap: () => provider.pickDate(context),
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    CustomTextfield(
                      controller: provider.rewardController,
                      width: 250,
                      title: "Payout",
                      hinttext: "Eg: 2000",
                      isrequired: false,
                    ),
                    const SizedBox(width: 50),
                    CustomTextfield(
                      controller: provider.locationController,
                      width: 250,
                      title: "Location",
                      hinttext: "Eg:Hyderabad",
                      isrequired: false,                     
                    )
                  ],
                ),
                const SizedBox(height: 15),

                ///Offer url
                CustomTextfield(
                    validator: (value) {
                      return value == null || value.isEmpty ? "Required" : null;
                    },
                    hinttext: "Enter Offer Link",
                    controller: provider.urlController,
                    width: 650,
                    title: "URL",
                    isrequired: true),

                const SizedBox(
                  height: 15,
                ),

                /// About the Opportunity
                Row(
                  children: [
                    Text("About the Opportunity"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 650,
                  child: TextFormField(
                    controller: provider.aboutController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      contentPadding: EdgeInsets.all(12),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Required" : null,
                  ),
                ),

                const SizedBox(height: 15),

                /// Other Info
                const Text("Other Information (Optional)"),
                const SizedBox(height: 8),
                SizedBox(
                  width: 650,
                  child: TextFormField(
                    controller: provider.otherInfoController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),

                /// Top Pick Checkbox
                CheckboxListTile(
                  title: const Text("Mark as Top Pick"),
                  value: provider.isTopPick,
                  onChanged: (value) => provider.toggleTopPick(value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),

                const SizedBox(height: 15),

                /// Buttons
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await provider.submitOffer();
                          if (provider.isadded) {
                            Navigator.pop(context, true);
                          }
                        } else {
                          CustomError("error")
                              .showToast(context, "Fill required fields");
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          color: CustomColors().primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: provider.isLoading
                            ? const Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "Add Opportunity",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text("Cancel",
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
