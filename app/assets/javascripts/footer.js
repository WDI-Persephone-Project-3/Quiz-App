$(document).ready(function(){

  if ($('body').height()<$(window).height()){
    $('.footer').css({"position":"fixed","bottom":0,"width":"100%"})
  }

  if ($('body').height()>600){
    $('.footer').css({"position":"relative","width":"100%"})
  }

  $(window).on('resize', function(){
    if($('body').height()>($(window).height())){
      $('.footer').css({"position":"","bottom":"","width":""})
    } else {
      $('.footer').css({"position":"fixed","bottom":0,"width":"100%"})
    }
  });

})