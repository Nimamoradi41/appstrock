import 'package:flutter/material.dart';
import 'package:signalr_client/hub_connection.dart';
import 'package:signalr_client/hub_connection_builder.dart';


class scr extends StatefulWidget {
  const scr({super.key});

  @override
  State<scr> createState() => _scrState();
}

class _scrState extends State<scr> {
  final serverurl="http://172.10.10.186:9595/SignalRTest/mytesthub";
  // final serverurl="http://172.10.10.186:9595/SignalRTest";

  late HubConnection connection;

  double width=100.0, height=100.0;

  late Offset position;

  void initC()
  {
    connection=HubConnectionBuilder().withUrl(serverurl).build();
    connection.onclose((error) {print('Close Connection');});
    connection.on('ReceiveNewPosition', _handle);
  }


  @override
  void initState() {
    super.initState();
    initC();
    position=Offset(0.0, -20.0);
  }


  void _handle(List<Object> arg)
  {
    print('PPPPP');
    print(arg.toString());
    setState(() {
      double? ss=arg[0] as double?;
      double? ss2=arg[0] as double?;
      position=Offset(ss!,ss2!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              feedback: Container(
                width: width,
                color: Colors.red,
                height: height,
                child:Center(child: Text('Move Me',style: TextStyle(color: Colors.white),),),
              ),
              onDraggableCanceled: (val,offset) async{
                if(connection.state==HubConnectionState.Connected)
                  {
                    await connection.invoke('ReceiveNewPosition',args: <Object>[
                      offset.dx,
                      offset.dy,
                    ]);

                    print('AAAAAAAAAAAAAA');
                    setState(() {
                      position=offset;
                    });
                  }
              },
              child: Container(
                width: width,
                color: Colors.blueAccent,
                height: height,
                child:Center(child: Text('Move Me',style: TextStyle(color: Colors.white),),),
              ),
            ),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{


      try{
        var ss=    await connection.start();
        print('scscsc');
      }catch(w)
          {
            print(w.toString());
          }
      // print(ss.toString());

          // connection.state==HubConnectionState.Disconnected ?
          //     await connection.start()  :
          //     await connection.stop();


        },
        tooltip: 'Start/Stop',
        child: connection.state==HubConnectionState.Disconnected ?  Icon(Icons.play_arrow):Icon(Icons.stop),
      ),
    );
  }
}
