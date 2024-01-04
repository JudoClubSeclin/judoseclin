import 'package:bloc/bloc.dart';
import 'package:judoseclin/ui/common/payment/bloc/payment_event.dart';
import 'package:judoseclin/ui/common/payment/bloc/payment_state.dart';

import '../interactor/payment_interactor.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentInteractor paymentInteractor;

  PaymentBloc(this.paymentInteractor) : super(SignUpInitialState()) {
    on<PaymentEvent>((event, emit) async {
      if (event is SignUpEvent) {
        emit(SignUpLoadingState());
        try {
          await paymentInteractor.addPayment(
              event.adherentId,
              event.amount,
              event.date,
              event.chequeNumber,
              event.chequeAmount,
              event.bankName);
          emit(SignUpSuccessState());
        } catch (error) {
          emit(SignUpErrorState(error.toString()));
        }
      }
    });
  }
}
