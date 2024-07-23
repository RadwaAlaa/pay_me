# PayFlex
 Payement system demo

 a demo app for payment syetme between user and beneficiaries to recharge phone credits.



App Journes :

    - Login page  
    available test users: 
    verified : ra@gmail.com - 123456
    unverified : en@gmail.com - 123456

    - home page: 
     . retrieve user object 
     . retrieve user's beneficiaries list if exist.
     . add new beneficiary feature.
     . list history of all transactions 


     - Top up page: 
      . user can select from the available amounts to recharge the beneficiary.



Project Structure:

 the app is built with Flutter using Bloc state management with Cubit implementation.

 the app has modules which represent the main features of the app which are :
 - Login 
 - Home 
 - User
 - Beneficiary
 - Transaction 

 each module has (model, repository, bloc, views) folders to organize the files.

    - model:  has the data files
    - repository: has the repository interface (contract) for the repository class which handles the communication between the backend requests and the UI.
    - bloc: has the cubit implementation which handles the state managemet implementation for the UI.
    - views {screens, widgets}: sceens are consists of widgets which hold the UI pieces.


    Tests: 
    - Unit test for validating the top up process and make sure the recharge amount are correctly deducted from user's balance + 1 AED.



    App Journes :

    - Login page  
    available test users: 
    verified : ra@gmail.com - 123456
    unverified : en@gmail.com - 123456

    - home page: 
     . retrieve user object 
     . retrieve user's beneficiaries list if exist.
     . add new beneficiary feature.
     . list history of all transactions 


     - Top up page: 
      . user can select from the available amounts to recharge the beneficiary.





