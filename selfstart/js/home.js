$(document).ready(function() {
  
  var authToken;
  App.authToken.then(function setAuthToken(token) {
      if (token) {
          authToken = token;
      } else {
          window.location.href = '/signin.html';
      }
  }).catch(function handleTokenError(error) {
      alert(error);
      window.location.href = '/signin.html';
  });

  function requestSchedules() {
      $.ajax({
          method: 'GET',
          url: _config.api.invokeUrl + '/schedules',
          headers: {
            'Authorization': App.cognitoToken
          },
          contentType: 'application/json',
          success: ajaxSuccess,
          error: ajaxError
      });
  }

  function renderSchedules(list) {
    var table = document.createElement("table");
    var tr = table.insertRow(-1);

    var cols = []; 
    for (var i = 0; i < list.length; i++) { 
      for (var k in list[i]) { 
          if (cols.indexOf(k) === -1) { 
              cols.push(k); 
          } 
      } 
    }
    
    for (var i = 0; i < cols.length; i++) { 
      var theader = document.createElement("th"); 
      theader.innerHTML = cols[i]; 
      tr.appendChild(theader); 
    } 
    
    for (var i = 0; i < list.length; i++) { 
        trow = table.insertRow(-1); 
        for (var j = 0; j < cols.length; j++) { 
            var cell = trow.insertCell(-1); 
            cell.innerHTML = list[i][cols[j]]; 
            if (j==0) {
              cell.innerHTML = "<A HREF='#' onclick=ManageEnv(this)>" + cell.innerHTML + "</A>";
            }
        } 
    } 
    
    var el = document.getElementById("schedulesTable"); 
    el.innerHTML = ""; 
    el.appendChild(table);
  }

  function ajaxError(jqXHR, textStatus, errorThrown) {
      console.error('Error requesting schedules: ', textStatus, ', Details: ', errorThrown);
      console.error('Response: ', jqXHR.responseText);
      alert('An error occured when requesting schedules:\n' + jqXHR.responseText);
  }

  function ajaxSuccess(result) {
      console.log('Response received from API: ', result);
      renderSchedules(result);
  }

  requestSchedules();
  
});

function ManageEnv(item) {
  var lambdaName = item.innerText;
  if (confirm("do you really want to invoke '" + lambdaName + "' ?")) {
    $.ajax({
      method: 'POST',
      dataType: 'json',
      data: {
        'command': lambdaName,
        'command2': lambdaName,
        'command3': lambdaName
      },
      url: _config.api.invokeUrl + '/manage',
      headers: {
        'Authorization': App.cognitoToken
      },
      contentType: 'application/json',
      success: function () {
        alert('success');
      },
      error: manageError
    });

    function manageError(jqXHR, textStatus, errorThrown) {
      console.error('Error managing environment: ', textStatus, ', Details: ', errorThrown);
      console.error('Response: ', jqXHR.responseText);
      alert('An error occured when managing environment:\n' + jqXHR.responseText);
    }
  }
}
