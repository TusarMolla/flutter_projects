import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/activity_bloc.dart';
import 'package:ober_app/blocs/ober_account_bloc.dart';
import 'package:ober_app/blocs/auth_bloc.dart';
import 'package:ober_app/blocs/booking_screen_bloc.dart';
import 'package:ober_app/blocs/demo_bloc.dart';
import 'package:ober_app/blocs/location_search_bloc.dart';
import 'package:ober_app/blocs/main_bloc.dart';
import 'package:ober_app/blocs/map_bloc.dart';
import 'package:ober_app/blocs/refund_bloc.dart';
import 'package:ober_app/blocs/setting_bloc.dart';
import 'package:ober_app/blocs/ticket_bloc.dart';
import 'package:ober_app/blocs/trip_bloc.dart';
import 'package:ober_app/blocs/trip_pay_bloc.dart';
import 'package:ober_app/blocs/user_data_bloc.dart';
class BlocProviders{

  static  get  get=>[
    BlocProvider(create:(context) =>DemoBloc()),
    BlocProvider(create:(context) =>MainBloc()),
    BlocProvider(create:(context) =>OberAccountBloc()),
    BlocProvider(create:(context) =>MapBloc()),
    BlocProvider(create:(context) =>LocationSearchBloc()),
    BlocProvider(create:(context) =>BookingScreenBloc()),
    BlocProvider(create:(context) =>AuthBloc()),
    BlocProvider(create:(context) =>UserDataBloc()),
    BlocProvider(create:(context) =>TripBloc()),
    BlocProvider(create:(context) =>ActivityBloc()),
    BlocProvider(create:(context) =>TicketBloc()),
    BlocProvider(create:(context) =>SettingBloc()),
    BlocProvider(create:(context) =>RefundBloc()),
    BlocProvider(create:(context) =>TripPayBloc()),
  ];

}