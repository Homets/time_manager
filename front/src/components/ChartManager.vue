<template>
    <div class="dash">
     
      <canvas id="workingChart"></canvas>
      
    </div>
  </template>
  
<script>
  import "../styles/DashBoard.scss"
  import "../styles/User.scss"

  import workingTimeChart from "./subComponents/working-time"
  import Chart from 'chart.js'

  // ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)
  

export default {
  name: 'ChartManager',
  data() {
    return {
      workingTimeChart: workingTimeChart
    }
  },
  mounted() {
    const ctx = document.getElementById('workingChart');
    new Chart(ctx, this.workingTimeChart);
  }
}
</script>
