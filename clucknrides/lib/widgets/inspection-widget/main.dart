import 'package:flutter/material.dart';

class InspectionModelWidget extends StatelessWidget {
  final Function() onUploadPhoto;
  final Function(String) onDescriptionChanged;
  final Function() onStopRent;
  final String imgState;

  const InspectionModelWidget({
    Key? key,
    required this.onUploadPhoto,
    required this.onDescriptionChanged,
    required this.onStopRent,
    required this.imgState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0XFFFAD4D8),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Header
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Howdy, thanks for using Cluck'N'Rides",
                style: TextStyle(
                  fontFamily: "inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
                maxLines: 3,
              ),
            ),
          ),

          // Description
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Please check the vehicle for any damages. If you do spot any, please submit a picture of the damages and give an additional description. ',
                style: TextStyle(
                  fontFamily: "inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                maxLines: 4,
              ),
            ),
          ),

          // Upload photo button
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0XFF0F110C)),
                      foregroundColor: MaterialStateProperty.all(const Color(0XFFFFFCFC)),
                    ),
                    onPressed: onUploadPhoto,
                    child: const Text('Upload photo'),
                  ),
                ),
                Builder(
                  builder: (BuildContext context) {
                    return Text(imgState);
                  },
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 1,
                onChanged: onDescriptionChanged,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Describe the damage shown in the picture',
                ),
              ),
            ),
          ),
          // Buttons and actions
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0XFF0F110C)),
                        foregroundColor: MaterialStateProperty.all(const Color(0XFFFFFCFC)),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 18,
                            fontFamily: "inter",
                            fontWeight: FontWeight.w600,
                            color: Color(0XFFFFFCFC),
                          ),
                        ),
                      ),
                      onPressed: onStopRent,
                      child: const Text(
                        'Stop renting',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "inter",
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
