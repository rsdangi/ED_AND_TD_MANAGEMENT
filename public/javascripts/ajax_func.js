

function ajax_func(url)
{
	new Ajax.Request(url, 
	{
  	method: 'get',
  	onSuccess: function(transport) {
		var_name = 		document.getElementById('test_ajax').innerHTML = transport.responseText;
  	alert(var_name);
  }
	});
}

