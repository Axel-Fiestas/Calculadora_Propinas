import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CalculadoraPropinasApp());
}

//Calcular automaticamente la propina segun un porcentaje seleccionado
//Mostrar: Monto total a pagar (incluida la propina)
//Debe permitir al usuario ajustar el porcentaje de propina y ver como cambia el monto total

class CalculadoraPropinasApp extends StatelessWidget {
  const CalculadoraPropinasApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora de Propinas Application",
      theme: ThemeData(
          primaryColor: Colors.orange,
          primarySwatch: Colors.orange
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>const HomePage(),
        '/calculator':(context)=>const CalculatorPage()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Calculator your bribe!'),
        ),
        body: Stack(
            fit: StackFit.expand,
            children: <Widget> [
              Image.network(
                'http://m.gettywallpapers.com/wp-content/uploads/2022/06/Money-Wallpaper.jpg',
                fit: BoxFit.cover,
                color: Colors.black54,
                colorBlendMode: BlendMode.darken,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://cdn4.iconfinder.com/data/icons/stock-investment-filloutline/64/Insider-trading-stock-bribe-illegal-512.png',
                    width: 300,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>CalculatorPage())
                      Navigator.pushNamed(context, '/calculator');
                    },
                    child: Text('Empezar!'))
                ],
            ),
          ]
        ),
      ),
    );
  }
}


class CalculatorPage extends StatelessWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                  color: Colors.orange,
                  size: 50.0,
                  semanticLabel: 'Money Icon for decorative objectives',
                ),
                SizedBox(height: 50,),
                BriveForm(),
                ElevatedButton(
                    onPressed: (){
                  Navigator.pop(context);
                },child: Text('Go Back'))
              ],
            ),
          ),
        )
    );
  }
}

class BriveForm extends StatefulWidget {
  const BriveForm({Key? key}) : super(key: key);

  @override
  State<BriveForm> createState() => _BriveFormState();
}

class _BriveFormState extends State<BriveForm> {

  final _formKey=GlobalKey<FormState>();
  late String brive;
  late String porcentaje;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            width: 330,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value){
                    brive=value.toString();
                    },
                  onChanged:(text){
                    print(text.runtimeType);
                    },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingresa la propina'
                    ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Por favor ingresar valor';
                    }
                    return null;
                  }
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged:(text){print(text);},
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingresa el % que deseas dejar'
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value){

                    if(value==null || value.isEmpty){
                      return 'Por favor ingresar valor';
                    }
                    int parsedValue=int.parse(value);
                    if(parsedValue<0 || parsedValue>100) {
                      return 'Porcentaje fuera del rango (0%-100%)';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Datos correctos!'))
                        );
                      }
                    },
                    child: Text("Submit!")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


