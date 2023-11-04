abstract class RemoteUserEvent {
  final int quantity;

  const RemoteUserEvent({this.quantity = 1});
}

class GetRandomUsers extends RemoteUserEvent {
  GetRandomUsers({super.quantity});
}