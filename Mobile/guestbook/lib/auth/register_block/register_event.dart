abstract class SignUpEvent{}

class SignUpTextChangedEvent extends SignUpEvent{
  final String data;
  final String field;
  final bool pwdVisible;
  // final String phoneNumberValue;
  SignUpTextChangedEvent(this.data, this.field, this.pwdVisible);
}

class SignUpSubmitedEvent extends SignUpEvent{
  final String email;
  final String password;
  final String phoneNumber;
  SignUpSubmitedEvent(this.email, this.password, this.phoneNumber);
}

class SignUpMapGetCurentLocationEvent extends SignUpEvent{
  final String dataParse;
  SignUpMapGetCurentLocationEvent(this.dataParse);
}

class demProfinsiEvent extends SignUpEvent{
  final String kriteria;
  demProfinsiEvent(this.kriteria);
}
class demKotaEvent extends SignUpEvent{
  final String kriteria;
  final String provID;
  demKotaEvent(this.kriteria, this.provID);
}
class demKecamatanEvent extends SignUpEvent{
  final String kriteria;
  final String kotaID;
  demKecamatanEvent(this.kriteria, this.kotaID);
}
class demKelurahanEvent extends SignUpEvent{
  final String kriteria;
  final String kecID;
  demKelurahanEvent(this.kriteria,this.kecID);
}