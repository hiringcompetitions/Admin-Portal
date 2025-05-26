import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/offer_provider.dart';

class MultiSelectTextField extends StatefulWidget {
  final List<String> options;
  final String hinttext;

  const MultiSelectTextField({
    super.key,
    required this.options,
    required this.hinttext,
  });

  @override
  State<MultiSelectTextField> createState() => _MultiSelectTextFieldState();
}

class _MultiSelectTextFieldState extends State<MultiSelectTextField> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _showOverlay() {
    if (_overlayEntry != null) return; // Avoid duplicates
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 250,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Consumer<OfferProvider>(
              builder: (context, provider, _) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 250),
                      child: ListView(
                        shrinkWrap: true,
                        children: widget.options.map((option) {
                          final isSelected =
                              provider.selectedCategories.contains(option);
                          return ListTile(
                            title: Text(option),
                            trailing: isSelected
                                ? const Icon(Icons.check,
                                    color: Color.fromARGB(255, 0, 255, 76))
                                : null,
                            onTap: () {
                              final updated = List<String>.from(
                                  provider.selectedCategories);
                              if (isSelected) {
                                updated.remove(option);
                              } else {
                                updated.add(option);
                              }
                              provider.updateSelectedCategories(updated);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const Divider(height: 1),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _removeOverlay,
                        child: const Text("Done"),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final provider = Provider.of<OfferProvider>(context);
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (_overlayEntry == null) {
            _showOverlay();
          } else {
            _removeOverlay();
          }
        },
        child: AbsorbPointer(
          child: Consumer<OfferProvider>(
            builder: (context, provider, _) {
              final joinedText = provider.selectedCategories.join(', ');

              // Schedule the controller text update after the current build frame
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (provider.eligibilityController.text != joinedText) {
                  provider.eligibilityController.value =
                      TextEditingValue(text: joinedText);
                }
              });

              return TextFormField(
                validator: (value) {
                  return value == null || value.isEmpty ? "required" : null;
                },
                controller: provider.eligibilityController,
                readOnly: true,
                decoration: InputDecoration(
                  isDense: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: widget.hinttext,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
