import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/models/payment_models.dart';
import 'package:estallecomerch/models/payment_product_models.dart';
import 'package:estallecomerch/models/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomSheetExample extends StatefulWidget {

  final PaymentModels paymentModels;
  final Profile profile;
  final List<PaymentProductModels> _paymentProductModel;

  BottomSheetExample(this.paymentModels, this.profile, this._paymentProductModel);

  @override
  _BottomSheetExampleState createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  final paymentKey=GlobalKey<FormState>();

  bool isContainer=true;
  PaymentProductModels paymentProductModels;
  PaymentModels paymentModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentProductModels=PaymentProductModels();
    paymentModels=PaymentModels();

    print(widget.paymentModels.price.toString());
    print(widget.profile.name);
    print(widget.profile.phoneNumber);
    print(widget.profile.address);
    print(widget.profile.email);
  }



  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);


    print('${widget._paymentProductModel[0].authName}');
    print('${widget._paymentProductModel[1].authName}');
    print('${widget._paymentProductModel[2].authName}');
    print('${widget._paymentProductModel[3].authName}');
    print('${widget._paymentProductModel.length.toString()}');

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Text('Select Payment Method:'),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height:50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12)
                        ),
                      ),
                      margin: EdgeInsets.only(right: 2),
                      child: FlatButton(
                        child: Text('Case In',style: TextStyle(
                            color: Colors.white
                        ),),
                        onPressed: (){
                          setState(() {
                            isContainer=false;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height:50,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12)
                        ),
                      ),
                      child: FlatButton(
                        child: Container(
                            child: Text('Bkash',style: TextStyle(
                              color: Colors.white,
                            ),)),
                        onPressed: (){
                          showAlertDialog(context, "step 1: Dial *247#" +
                              "\nstep 2:Select option 1(Send Money)" +
                              "\nstep 3: Enter this Number (+8801777368276)" +
                              "\nstep 4:Enter Amount" +
                              "\nstep 5:Enter Reference like(1234)" +
                              "\nstep6:Enter Your Pin number" +
                              "\nstep 7:Copy Tranistion number and Paste Below Box.", 'বিকাশের মাধ্যমে মূল্য পরিশোধ করার নিয়মঃ');

                          setState(() {
                            isContainer=true;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: isContainer?Form(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter your bkash Transaction id',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    return null;
                  },
                  onSaved: (value){

                  },
                ),
              ):Container(

              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(isContainer?'Selected Bkash Payment Option':'Selected Case In Payment Option',style: TextStyle(
                  color: isContainer?Colors.pink:Colors.green,
                ),)),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.8),
                borderRadius: BorderRadius.circular(10)
              ),
              child: FlatButton(
                child: Text('Finally Order',style: TextStyle(
                  color: Colors.white
                ),),
                onPressed: (){},
              ),
            ),
          ],
        ),
      ),
    );
  }





  ////// Alert Dialog Code
  showAlertDialog(BuildContext context, String message, String heading) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(heading),
      content: Text(message),
      actions: [

      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}