using Toybox.Application as App;

class EnigmaApp extends App.AppBase {

    //! onStart() is called on application start up
    function onStart(start) {
    }

    //! onStop() is called when your application is exiting
    function onStop(start) {
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [ new EnigmaView() ];
    }

}