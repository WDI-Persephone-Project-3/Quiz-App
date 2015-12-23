$(document).ready(function(){

$('footer').css({"text-align":"center"})

  if ($('body').height()<$(window).height()){
    $('.footer').css({"position":"fixed","bottom":0,"width":"100%","text-align":"center"})
  }

  $(window).on('resize', function(){
    if($('body').height()>($(window).height())){
      $('.footer').css({"position":"","bottom":"","width":""})
    } else {
      $('.footer').css({"position":"fixed","bottom":0,"width":"100%"})
    }
  });

})