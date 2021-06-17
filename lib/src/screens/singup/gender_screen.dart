import 'package:auto_size_text/auto_size_text.dart';
import '../../theme/theme.dart';
import '../../utils/linear_gradient_mask.dart';
import 'package:flutter/material.dart';

class GendersScreen extends StatefulWidget {
  final GenderType genderType;

  const GendersScreen({Key? key, required this.genderType}) : super(key: key);

  @override
  _GendersScreenState createState() => _GendersScreenState();
}

class _GendersScreenState extends State<GendersScreen> {
  late String selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE5E5E5),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, selectedGender);
          },
          icon: LinearGradientMask(
            child: Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),
        ),
        title: AutoSizeText(
          widget.genderType == GenderType.GENDER
              ? 'I\'m a...'
              : 'I\'m interested in... ',
          maxLines: 1,
          style: TextStyle(
            color: darkBlue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: genders.map((gender) {
                return InkWell(
                  onTap: () => setState(() => selectedGender = gender),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            gender,
                            style: TextStyle(
                              color: selectedGender == gender
                                  ? darkBlue
                                  : Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: selectedGender == gender,
                          child: LinearGradientMask(
                            child: Icon(
                              Icons.check,
                              color: accent,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Visibility(
              visible: selectedGender != null,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        gradient: appGradient, shape: BoxShape.circle),
                    child: Material(
                      color: Colors.transparent,
                      shadowColor: Colors.black54,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, selectedGender);
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> genders = [
  "WOMAN",
  "MAN",
  "OTHER",
  "Demisexual",
  "Homosexual",
  "Lesbian",
  "Bisexual",
  "Monosexual",
  "Asexual",
];

const List<String> interestedGenders = [
  "WOMEN",
  "MEN",
  "OTHER",
  "Demisexual",
  "Homosexual",
  "Lesbian",
  "Bisexual",
  "Monosexual",
  "Asexual",
];

enum GenderType {
  INTERESTED_IN,
  GENDER,
}
