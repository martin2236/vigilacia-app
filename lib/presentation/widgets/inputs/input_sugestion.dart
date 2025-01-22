
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/raza_entitie.dart';
import '../../../domain/entities/vehiculo_entitie.dart';


enum TipoSugerencia {raza, vehiculo}

class InputSugestion extends StatefulWidget {
  final String? titulo;
  final TipoSugerencia sugerencia;
  final List<Raza>? razas;
  final List<Vehiculo>? vehiculos;
  final Function? onValueChanged;
  const InputSugestion({super.key, this.titulo, this.onValueChanged, required this.sugerencia,this.razas, this.vehiculos});

  @override
  InputSugestionState createState() => InputSugestionState();
}

class InputSugestionState extends State<InputSugestion> {
   // A fake future builder that waits for 1 second to complete search.
  var strSuggestions ;

  // A box controller for default and local usable FieldSuggestion.
  final boxController = BoxController();

  // A box controller for network usable FieldSuggestion.
  final boxControllerNetwork = BoxController();

  // A text editing controller for default and local usable FieldSuggestion.
  final textController = TextEditingController();

  // A text editing controller for network usable FieldSuggestion.
  final textControllerNetwork = TextEditingController();

  // A ready data, that's used as suggestions for default widget and network future.
  @override
  void initState() {
    if (widget.sugerencia == TipoSugerencia.raza){
      strSuggestions = widget.razas;
    }else{
      strSuggestions = widget.vehiculos;
    }
    
    super.initState();
  }

 
 Future<List<Map<String, dynamic>>> future(String input) async {
  try {
    if (strSuggestions == null || strSuggestions.isEmpty) {
      return [];
    }
    
    return Future<List<Map<String, dynamic>>>.delayed(
      const Duration(seconds: 1),
      () {
        print('LISTA DE PRODUCTOS: ${strSuggestions.length}');
        // Verificar si son sugerencias de compras o productos y filtrar según el tipo
        if (widget.sugerencia == TipoSugerencia.raza) {
          print('TIPO : COMPRA');
          return (strSuggestions as List<Raza>)
              .where((s) => s.nombre.toLowerCase().contains(input.toLowerCase()))
              .map((s) => {'id': s.id, 'nombre': s.nombre})
              .toList();
        } else if (widget.sugerencia == TipoSugerencia.vehiculo) {
          print('TIPO : PRODUCTO');
          return (strSuggestions as List<Vehiculo>)
              .where((s) => s.nombre.toLowerCase().contains(input.toLowerCase()))
              .map((s) => {'id': s.id, 'nombre': s.nombre})
              .toList();
        } else {
          return [];
        }
      },
    );
  } catch (e) {
    print("Error en future: $e");
    return [];
  }


}

@override
Widget build(BuildContext context) {
  final text = Theme.of(context).textTheme;
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide:  BorderSide(color: Colors.blue.shade800,),
  );
  return GestureDetector(
    onTap: () {
      boxController.close?.call();
      boxControllerNetwork.close?.call();
    },
    child: Center(
      child: Column(
        children: [
          FieldSuggestion<Map<String, dynamic>>.network(
            future: (input) {
              if (widget.onValueChanged != null) {
                widget.onValueChanged!(input);
              }
              print("Buscando sugerencias para: ${strSuggestions.length}");
              return future(input);
            },
            boxController: boxControllerNetwork,
            textController: textControllerNetwork,
            inputDecoration: InputDecoration(
              hintText: widget.titulo ?? '',
              hintStyle: text.bodyMedium!.copyWith(color: Colors.grey),
              isDense: true,
              enabledBorder: border,
              border: border,
            ),
           builder: (context, snapshot) {
  if (snapshot.hasError) {
    print("Error en el snapshot: ${snapshot.error}");
  }

  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
  } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
    final result = snapshot.data ?? [];
    if (result.isEmpty) {
      return const Center(child: Text("No hay sugerencias"));
    }

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        final suggestion = result[index];
        print('Sugerencia: $suggestion');
        return GestureDetector(
          onTap: () {
            setState(() => textControllerNetwork.text = suggestion['nombre']);
            textControllerNetwork.selection = TextSelection.fromPosition(
              TextPosition(offset: textControllerNetwork.text.length),
            );
            boxControllerNetwork.close?.call();
          },
          child: Card(
            child: ListTile(title: Text(suggestion['nombre'])),
          ),
        );
      },
    );
  } else {
    return const Center(child: Text("Error al cargar sugerencias"));
  }
}


          ),
        ],
      ),
    ),
  );
}
}