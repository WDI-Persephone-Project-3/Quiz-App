var $cohortChoice = $('.cohort-choice');
var $studentChoice = $('.student-dropdown');
var $quizChoice = $('.quiz-dropdown');
var $quizList = $('.scroll-down').eq(0)
var $studentList = $('.scroll-down').eq(1)  
var $dashCohort = $('.dash').children().first()
var cohortChoice = $cohortChoice.val().trim();

//This creates the column chart using Google Visualization API. AJAX call pulls data from the server for use here
google.setOnLoadCallback(drawMultSeries);
function drawMultSeries() {
  $.ajax({
    method: 'GET',
    datatype: 'json',
    url: "/instructors/dash/"+$cohortChoice.val().trim()+"/quizzes/"+$quizChoice.val(),
    success: function(response){
      var data = new google.visualization.DataTable();
      //How to add data to Google Viz - it needs columns with (type, column name) as y-axis and x-axis and then rows with corresponding data
      data.addColumn('string', 'Grade Range');
      data.addColumn('number', 'Students');
      data.addRows(response);
      //Styling Google Viz requires this options - search more options in the documentation

      var options = {
        backgroundColor: 'none',
        hAxis: {
          title: 'Scores',
        },
        vAxis: {
          minValue: 0,
        },
        legend: 'none',
        animation: {
          duration: 500,
          easing: 'out',
          startup: true
        }
      };
      var chart = new google.visualization.ColumnChart(document.getElementById('column-chart'));
      chart.draw(data, options);
    },
    error: function(xhr, status, error){
      console.log(xhr, status, error)
    },
  })
}

//This creates the line chart using Google Visualization API. AJAX call pulls data from the server for use here
google.setOnLoadCallback(drawBasic);
function drawBasic() {
  $.ajax({
    method: 'GET',
    datatype: 'json',
    url: "/instructors/dash/students/"+$studentChoice.val().split(' ').join('-'),
    success: function(response){
      //Since this is using dates, we need to parse the response into Google Viz format
      parsedResponse = response.map(function(object){
        return [new Date(object.year,object.month-1,object.day), object.grade]
      })
      var data = new google.visualization.DataTable();
      //How to add data to Google Viz - it needs columns with (type, column name) as y-axis and x-axis and then rows with corresponding data
      data.addColumn('date', 'Test Day');
      data.addColumn('number', 'Grade');
      data.addRows(parsedResponse);
      //Styling Google Viz requires this options - search more options in the documentation
      var options = {
        backgroundColor: 'none',
        legend: 'none',
        hAxis: {
          title: 'Test Day'
        },
        lineWidth: 4,
        animation: {
          duration: 500,
          easing: 'out',
          startup: true
        },
        vAxis: {
          maxValue: 100
        }
      };
      var chart = new google.visualization.LineChart(document.getElementById('line-chart'));
      chart.draw(data, options);
    },
  })
}

//On Cohort drop-down change, change the title of the cohort, repopulate the lists with the new corresponding students and quizzes, and update the Google Viz
$cohortChoice.on('change', function(){
  cohortChoice = $cohortChoice.val().trim();
  $dashCohort.text("Cohort: "+cohortChoice)  
  $.ajax({
    method: "GET",
    dataType: "json",
    url: "/instructors/dash/"+cohortChoice,
    success: function(response, status, xhr){
      //Remove all list & drop-down items from quiz and student lists
      $studentList.empty()
      $quizList.empty()
      $studentChoice.empty()
      $quizChoice.empty()
      //Append new links and options to the right lists for students in the new cohort
      response["students"].forEach(function(student) {
        $studentList.append('<a href="/students/'+student.id+'">'+ student.first_name + ' ' + student.last_name + '</a>');
        $studentChoice.append('<option data-student-id='+student.id+'>'+student.first_name+' '+student.last_name+'</option>');
      });
      //Append new links and options to the right lists for quizzes in the new cohort      
      response["quizzes"].forEach(function(quiz){
        $quizList.append('<a href="/quizzes/'+quiz.id+'">'+quiz.test_day+'</a>')
        $quizChoice.append('<option data-quiz-id='+quiz.id+'>'+quiz.test_day+'</option>');             
      });
      //Change the title and charts on cohort change
      quizChoiceChange();
      studentChoiceChange();
    },
    error: function(xhr, status, error){
      console.log(xhr, status, error)
    },
  })
});

//Change the title of the column chart and draw new chart
function quizChoiceChange(){
  $('.quiz-name').text('Grades for Quiz '+$quizChoice.val());
  drawMultSeries();  
}

//Change the title of the line chart and draw new chart
function studentChoiceChange(){
  $('.student-name').text($studentChoice.val()+'\'s Grades')   
  drawBasic();  
}

//On Quiz & Student drop-down change, change titles & charts
$quizChoice.on('change', quizChoiceChange);
$studentChoice.on('change', studentChoiceChange);

