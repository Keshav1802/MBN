import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DateSelectorTextField extends StatefulWidget {
  final TextEditingController controller;
  final DateTime minDate;
  final DateTime maxDate;
  final DateTime initialDate;
  final String dateFormat;
  final DateTimePickerLocale locale;
  final String title;
  final String validatorMessage;
  //define function to return date
  final Function(String) onDateSelected;

  const DateSelectorTextField({
    Key key,
    this.controller,
    this.minDate,
    this.maxDate,
    this.initialDate,
    this.dateFormat = 'dd-MM-yyyy',
    @required this.locale,
    @required this.title,
    @required this.validatorMessage,
    @required this.onDateSelected,
  }) : super(key: key);

  @override
  State<DateSelectorTextField> createState() => _DateSelectorTextFieldState();
}

class _DateSelectorTextFieldState extends State<DateSelectorTextField> {
  //variables
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: HexColor('#8e9aa6'),
            fontSize: 10.sp,
            fontFamily: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
            ).fontFamily,
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          cursorWidth: 1.sp,
          cursorHeight: 18.sp,
          textCapitalization: TextCapitalization.sentences,
          showCursor: true,
          enabled: true,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey,
            fontFamily: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
            ).fontFamily,
          ),
          readOnly: true,
          onTap: () {
            DatePicker.showDatePicker(
              context,
              pickerTheme: DateTimePickerTheme(
                itemTextStyle: TextStyle(fontWeight: FontWeight.w600),
                confirm:
                    Text('Done', style: TextStyle(color: HexColor('#006400'))),
                cancel: Text('Cancel', style: TextStyle(color: Colors.red)),
                itemHeight: 40,
              ),
              pickerMode: DateTimePickerMode.date,
              minDateTime: widget.minDate,
              initialDateTime: widget.initialDate,
              maxDateTime: widget.maxDate,
              dateFormat: widget.dateFormat,
              locale: widget.locale,
              onClose: () => print('----- onClose -----'),
              onCancel: () => print('onCancel'),
              onChange: (dateTime, List<int> index) {
                setState(() {
                  _date = dateTime;
                  widget.controller.text =
                      DateFormat(widget.dateFormat).format(dateTime);
                });
              },
              onConfirm: (dateTime, List<int> index) {
                setState(() {
                  setState(() {
                    _date = dateTime;
                    widget.controller.text =
                        DateFormat(widget.dateFormat).format(dateTime);
                    // print(_date);
                  });
                });
              },
            );
          },
          decoration: InputDecoration(
            prefixIcon: Image.asset(
              'assets/calendar-2852107 (1).png',
              width: 3,
              height: 3,
              fit: BoxFit.scaleDown,
              color: Colors.white,
            ),
            errorStyle: TextStyle(
              fontSize: 8.sp,
              color: HexColor('#de5151'),
              fontFamily: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
              ).fontFamily,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: HexColor('#d5dce0'),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: HexColor('#5374ff'),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: HexColor('#de5151'),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: HexColor('#de5151'),
              ),
            ),
          ),
          inputFormatters: [
            //formatter for date
            FilteringTextInputFormatter.singleLineFormatter,
            //formatter for date in dd/mm/yyyy format
            FilteringTextInputFormatter.deny(RegExp(r'[^0-9/]')),
          ],
          validator: (value) {
            if (value.isEmpty) {
              return widget.validatorMessage;
            }
            return null;
          },
        ),
      ],
    );
  }

  //define function onDateSelected
  String onDateSelected() {
    return widget.controller.text;
  }
}
