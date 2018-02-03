// initialize an introjs instance          
var intro = introJs();

// handler 2
Shiny.addCustomMessageHandler("startHelp", 

    function(message) {

    // start intro.js
    // note: we don't need information from shiny, just start introJS
    intro.start();
  }
);