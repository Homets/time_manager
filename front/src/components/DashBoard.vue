<template>
    <div class="dash">
      
      <WorkingTime></WorkingTime>
      <ChartManager></ChartManager>
      
    </div>
  </template>
  
<script>
  import "../styles/DashBoard.scss"
  import "../styles/User.scss"
  import ChartManager from "./ChartManager.vue"
  import WorkingTime from "./WorkingTime.vue"

export default {
    name: 'DashBoard',

    components: { ChartManager, WorkingTime },

    created () {
      const userToken = localStorage.getItem('user_token');

      if (userToken == '') {
        this.$router.push({path: '/Signin'});
      }
    }
}


//   export default {
//   name: 'BarChart',
//   components: { Bar },
//   created() {

//   },

//   data() {
//     return {
      
      

//     }
//   }
//   //     chartData: {
//   //       type:'line',
//   //       // labels: [ 'January', 'February', 'March'],
//   //       datasets:
//   //       [

//   //         {
//   //           backgroundColor: '#000000',
//   //           label: "WorkingTimes",
//   //                   data: [{
//   //                       x: moment('2021-11-06T10:30:30').format('YYYY-MM-DD'), y: ( moment('2021-11-06T18:30:00').format('HH') - moment('2021-11-06T10:30:30').format('HH'))
//   //                   }, {
//   //                       x: moment('2021-11-07T12:10:30').format('YYYY-MM-DD'), y: ( moment('2021-11-07T19:00:00').format('HH') - moment('2021-11-07T12:10:30').format('HH'))
//   //                   }, {
//   //                       x: moment('2021-11-09T09:00:28').format('YYYY-MM-DD'), y: ( moment('2021-11-09T13:00:28').format('HH') - moment('2021-11-09T09:00:28').format('HH'))
//   //                   }, {
//   //                       x: moment('2021-11-08T09:00:05').format('YYYY-MM-DD'), y: ( moment('2021-11-08T18:40:23').format('HH') - moment('2021-11-08T14:00:05').format('HH'))
//   //                   }, {
//   //                       x: moment('2021-11-05T12:10:30').format('YYYY-MM-DD'), y: ( moment('2021-11-07T19:00:00').format('HH') - moment('2021-11-07T08:10:30').format('HH'))

//   //                   }],
//   //                   fill: false,
//   //                   borderColor: '#D8DAFF',
                  
//   //                   borderWidth: 3
      
//   //               },
//   //               // {
//   //               //     label: "UK Dates",
//   //               //     data:  [{
//   //               //         x: "01/04/2014", y: "01/04/2014"
//   //               //     }, {
//   //               //         x: "01/10/2014", y: "01/04/2014"
//   //               //     }, {
//   //               //         x: "01/04/2015", y: "01/04/2014"
//   //               //     }, {
//   //               //         x: "01/10/2015", y: "01/04/2014"
//   //               //     }],
//   //               //     fill:  false,
//   //               //     borderColor: 'blue'
//   //               // }
    
//   //         ]
//   //         },
//   //         options: {
//   //           responsive: true,
//   //           lineTension: 1,

//   //           title:      {
//   //               display: true,
//   //               text:    "Chart.js Time Scale"
//   //           },
//   //           scales:     {
//   //             xAxes: [{
//   //               display: true,
//   //               type: 'time',
//   //               // bounds: 'ticks',
//   //               time: {
//   //                 parser: 'MM/DD/YYYY HH:mm',
//   //                 tooltipFormat: 'll HH:mm',
//   //                 unit: 'day',
//   //                 unitStepSize: 1,
//   //                 displayFormats: {
//   //                   'day': 'MM/DD/YYYY'
//   //                 }
//   //               }
//   //             }],
//   //             yAxes: [
//   //               {
//   //                 ticks: {
//   //                   beginAtZero: true,
//   //                   padding: 25
//   //                 }
//   //               }
//   //            ],
//   //           }
//   //       }
//   //   }
//   // }
// }



  </script>
  
  
<style>
  canvas {
    user-select: none;
    -moz-user-select: none;
    -webkit-user-select: none;
    -ms-user-select: none;
  }
</style>