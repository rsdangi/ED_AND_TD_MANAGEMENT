function ajax_enter(url, first_user_id)
{
	new Ajax.Request(url, 
	{ parameters: {name: 'sachin', id: first_user_id, sachin:'sad'},
  	method: 'get',
  	onSuccess: function(transport) {
		var_name = 		document.getElementById('field').innerHTML = transport;
  	alert(var_name);
  }
	});
}
function ajax_find(url, user_id, username, last_name)
{
alert(url);
	new Ajax.Request(url, 
	{ parameters: {id: user_id , username: username ,last_name:  last_name},
  	method: 'get',
  	onSuccess: function(transport) {
    divObject=$("field")  
    var response = transport.responseText
    divObject.innerHTML= response;
		
  	alert(var_name);
    
  }
	});
}

 function ajaxdestroy(user_id)
{
 var destroy_confirmation = confirm("do you want to delete ");
 if(destroy_confirmation)
  { alert('You are going to destroy'+user_id);
   new Ajax.Request('/users/'+ user_id,
		{ 
  		method: 'delete',
  		onSuccess: function(transport) {
    	divObj = $("delete_record");
    	divObj.innerHTML = transport.responseText;
  	}
		});
  }else
   {
    alert("You do not want to delete the record");
    return false;
   }
}

function ajax_change(id,url)
 	{
//    	 alert('Hello');
//      new Ajax.Updater(url,
//      { paramerers: {id: }} );
	}
function is_user_exists()
{
  //alert(url);
 	var name = document.getElementsByName('user[username]');
  var name_value = name[0].value;
  new Ajax.Updater('enter_name', '/users/is_user_exists',
      {parameters: { enter_name: name_value }});
}

function ajax_search(user_id)
{
 	var name = document.getElementsByName('post[search]');
  var search_value = name[0].value;
  new Ajax.Request('/users/'+user_id+'/posts/ajax_search',{parameters: {search: search_value},
  method: 'post',
  onSuccess: function(transport) {
    	divObj = $("ajax_search");
    	divObj.innerHTML = transport.responseText;
  	}
  });
}

function like_comment(where,like,unlike,current_user_id,comment_id)
{
 //where.value = (where.value == like) ? unlike :like ;
   if(where.value=="unlike")
     {   
         alert(comment_id)
         document.getElementById("unlike_comment_"+comment_id).style.display = 'none';    
   			 if(where.value == "like"){       
          where.value = "unlike";
          var Like_unlike_value="like";
    		 }
    			else if(where.value == "unlike"){
       			where.value = "like";
            var Like_unlike_value="unlike";
    			 }
     
 		 }
  		else if(where.value=="like")
  	 {
          alert("wow ram");
     		 document.getElementById("unlike_comment_"+comment_id).style.display = 'none';    
    		 if(where.value == "like"){
           where.value = "unlike";
           var Like_unlike_value="like";
      	 }
      	 else if(where.value == "unlike"){
        	where.value = "like";
          var Like_unlike_value="like";
        }   
      }  
   new Ajax.Request('/users/'+current_user_id+'/comments/'+comment_id+'/ajax_comment_status_like',
 		{ parameters: {Like_unlike_value: Like_unlike_value},
   		method: 'get',
   		onSuccess: function(transport) {
     	divObj = $("users_like_unlike_count_"+comment_id);
        divObj.innerHTML = transport.responseText;
   	}
 		});
 
 }

function like__unlike_post(where,like,unlike,current_user_id,post_id)
{
  alert(post_id);
  if(where.value=="unlike")
     {   
         //alert(comment_id)
         document.getElementById("unlike_post_"+post_id).style.display = 'none';    
   			 if(where.value == "like"){       
          where.value = "unlike";
          var Like_unlike_value="like";
    		 }
    			else if(where.value == "unlike"){
       			where.value = "like";
            var Like_unlike_value="unlike";
    			 }
     
 		 }
  		else if(where.value=="like")
  	 {
     		 document.getElementById("unlike_post_"+post_id).style.display = 'none';    
    		 if(where.value == "like"){
           where.value = "unlike";
           var Like_unlike_value="like";
      	 }
      	 else if(where.value == "unlike"){
        	where.value = "like";
          var Like_unlike_value="like";
        }   
      }  
    new Ajax.Request('/users/'+current_user_id+'/posts/'+post_id+'/ajax_post_status_like_unlike',
  		{ parameters: {Like_unlike_value: Like_unlike_value},
    		method: 'get',
    		onSuccess: function(transport) {
       // alert(transport.responseText);
      	divObj = $("user_post_unlike_"+post_id);
        divObj.innerHTML = transport.responseText;
        
    	}
  		});
   



}





