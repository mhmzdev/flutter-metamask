import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/ethereum.dart';

class MetaMaskProvider extends ChangeNotifier {
  int currentChain = -1;
  String currentAddress = '';
  static const operatingChain = 4;

  bool get isEnabled => ethereum != null;

  bool get isInOperatingChain => currentChain == operatingChain;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  // connect
  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;

      currentChain = await ethereum!.getChainId();

      notifyListeners();
    }
  }

  // clear data
  void clear() {
    currentAddress = '';
    currentChain = -1;

    notifyListeners();
  }

  void init() {
    /// in both the cases we clear the data and re-sign in the metamask
    if (isEnabled) {
      // whenever the account is changed
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });

      // whenever the chain is change
      ethereum!.onChainChanged((chainId) {
        clear();
      });
    }
  }
}
