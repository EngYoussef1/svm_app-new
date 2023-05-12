
import 'package:flutter/material.dart';

enum paymentWay { Credit, DebitCard,Paypal }

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  paymentWay? _character = paymentWay.Credit;
  var formKey = GlobalKey<FormState>();
  var CardName = TextEditingController();
  var CardNamber = TextEditingController();
  var EpiringOn = TextEditingController();
  var ccv = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          },
            icon:Icon(Icons.arrow_back),),
          iconTheme: IconThemeData(
            size: 40,
            color: Colors.white,
          ),
          primary: true,
          backgroundColor:Colors.red[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          title: Text('Payment',style:  TextStyle(fontSize: 40),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 160,
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context,index){
                        return ListTile(
                          title:  Text("Chipsy",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          subtitle: Text("chease",style: TextStyle(fontSize: 20),),
                          trailing: Text("\$16*2",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        );
                      }
                  ),
                ),
                // SizedBox(height: 10,),
                //divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(thickness: 1,color: Colors.black,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total:",style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold)),
                      Text("\$40",style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold))
                    ],
                  ),
                ),
                SizedBox(height: 15,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(35)
                  ),
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Credit",style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold)),
                          // SizedBox(width: 230,),
                          Radio(
                              value: paymentWay.Credit,
                              groupValue: _character,
                              onChanged: (paymentWay? value){
                                setState(() {
                                  _character=value ;
                                  print("$value");
                                });
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Debit Card",style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold)),
                          // SizedBox(width: 230,),
                          Radio(
                              value: paymentWay.DebitCard,
                              groupValue: _character,
                              onChanged: (paymentWay? value){
                                setState(() {
                                  _character=value ;
                                  print("$value");
                                });
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Paypal",style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold)),
                          // SizedBox(width: 230,),
                          Radio(
                              value: paymentWay.Paypal,
                              groupValue: _character,
                              onChanged: (paymentWay? value){
                                setState(() {
                                  _character=value ;
                                  print("$value");
                                });
                              })
                        ],
                      ),
                    ],
                  ) ,
                ),
                SizedBox(height: 10,),

                Form(
                  key: formKey,
                  child:Column(

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: CardName,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Card Name',
                          ),
                          validator: ( value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Card Name must not be empty';
                            }

                            return null;
                          },
                          onFieldSubmitted: (value){
                            print(value);
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: CardNamber,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Card Namber',
                          ),
                          validator: ( value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Card Namber  must not be empty';
                            }

                            return null;
                          },
                          onFieldSubmitted: (value){
                            print(value);
                          },

                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: EpiringOn,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Epiring on',
                              ),
                              validator: ( value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Epiring date must not be empty';
                                }

                                return null;
                              },
                              onFieldSubmitted: (value){
                                print(value);
                              },

                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                controller: ccv,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'ccv',
                                ),
                                validator: ( value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'ccv must not be empty';
                                  }

                                  return null;
                                },
                                onFieldSubmitted: (value){
                                  print(value);
                                },

                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ) ,
                ),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(onPressed: (){
                    if(formKey.currentState!.validate())
                    {

                    }
                  },
                    child: Container(
                        width: 260,
                        height: 67,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),


                          color: Colors.red[700],

                        ),
                        child: Center(child: Text("Proceed",style: TextStyle(fontSize:30,color: Colors.white  )))
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
