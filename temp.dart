const Align(
alignment: Alignment.topLeft,
child: Padding(
padding: EdgeInsets.all(16.0),
child: Text(
'Until when do you want to rent the car?',
style: TextStyle(
fontFamily: "inter",
fontWeight: FontWeight.w500,
fontSize: 18,
),
),
),
),
Align(
alignment: Alignment.topLeft,
child: Padding(
padding: const EdgeInsets.all(16.0),
child: InputDatePickerFormField(
initialDate: selectedDate ?? DateTime.now(),
firstDate: DateTime(2000),
lastDate: DateTime(2101),
onDateSubmitted: (DateTime value) {
setState(() {
selectedDate = value;
});
},
),
),
)