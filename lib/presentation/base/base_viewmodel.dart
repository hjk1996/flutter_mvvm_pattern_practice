abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
      
    }

abstract class BaseViewModelInputs {
  void start(); // will be called while init of viewmodel

  void dispose(); // will be called wwhen viewmodel dies
}

abstract class BaseViewModelOutputs {}
