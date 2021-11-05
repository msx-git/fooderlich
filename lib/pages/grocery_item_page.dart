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

  Color chipLabelColor1 = Colors.white;
  Color chipLabelColor2 = Colors.green;
  Color chipLabelColor3 = Colors.green;

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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        children: [
          buildNameField(),
          buildImportanceField(),
          buildDateField(context),
          buildTimeField(context),
          const SizedBox(height: 8),
          buildColorPicker(context),
          const SizedBox(height: 8),
          buildQuantityField(),
          // TODO: 19: Add Grocery Tile
        ],
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
              side: const BorderSide(color: Colors.green),
              backgroundColor: Colors.white,
              label: Text('low', style: TextStyle(color: chipLabelColor1)),
              selected: _importance == Importance.low,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.low;
                  chipLabelColor1 = Colors.white;
                  chipLabelColor2 = Colors.green;
                  chipLabelColor3 = Colors.green;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.green,
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.green),
              label: Text('medium', style: TextStyle(color: chipLabelColor2)),
              selected: _importance == Importance.medium,
              disabledColor: Colors.purple,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.medium;
                  chipLabelColor1 = Colors.green;
                  chipLabelColor2 = Colors.white;
                  chipLabelColor3 = Colors.green;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.green,
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.green),
              label: Text('high', style: TextStyle(color: chipLabelColor3)),
              selected: _importance == Importance.high,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.high;
                  chipLabelColor1 = Colors.green;
                  chipLabelColor2 = Colors.green;
                  chipLabelColor3 = Colors.white;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Date',
            style: GoogleFonts.lato(fontSize: 28.0),
          ),
          TextButton(
            onPressed: () async {
              final currentDate = DateTime.now();
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: currentDate,
                firstDate: currentDate,
                lastDate: DateTime(currentDate.year + 3),
              );
              setState(() {
                if(selectedDate != null){
                  _dueDate = selectedDate;
                }
              });
            },
            child: const Text('Select'),
          ),
        ],
      ),
      Text(DateFormat('dd-MM-yyyy').format(_dueDate)),
    ]);
  }

  Widget buildTimeField(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Time of Day', style: GoogleFonts.lato(fontSize: 28.0)),
            TextButton(
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  if(timeOfDay!=null){
                    _timeOfDay = timeOfDay;
                  }
                });
              },
              child: const Text('Select'))
          ],
        ),
        Text(_timeOfDay.format(context)),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50.0,
              width: 10.0,
              color: _currentColor,
            ),
            const SizedBox(width: 8.0),
            Text('Color',style: GoogleFonts.lato(fontSize: 28.0))
          ],
        ),
        TextButton(onPressed:
          (){
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (color){
                      setState(()=> _currentColor = color);
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                    )
                  ],
                );
              },
            );
          },
          child: const Text('Select'),
        ),
      ],
    );
  }

  Widget buildQuantityField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(width: 16.0),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18.0),
            ),
          ],
        ),
        Slider(
          inactiveColor: _currentColor.withOpacity(0.5),
          activeColor: _currentColor,
          // 5
          value: _currentSliderValue.toDouble(),
          // 6
          min: 0.0,
          max: 100.0,
          // 7
          divisions: 100,
          // 8
          label: _currentSliderValue.toInt().toString(),
          onChanged: (double value) {
            setState(
                  () {
                _currentSliderValue = value.toInt();
              },
            );
          },
        ),
      ],
    );
  }
















}
