import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  bool isFemale = false;
  String _result = 'Please, follow the fields above';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildForm(),
            _submitButton(),
            _showCalculatedImc()
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Calculador de IMC'),
      backgroundColor: Colors.blueAccent,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _clearFields();
          },
        )
      ],
    );
  }

  void _clearFields() {
    _weightController.clear();
    _heightController.clear();
    setState(() {
      _result = 'Let\'s begin again!';
    });
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        children: <Widget>[
          _buildFormField(
            controller: _weightController,
            error: 'Put your weight!',
            label: 'Weight (kg)'
          ),
          _buildFormField(
            controller: _heightController,
            error: 'Put your height!',
            label: 'Height (cm)'
          ),
          Row(
            children: <Widget>[
              Text('Male'),
              Switch(
                value: isFemale,
                activeTrackColor: Colors.lightBlueAccent, 
                activeColor: Colors.blue,
                onChanged: (value) {
                  isFemale = value;
                }
              ),
              Text('Female')
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFormField({TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (value) {
        return value.isEmpty ? error : null;
      },
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: RaisedButton(
        onPressed: () {
          if (_heightController.text.isNotEmpty && _weightController.text.isNotEmpty) {
            calculateImc();
          }
        },
        child: Text('Calcular!'),
      ),
    );
  }

  Widget _showCalculatedImc() {
    return Text(
      _result,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    );
  }

  Widget calculateImc() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100.0;
    double imc = weight / (height * height);

    setState(() {
      _result = "IMC = ${imc.toStringAsPrecision(2)}\n";
      
      if (imc < 18.6)
        _result += "Abaixo do peso";
      else if (imc < 25.0)
        _result += "Peso ideal";
      else if (imc < 30.0)
        _result += "Levemente acima do peso";
      else if (imc < 35.0)
        _result += "Obesidade Grau I";
      else if (imc < 40.0)
        _result += "Obesidade Grau II";
      else
        _result += "Obesidade Grau IIII";
    });
  }
}