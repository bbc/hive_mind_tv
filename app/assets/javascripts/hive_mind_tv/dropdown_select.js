$(function(){
  $(".dropdown-menu li a").click(function(event) {
    var hive = $(".dropdown-menu .hive_id");
    var device_id = $(".dropdown-menu .device_id").val();
    var hive_id = null;
    event.preventDefault();
    if (event.toElement.id === 'disconnect') {
      url = '/api/plugin/hive/disconnect';
      hive_id = hive.val();
      var new_hive_id = null;
    } else {
      url = '/api/plugin/hive/connect';
      hive_id = event.toElement.id
      var new_hive_id = hive_id;
    }
    var label = $(".btn:first-child");
    var text = $(this).text();
    $.ajax({
      type: 'PUT',
      url: url,
      data: {
        'connection': {
          'hive_id': hive_id,
          'device_id': device_id
        },
        success: function(data){
          label.text(text);
          label.val(text);
          hive.val(new_hive_id);
        },
      }
    }).fail(function(XMLHttpRequest, textStatus, errorThrown) {
      if (XMLHttpRequest.status == 0 ) {
        errorThrown = 'No response from server';
      }
      alert("Failed to update Hive\nError: " + errorThrown);
    });
  });
});
