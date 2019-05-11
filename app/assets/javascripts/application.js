// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


var set_stars= function(form_id,stars){
   
}

$(function(){
    $('.rating_star').click(function(){
        
        var star=$(this);
        var form_id = $(this).attr('data-movie-id');
        var stars=$(this).attr('data-stars');
        
        for(var i=1;i<=5;i++){
            
            if(i<=stars){
                $('#' + form_id +'_' + i).removeClass('glyphicon-star-empty');
                $('#' + form_id +'_' + i).addClass('glyphicon-star');
            }
            else{
                 $('#' + form_id +'_' + i).removeClass('glyphicon-star');
                 $('#' + form_id +'_' + i).addClass('glyphicon-star-empty');
                
            }
            
        }
       
    });  
    
    $('.star_rating_form').each(function(){
        var form_id = $(this).attr('id');
        var stars = $('#' + form_id +'_stars').val();
        set_stars(form_id,stars);
        
         $.ajax({
        type: "post",
        url: $("#" + form_id).attr('action'),
        data: $("#" + form_id).serialize()
  
            });
    
    });
});


