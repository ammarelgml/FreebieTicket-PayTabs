import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String stripePublishableKey =
    'pk_test_51LiFI0FTA8ED6IvxXJ3sWBgCF2CL1cB3xA5AFtjd5RYvgDee0sqiZH2aDegUgIp9oPmx1mgngjiTcK3LnEb7MP8Y00ln4B7iH5';

// Todo: Remove it before commit
const String stripeSecretKey =
    'sk_test_51LiFI0FTA8ED6Ivx6dImUjq9No9iwtqL8NokrxxjlFudc2CF5E4kC90fQacDaLYYvcecpZd5Nb01QIpDsn8zX74C002teA8dET';

const double dotRadius = 5;
const double dotSpacing = 15;

const String mapStyle =
    '[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit","stylers":[{"visibility":"off"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#bbdefb"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#bbdefb"}]}]';

const String mapStyle2 =
    '[{"featureType": "administrative.land_parcel","stylers": [{"visibility": "off"}]},{"featureType": "administrative.neighborhood","stylers": [{"visibility": "off"}]},{"featureType": "poi.business","stylers": [{"visibility": "off"}]},{"featureType": "poi.park","elementType": "labels.text","stylers": [{"visibility": "off"}]},{"featureType": "road","elementType": "labels","stylers": [{"visibility": "off"}]},{"featureType": "road.arterial","elementType": "labels","stylers": [{"visibility": "off"}]},{"featureType": "road.highway","elementType": "labels","stylers": [{"visibility": "off"}]},{"featureType": "road.local","stylers": [{"visibility": "off"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#bbdefb"}]}]}]';

final Completer<GoogleMapController> controller = Completer();

const CameraPosition initialLocation = CameraPosition(
  target: LatLng(30.04443664782354, 31.235684551378952),
  zoom: 18,
);

enum ConnectionStates {
  loading,
  timeout,
  connected,
  error,
}
