import moment from 'moment'

export const workingTimeChart = {
    type: "line",
    data: {
      labels: [
        
            moment('2021-11-06T10:30:30').format('YYYY-MM-DD')
        ,
            moment('2021-11-07T12:10:30').format('YYYY-MM-DD')
        ,
            moment('2021-11-09T09:00:28').format('YYYY-MM-DD')
        ,
            moment('2021-11-08T09:00:05').format('YYYY-MM-DD')
        ,
            moment('2021-11-05T12:10:30').format('YYYY-MM-DD')

      ],
      datasets: [
        {
            
                backgroundColor: '#5B5C607A',
                label: "WorkingTimes",
                        data: [
                            ( moment('2021-11-06T18:30:00').format('HH') - moment('2021-11-06T10:30:30').format('HH'))
                    , 
                           ( moment('2021-11-07T19:00:00').format('HH') - moment('2021-11-07T12:10:30').format('HH'))
                        , 
                            ( moment('2021-11-09T13:00:28').format('HH') - moment('2021-11-09T09:00:28').format('HH'))
                        ,
                            ( moment('2021-11-08T18:40:23').format('HH') - moment('2021-11-08T14:00:05').format('HH'))
                        , 
                            ( moment('2021-11-07T19:00:00').format('HH') - moment('2021-11-07T08:10:30').format('HH'))
    
                        ],
                        // fill: false,
                        borderColor: '#1A1A1B',
                        
                        borderWidth: 3
            
                    },
        //   label: "Number of Moons",
        //   data: [0, 0, 1, 2, 79, 82, 27, 14],
        //   backgroundColor: "rgba(54,73,93,.5)",
        //   borderColor: "#36495d",
        //   borderWidth: 3
        // },
        // {
        //   label: "Planetary Mass (relative to the Sun x 10^-6)",
        //   data: [0.166, 2.081, 3.003, 0.323, 954.792, 285.886, 43.662, 51.514],
        //   backgroundColor: "rgba(71, 183,132,.5)",
        //   borderColor: "#47b784",
        //   borderWidth: 3
        // }
      ]
      
    },
    options: {
      responsive: true,
      lineTension: 1,
      scales: {
        yAxes: [
          {
            ticks: {
              beginAtZero: true,
              padding: 25
            }
          }
        ]
      }
    }
  };
  
export default workingTimeChart;