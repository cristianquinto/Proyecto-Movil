import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../clientes/client_model.dart';
import '../clientes/client_controller.dart';

class ClientFormPage extends StatefulWidget {
  final ClientModel? editClient;

  const ClientFormPage({this.editClient});

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController address;
  late TextEditingController city;
  late TextEditingController company;

  String status = "Activo";

  @override
  void initState() {
    super.initState();

    name = TextEditingController(text: widget.editClient?.name ?? "");
    lastName = TextEditingController(text: widget.editClient?.lastName ?? "");
    email = TextEditingController(text: widget.editClient?.email ?? "");
    phone = TextEditingController(text: widget.editClient?.phone ?? "");
    address = TextEditingController(text: widget.editClient?.address ?? "");
    city = TextEditingController(text: widget.editClient?.city ?? "");
    company = TextEditingController(text: widget.editClient?.company ?? "");

    status = widget.editClient?.status ?? "Activo";
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ClientController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editClient == null
            ? "Registrar Cliente"
            : "Editar Cliente"), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _field(name, "Nombre"),
              _field(lastName, "Apellidos"),
              _field(company, "Empresa (Opcional)"),

              _field(email, "Correo Electrónico",
                  validator: (v) => v!.contains("@") ? null : "Email inválido"),

              _field(phone, "Teléfono"),
              _field(address, "Dirección"),
              _field(city, "Ciudad"),

              SizedBox(height: 15),

              /// 🔥 Selector de Estado dentro del formulario
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Estado del Cliente",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    ...["Activo", "Inactivo"]
                        .map(
                          (op) => RadioListTile(
                            fillColor:MaterialStateProperty.all(Colors.blue),
                            value: op,
                            title: Text(op),
                            groupValue: status,
                            onChanged: (v) =>
                                setState(() => status = v.toString()),
                          ),
                        )
                ]),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text(widget.editClient == null
                    ? "Guardar Cliente"
                    : "Actualizar Cliente",style: TextStyle(color: Colors.white),),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final newClient = ClientModel(
                    id: widget.editClient?.id ?? DateTime.now().toString(),
                    name: name.text,
                    lastName: lastName.text,
                    email: email.text,
                    phone: phone.text,
                    address: address.text,
                    city: city.text,
                    status: status,
                    company: company.text,
                  );

                  if (widget.editClient == null) {
                    controller.addClient(newClient);
                  } else {
                    controller.updateClient(newClient);
                  }

                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label,
      {String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: c,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        )

      ),
    );
  }
}
