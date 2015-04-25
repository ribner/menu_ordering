$(function() {

  new Highcharts.Chart({
    chart: {
      type: "column",
      renderTo: "items_chart"
    },
    xAxis: {
      categories: itemArray
    },
    yAxis: {
      title: {
        text: "Dollars"
      }
    },
    series: [{

      data: totalItemRevenue
    }]
  });
});
