import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemPage extends StatefulWidget {
  const GroceryItemPage(
      {Key? key,
      required this.onCreate,
      required this.onUpdate,
      this.originalItem})
      : isUpdating = (originalItem != null),
        super(key: key);

  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;

  @override
  _GroceryItemPageState createState() => _GroceryItemPageState();
}

class _GroceryItemPageState extends State<GroceryItemPage> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  bool isChipSelected = true;
  Color chipLabelColor = Colors.green;

  /*void changeColor(){
    if(isChipSelected){
      setState(() {
        chipLabelColor = Colors.white;
      });
    }else{
      setState(() {
        chipLabelColor = Colors.green;
      });
    }
  }*/

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    // 2
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO 12: Add GroceryItemScreen Scaffold
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // TODO 24: Add callback handler
            },
          )
        ],
        elevation: 0.0,
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            // TODO 15: Add date picker
            // TODO 16: Add time picker
            // TODO 17: Add color picker
            // TODO 18: Add slider
            // TODO: 19: Add Grocery Tile
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Item Name', style: GoogleFonts.lato(fontSize: 28.0)),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. Apples, Banana, 1 Bag of salt',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        )
      ],
    );
  }

  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Importance', style: GoogleFonts.lato(fontSize: 28.0)),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              selectedColor: Colors.green,
              side: const BorderSide(color: Colors.white),
              backgroundColor: Colors.white,
              label: Text('low', style: TextStyle(color:chipLabelColor)),
              selected: _importance == Importance.low,
              onSelected: (selected){
                setState(() {
                  _importance = Importance.low;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.green,
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.green),
              label:  Text('medium', style: TextStyle(color: chipLabelColor)),
              selected: _importance == Importance.medium,
              onSelected: (selected){
                setState(() {
                  _importance = Importance.medium;
                  chipLabelColor = Colors.white;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.green,
              side: const BorderSide(color: Colors.green),
              label: const Text('high', style: TextStyle(color: Colors.white)),
              selected: _importance == Importance.high,
              onSelected: (selected){
                setState(() {
                  _importance = Importance.high;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  // TODO: ADD buildDateField()

  // TODO: Add buildTimeField()

  // TODO: Add buildColorPicker()

  // TODO: Add buildQuantityField()
}
