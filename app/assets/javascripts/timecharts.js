$(function() {

  new Highcharts.Chart({
    chart: {
      renderTo: "orders_chart"
    },
    xAxis: {
      type: "datatime",
      text: "Date",
      allowDecimals: false
    },
    yAxis: {
      title: {
        text: "Dollars"
      }
    },
    series: [{
      minTickInterval: 1,
      pointStart: nDaysAgo,
      data: nDaySales
    }]
  });
});
