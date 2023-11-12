<template>
    <div class="work-time">
        <h2>Enter Informations</h2>
        <form class="input-feild" @submit.prevent="handleSubmit">
    
            <input
                class="search-input"
                v-model="start"
                placeholder="Start date"
                type="text" required
            />
            <input
                class="search-input"
                v-model="end"
                placeholder="End date"
                type="text" required
            />
        <button class="btn-search">Save</button>
        </form>
    </div>
  </template>
  
  <script>
  import "../../styles/WorkingTime.scss"
  import "../../styles/User.scss"

  export default {
    name: 'AddWorkingTime',
    // props: {
    //   msg: String
    // }
  }
  </script>