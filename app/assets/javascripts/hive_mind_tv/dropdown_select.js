$(function(){
  $(".dropdown-menu li a").click(function(event) {
    event.preventDefault();
    if (event.toElement.id === 'disconnect') {
      url = '/api/plugin/hive/disconnect';
      hive_id = 6;
    } else {
      url = '/api/plugin/hive/connect';
      hive_id = event.toElement.id
    }
    var label = $(".btn:first-child");
    var text = $(this).text();
    $.ajax({
      type: 'PUT',
      url: url,
      data: {
        'connection': {
          'hive_id': hive_id,
          'device_id': 1
        },
        success: function(data){
          label.text(text);
          label.val(text);
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
