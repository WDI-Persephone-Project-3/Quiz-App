console.log('linked');

$(document).ready(function() {

 var $cohortChoice = $('.cohort-choice');
 $cohortChoice.change(function(){

  var choice = $cohortChoice.val().trim();
  console.log(choice);

  // $.get("/instructors/dash/cohort?cohort="+choice, function(data) {
  //   console.log('DATA ', data);
  // });
 });
});