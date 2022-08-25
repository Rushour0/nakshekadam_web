import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/screens/main/tabs/incoming_requests/incoming_requests_page.dart';
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    Key? key,
    required this.incomingRequestInfo,
  }) : super(key: key);

  final IncomingRequestInfo incomingRequestInfo;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    print(incomingRequestInfo.photoURL);
    return Container(
      width: screenWidth * 0.175,
      height: screenHeight * 0.425,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenWidth * 0.005,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(
          screenHeight / 50,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
            offset: Offset(0, 10),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: screenHeight * 0.125,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                profilePicture(screenHeight),
                nameText(screenHeight),
                clientType(screenHeight),
              ],
            ),
          ),
          firstDataSpacesRow(screenWidth, screenHeight),
          secondDataSpacesRow(screenWidth, screenHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(screenWidth * 0.07),
                  primary: Colors.green,
                ),
                onPressed: () {
                  setRequestStatus(
                    userId: incomingRequestInfo.uid,
                  );
                },
                child: Text(
                  'Accept',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'DM Sans',
                    fontSize: screenWidth * 0.0075,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  fixedSize: Size.fromWidth(screenWidth * 0.07),
                ),
                onPressed: () {
                  setRequestStatus(
                    accept: false,
                    userId: incomingRequestInfo.uid,
                  );
                },
                child: Text(
                  'Reject',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'DM Sans',
                    fontSize: screenWidth * 0.0075,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  SizedBox firstDataSpacesRow(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.15,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            dataSpaces(
              title: 'Type',
              subtitle: incomingRequestInfo.type.toString(),
              screenHeight: screenHeight,
            ),
            VerticalDivider(color: Colors.grey),
            // dataSpaces(
            //   title: 'Age',
            //   subtitle: incomingRequestInfo.age.toString(),
            //   screenHeight: screenHeight,
            // ),
            // VerticalDivider(color: Colors.grey),
            dataSpaces(
              title: 'Class',
              subtitle: incomingRequestInfo.standard.toString(),
              screenHeight: screenHeight,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox secondDataSpacesRow(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.15,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            dataSpaces(
              title: 'Test Status',
              subtitle: incomingRequestInfo.testStatus ? 'Yes' : 'No',
              screenHeight: screenHeight,
            ),
            VerticalDivider(color: Colors.grey),
            dataSpaces(
              title: 'Spoken to Vidya',
              subtitle: incomingRequestInfo.vidyaBotStatus ? 'Yes' : 'No',
              screenHeight: screenHeight,
            ),
          ],
        ),
      ),
    );
  }

  FittedBox dataSpaces({
    required String title,
    required String subtitle,
    required double screenHeight,
  }) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontFamily: 'DM Sans',
              fontSize: screenHeight * 0.02,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'DM Sans',
              fontSize: screenHeight * 0.0175,
            ),
          ),
        ],
      ),
    );
  }

  Text clientType(double screenHeight) {
    return Text(
      incomingRequestInfo.clientType,
      style: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: screenHeight * 0.0175,
        // fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  }

  Text nameText(double screenHeight) {
    return Text(
      incomingRequestInfo.name,
      style: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: screenHeight * 0.0225,
        fontWeight: FontWeight.bold,
        color: COLOR_THEME['secondary'],
      ),
    );
  }

  Container profilePicture(double screenHeight) {
    return Container(
      width: screenHeight / 20,
      height: screenHeight / 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            incomingRequestInfo.photoURL,
          ),
          fit: BoxFit.contain,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
    );
  }
}

class SearchDropDownFilter extends StatelessWidget {
  const SearchDropDownFilter({
    Key? key,
    required this.items,
    required this.onChanged,
  }) : super(key: key);
  final List items;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        color: COLOR_THEME['searchFieldBackground'],
        borderRadius: BorderRadius.circular(screenHeight / 75),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          borderRadius: BorderRadius.circular(screenHeight / 100),
          items: (items)
              .map((item) => DropdownMenuItem(
                    child: Container(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                        ),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class SearchFormField extends StatelessWidget {
  const SearchFormField({
    Key? key,
    required this.searchController,
    required this.hintText,
    required this.redirectFunction,
  }) : super(key: key);
  final TextEditingController searchController;
  final String hintText;
  final Function redirectFunction;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      // width: screenWidth * 0.75,
      decoration: BoxDecoration(
        color: COLOR_THEME['searchFieldBackground'],
        borderRadius: BorderRadius.circular(screenHeight / 75),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Colors.black,
          fontSize: screenHeight / 50,
          fontFamily: 'DM Sans',
        ),
        controller: searchController,
        onChanged: (value) {
          // setState(() {});
        },
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: screenHeight / 50,
            fontFamily: 'DM Sans',
          ),
          fillColor: COLOR_THEME['searchFieldBackground'],
          hintText: hintText,
          suffixIcon: IconButton(
            // padding: EdgeInsets.only(left: screenWidth * 0.07),
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: Colors.black,
              size: screenHeight / 50,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenHeight / 75),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenHeight / 75),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenHeight / 75),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenHeight / 75),
          ),
        ),
      ),
    );
  }
}
