<template>
    <div class="work-time">
        <h2>Enter The New Informations</h2>
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
    name: 'EditWorkingTime',
    // props: {
    //   msg: String
    // }
  }
  </script>