import 'package:flutter/cupertino.dart';
import 'package:flutter/src/scheduler/ticker.dart';

class SEOVnc extends TickerProvider{
  @override
  Ticker createTicker(TickerCallback onTick) {
    print("ticker");
    // TODO: implement createTicke
   return Ticker(onTick);
    // throw UnimplementedError();
  }
}