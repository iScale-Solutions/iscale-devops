$(document).ready(function() {
    $.ajax({
        url: "https://nkfkwoa1rg.execute-api.us-west-2.amazonaws.com/v0/lambda"
    }).then(function(data) {
       $('.greeting-id').append(data.id);
       $('.greeting-content').append(data.content);
    });
});
