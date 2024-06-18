import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 161,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
                child: Row(children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 13, top: 13, bottom: 14),
                    child: Text(
                      'Category',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff191C24),
                      size: 17,
                    ),
                  )
                ]),
              ),
              const SizedBox(
                width: 6,
              ),
              //below is for Sort
              Container(
                width: 88,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.63, top: 13.67, bottom: 14.67),
                      child: Icon(
                        Icons.import_export,
                        color: Color(0xff191C24),
                        size: 17,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 13, top: 14, bottom: 13),
                      child: Text(
                        'Sort',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              //below is for Filter
              Container(
                width: 105,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 22.37, top: 15.33, bottom: 16.33),
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: Color(0xff191C24),
                        size: 17,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 18, top: 14, bottom: 13),
                      child: Text(
                        'Filter',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
