import 'package:doctor_reservation/Custom/colors.dart';
import 'package:doctor_reservation/Custom/custom_text_field.dart';
import 'package:doctor_reservation/Custom/show_snackbar.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/doctor_reviews_page.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/pateint_main_page.dart';
import 'package:doctor_reservation/FEATURES/RESERVATION%20repo&controller/reservation_controller.dart';
import 'package:doctor_reservation/FEATURES/REVIEWS/reviews_controller.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class DOCTOR_DETAILS_PAGE_for_patient extends ConsumerStatefulWidget {
  final DOCTOR_MODEL doctor_model;
  const DOCTOR_DETAILS_PAGE_for_patient(
      {super.key, required this.doctor_model});

  @override
  ConsumerState<DOCTOR_DETAILS_PAGE_for_patient> createState() =>
      _DOCTOR_DETAILS_PAGE_for_patientState();
}

class _DOCTOR_DETAILS_PAGE_for_patientState
    extends ConsumerState<DOCTOR_DETAILS_PAGE_for_patient> {
  TextEditingController review_title_controller = TextEditingController();
  TextEditingController review_text_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();

  DateTime? date;

  Future<DateTime?> choose_date_from_calender() async {
    date = await showDatePicker(
        context: context,
        barrierDismissible: true,
        currentDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2100));
    if (date != null) {
      setState(() {
        date_controller.text = date.toString().split(' ')[0];
      });
      return date;
    } else {
      return null;
    }
  }

  double rating = 0;
  @override
  void dispose() {
    review_title_controller.dispose();
    review_text_controller.dispose();
    date_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
        title: Text(
          'Doctor\'s Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: size.height * 0.85,
        width: size.width * 0.95,
        margin: EdgeInsets.only(left: 14, top: 18),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.circular(10)),
        child: ListView(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        NetworkImage(widget.doctor_model.PROFILE_PIC),
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: Column(
                    children: [
                      Icon(
                        Icons.star,
                        size: 38,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(255, 85, 0, 255)),
                          child: Text(
                            (widget.doctor_model.average_rating == 0.0)
                                ? 'No Ratings \t Yet'
                                : widget.doctor_model.average_rating.toString(),
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 10),
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      (widget.doctor_model.average_rating == 0.0)
                          ? Container()
                          : Text(
                              'Rating',
                              style: TextStyle(color: Colors.yellow),
                            ),
                    ],
                  ),
                )
              ],
            ),
            Center(
              child: Text(
                widget.doctor_model.NAME,
                style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                widget.doctor_model.JOB_TITLE,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
              ),
            ),
            Text(
              widget.doctor_model.OTHER_DETAILS,
              style: const TextStyle(color: Colors.blue, fontSize: 12),
            ),
            Text(
              widget.doctor_model.CLINIC_ADDRESS,
              style: const TextStyle(color: Colors.yellow, fontSize: 12),
            ),
            Text(
              widget.doctor_model.WORKING_HOURS,
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
            ),
            Text(
              widget.doctor_model.PHONE_NUMBER,
              style: const TextStyle(color: Colors.blue, fontSize: 11),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.06,
              child: TextFormField(
                style: TextStyle(fontSize: 15),
                controller: date_controller,
                onTap: () async {
                  await choose_date_from_calender();
                },
                readOnly: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    suffixIcon: Icon(Icons.arrow_downward_rounded),
                    hintText: 'Choose Reservation Date',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(
                          255,
                          12,
                          0,
                          124,
                        ),
                        fontSize: 12),
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 244, 84),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Add Review...',
                  style: TextStyle(color: Color.fromARGB(255, 255, 237, 75)),
                ),
                SizedBox(width: size.width * 0.1),
                RatingBar.builder(
                  itemSize: 27,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  initialRating: 0,
                  minRating: 1,
                  glowColor: Colors.yellow,
                  unratedColor: Colors.white,
                  itemPadding: EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (context, index) => Icon(
                    Icons.star_border_outlined,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (value) {
                    setState(() {
                      rating = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: size.height * 0.07,
                    child: custom_text_field(
                        EditingController: review_title_controller,
                        Label: 'Review Title ...',
                        maxlines: 1,
                        textInputType: TextInputType.text,
                        obscure_text: false,
                        onchanged: null),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      if (review_text_controller.text.isNotEmpty &&
                          review_title_controller.text.isNotEmpty) {
                        await ref.watch(reviews_controller_provider).ADD_REVIEW(
                            REVIEW_TEXT: review_text_controller.text,
                            DOCTOR_ID: widget.doctor_model.ID,
                            review_title: review_title_controller.text,
                            rating: rating,
                            context: context);
                      } else {
                        ShowSnackbar(
                            ERROR: 'Please Complete All Review Fields',
                            context: context);
                      }

                      setState(() {
                        review_text_controller.clear();
                        review_title_controller.clear();
                      });
                    },
                    icon: Icon(
                      Icons.save,
                      color: Colors.yellow,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.2,
              child: custom_text_field(
                  EditingController: review_text_controller,
                  Label: 'Review Details...',
                  maxlines: 3,
                  textInputType: TextInputType.text,
                  obscure_text: false,
                  onchanged: null),
            ),
            TextButton(
                onPressed: () {
                  Get.to(() => doctor_reviews_page(
                        DOCTOR: widget.doctor_model,
                      ));
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    foregroundColor: Colors.yellow,
                    backgroundColor: Colors.blue),
                child: Text('See Doctor Reviews'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DateTime? reservation_time = date;

          if (reservation_time != null) {
            await ref.watch(reservation_controller_provider).book_reservation(
                time: date!,
                doctor_photourl: widget.doctor_model.PROFILE_PIC,
                doctor_phone_number: widget.doctor_model.PHONE_NUMBER,
                doctor_id: widget.doctor_model.ID,
                doctor_name: widget.doctor_model.NAME,
                context: context);

            Get.to(() => PATIENT_main_page());
          } else {
            ShowSnackbar(
                ERROR: 'Please Choose Reservation Time', context: context);
          }
        },
        backgroundColor: blue,
        foregroundColor: yellow,
        child: const Center(
            child: Column(
          children: [
            SizedBox(
              height: 6,
            ),
            Icon(Icons.thumb_up_alt_sharp),
            Text('Book'),
          ],
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
