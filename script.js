SC.initialize({
  client_id: '4660663e7f60a0886584e07a4bc7a9dc',
    redirect_uri: 'http://tbonza.github.io/data_mining/soundcloud.html'
    });

    $(document).ready(function() {
      $('a.connect').click(function(e) {
       e.preventDefault();
       SC.connect(function(){
       SC.get('/me', function(me) {
        $('#username').html(me.username);
      });
    });
  });
});
