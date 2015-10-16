$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $("#poem-form").on("submit", function( event ) {
    event.preventDefault();
    var $url = $(this).attr("action");
    var data = {
        text: $("#poem-box").val()
    }
    // console.log($url);
    // console.log(data);
    var request = $.post($url, data, function(response) {
        $("#content").html(response);
    });
  })

  $("#content").on("click", "span", function( event ) {
    event.preventDefault();
    console.log("okay so far")
    var data = {
        word: $(this).text() ,
        text: $(this).parent().text()
    }
    console.log(data)
    var request = $.get("/rhymes", data, function(response) {
        console.log(response)
        $('span').css("background-color", "white");
        $('span')
                .filter(function() {
                    return this.className.match(response);
                })
                .css("background-color", "red");
    })
  })
});
