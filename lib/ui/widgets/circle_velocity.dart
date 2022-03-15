
import 'package:appprueba/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CircleVelocity extends StatelessWidget {
  const CircleVelocity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only( bottom: 10),
        child: CircleAvatar(
          backgroundColor: Colors.greenAccent,
          maxRadius: 40,
          child: BlocBuilder<LocationBloc,LocationState>(
             builder: (context,state){
               return Text(
                 "${ state.velocity.toInt() } KM/H",
                 style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.bold,
                     color: Colors.black
                 ),
               );
             },
          )
        ),
    );
  }
}
