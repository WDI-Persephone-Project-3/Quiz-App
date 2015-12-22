//This creates the column chart using Google Visualization API. AJAX call pulls data from the server for use here
google.setOnLoadCallback(drawBasic);
function drawBasic() {
  $.ajax({
    method: "GET",
    datatype: "json",
    url: "/students/dash/quiz",
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
      };
      var chart = new google.visualization.LineChart(document.getElementById('line-chart'));
      chart.draw(data, options);
    }
  })
}