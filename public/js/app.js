$(document).ready(function(){
  
  var keys = ["le", "nh", "bo", "ki", "ta", "br", "in", "lo", "py"];
  
  for(var i = 0; i < keys.length; i++) {
    var uri = "/" + keys[i];
    $.getJSON(uri, function(data, textStatus, jqxhr) {
      updateStatus(data, this.url.substring(1));
    });
  }
  
  function updateStatus(base, id) {
    var li = $("#" + id);
    var span = $("#" + id + " span");
    console.log(id);
    if (base.status == "online") {
      $(li).removeClass("list-group-item-warning");
      $(span).removeClass("pulse");
      $(li).addClass("list-group-item-success");
      $(span).text("online");
    }
    else {
      $(li).removeClass("list-group-item-warning");
      $(span).removeClass("pulse");
      $(li).addClass("list-group-item-danger");
      $(span).text("offline");
    }
    
  }
  
});
