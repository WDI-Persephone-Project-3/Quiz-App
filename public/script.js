console.log('linked');

$(document).ready(function() {

 var $cohortChoice = $('.cohort-choice');
 $cohortChoice.on('change', function(){

  var choice = $cohortChoice.val().trim();
  console.log(choice);

  $.ajax({
    method: "GET",
    dataType: "json",
    url: "/instructors/dash/cohort",
    success: function(data){
      console.log(data)
      $dash = $('.dash')
      $dash.text(choice)
    },
    error: function(data, err){
      console.log(data)
      console.log(err)
    },
    done: function(data) {
      console.log(data)
    }
  })

  // $.get("/instructors/dash/cohort?cohort="+choice, function(data) {
  //   console.log('DATA ', data);
  // });
 });
});