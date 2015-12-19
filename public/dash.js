console.log('linked');

$(document).ready(function() {

  google.setOnLoadCallback(drawChart);
  function drawChart() {

    var data = google.visualization.arrayToDataTable([
      ['Grade', 'Students'],
      ['90-100%', 3],
      ['80-89%',  2],
      ['70-79%',  4],
      ['60-69%',  2],
      ['Less',    1]
    ]);

    var options = {
      backgroundColor: 'none',
      legend: {position: 'none'}
    };

    var chart = new google.visualization.PieChart(document.getElementById('piechart'));

    chart.draw(data, options);
  };

// $(window).on('resize',function() {
//   console.log('resize')
//   $('svg').css({"width":"100%"})
// });



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
      $dashCohort = $('.dash').children().first()
      $dashCohort.text("Cohort: "+choice)
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