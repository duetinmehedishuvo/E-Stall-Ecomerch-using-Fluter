import 'package:estallecomerch/helpers/authentication_service.dart';
import 'package:estallecomerch/helpers/cart_service.dart';
import 'package:estallecomerch/helpers/provider/products_provider.dart';
import 'package:estallecomerch/helpers/user_utils.dart';
import 'package:estallecomerch/models/choose_products_models.dart';
import 'package:estallecomerch/models/payment_models.dart';
import 'package:estallecomerch/models/payment_product_models.dart';
import 'package:estallecomerch/models/profile.dart';
import 'package:estallecomerch/pages/homeScreen.dart';
import 'package:estallecomerch/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportPages extends StatefulWidget {
  static final route='/reportScreen';
  PaymentModels paymentModels;

  @override
  _ReportPagesState createState() => _ReportPagesState();
}

class _ReportPagesState extends State<ReportPages> {


  String name='';
  String address='';
  String phoneNumber='';
  AuthenticationService authenticationService;
  String email1='';
  Profile profile1;


  PaymentProductModels paymentProductModels;
  List<PaymentProductModels> _paymentProductModel=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationService=AuthenticationService();
    paymentProductModels=PaymentProductModels();
    profile1=Profile();

    AuthenticationService.getUserPhoneNumberByPreference().then((email){
      email1=email;
      setState(() {
        authenticationService.getUserProfileByEmail(email).then((profile){
          setState(() {
            profile1=profile;
          });
        });

        CartService.getAllChooseProducts(email).then((productslist){
          setState(() {
            productslist.forEach((products) {
              paymentProductModels=PaymentProductModels();
              paymentProductModels.name=products.name;
              paymentProductModels.count=products.count;
              paymentProductModels.current_price=products.current_price;
              paymentProductModels.price=products.totalPrice;
              paymentProductModels.keyName=products.nameKey;
              paymentProductModels.authName=products.authorName;
              print(products.name);
              _paymentProductModel.add(paymentProductModels);
            });
          });
        });

      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widget.paymentModels=ModalRoute.of(context).settings.arguments;



  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        UserUtils.saveUserSessionToPreference(false);
        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Report Page'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home,color: Colors.white,),
              onPressed: (){
                UserUtils.saveUserSessionToPreference(false);
                UserUtils.getUserSessionUsingPref().then((value) {
                  print(value.toString());
                  Navigator.of(context).pushReplacementNamed(HomeScreen.route);
                });
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 219,
              color: Colors.blue.withOpacity(.2),
              child: Column(
                children: <Widget>[

                  Center(
                    child: FutureBuilder(
                      future: authenticationService.getUserProfileByEmail(email1),
                      builder: (context,AsyncSnapshot<Profile> snapshot){
                        if(snapshot.hasData){
                          return Column(
                              children: <Widget>[
                                Container(
                                  height: 46,
                                  color: Colors.blue.withOpacity(.2),
                                  padding: EdgeInsets.all(6),
                                  child: Row(children: <Widget>[
                                    Expanded(flex: 1,child: Text('নামঃ',style:TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),),),
                                    Expanded(flex: 3,child: Text(''
                                        '${snapshot.data.name}'),),
                                  ],),
                                ),

                                Container(
                                  height: 46,
                                  color: Colors.blue.withOpacity(.4),
                                  padding: EdgeInsets.all(6),
                                  child: Row(children: <Widget>[
                                    Expanded(flex: 1,child: Text('মোবাইলঃ',style:TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),),),
                                    Expanded(flex: 3,child: Text('${snapshot.data.phoneNumber}'),),
                                  ],),
                                ),

                                Container(
                                  height: 46,
                                  color: Colors.blue.withOpacity(.2),
                                  padding: EdgeInsets.all(6),
                                  child: Row(children: <Widget>[
                                    Expanded(flex: 1,child: FittedBox(
                                      child: Text('পেমেন্ট সিস্টেমঃ',style:TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                    ),),
                                    Expanded(flex: 3,child: Text(
                                      '          ${widget.paymentModels.paymentMethod}'
                                    ),),
                                  ],),
                                ),

                                Container(
                                  height: 46,
                                  color: Colors.blue.withOpacity(.4),
                                  padding: EdgeInsets.all(6),
                                  child: Row(children: <Widget>[
                                    Expanded(flex: 1,child: Text('ঠিকানাঃ',style:TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),),),
                                    Expanded(flex: 3,child: Text('${snapshot.data.address}'),),
                                  ],),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 5),
                                  width: double.infinity,
                                  child: Text('Products List',style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 1.9
                                  ),),
                                ),
                              ],
                            );
                        }
                        if(snapshot.hasError){
                          return Text('Data Face Problems');
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),


                ],
              ),
            ),// edit profile



            Container(
              color:Colors.grey.withOpacity(.5),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FittedBox(child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width/4,
                      child: Text('Name'))),
                  FittedBox(child: Container(child: Text('quantity'))),
                  FittedBox(child: Container(child: Text('price'))),
                  FittedBox(child: Container(child: Text('count'))),
                  FittedBox(child: Container(child: Text('P-price'))),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: FutureBuilder(
                  future: CartService.getAllChooseProducts(email1),
                  builder: (context,AsyncSnapshot<List<ChooseProductModels>> snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return Container(
                              color: Colors.blue.withOpacity(.1),
                              margin: EdgeInsets.only(bottom: 2),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FittedBox(child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width/4,
                                      child: Text(snapshot.data[index].name))),
                                  FittedBox(child: Container(
                                      alignment: Alignment.topCenter,
                                      child: Text(snapshot.data[index].quantity))),
                                  FittedBox(child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data[index].current_price.toString()))),
                                  FittedBox(child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data[index].count.toString()))),
                                  FittedBox(child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data[index].totalPrice.toString()))),
                                ],
                              ),
                            );
                          });
                    }

                    if(snapshot.hasError){
                      print('Error Is: ${snapshot.error}');
                      return Text('Failed to fetch data');
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.blue.withOpacity(.5),
              height: 40,
              child: FlatButton(
                highlightColor: Colors.black.withOpacity(.5),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Consumer<ProductsProvider>(
                        builder: (context,cart,child){
                          return FittedBox(child: Text('count: ${cart.count.toString()}'));
                        },
                      ),
                      Consumer<ProductsProvider>(
                        builder: (context,cart,child){
                          return FittedBox(child: Text('T-Price: ${cart.totalPrice.toString()} ৳',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: .8,
                              color: Colors.black.withOpacity(.8)
                          ),));
                        },
                      ),
                    ],
                  ),
                ),
                onPressed: (){},
              ),
            ),

          ],
        ),
      ),
    );
  }
}