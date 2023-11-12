<template>
  <div class="user">

    <!-- <div v-if=" user_id === 0" class="user-box"> -->
    <div class="user-box">
      <h1>Create Your Employee Account</h1>
      <div class="user-ctr">
      <form class="input-feild"  @submit.prevent="handleSubmit">
        <input
          class="search-input"
          v-model="username"
          placeholder="Username"
          type="text"
        />
        <input
          class="search-input"
          v-model="email"
          placeholder="Email"
          type="text"
        />
        <input
          class="search-input"
          v-model="password"
          placeholder="Password"
          type="password"
        />

          <button class="btn-search">Register</button>

      </form>
          <p>Already have an account?</p>
          <button v-on:click="loginHandler" class="btn-second">Sign in</button>

      <p v-if="submitting">Submitting...</p>
      <!-- <p v-if="loading">Loading...</p> -->

      </div>
    </div>

    <div class="page-render">
      <router-view></router-view>
    </div>
    <!-- <div v-else-if=" user_id !== 0" class="user-info">

      <UserSpec :user = "loggedUser"></UserSpec>
      
    </div> -->
    
  </div>
 
</template>

<script>

import "../styles/User.scss";
// import UserSpec from "./subComponents/UserSpec.vue";

export default {
  name: 'UserProfile',
  // components: {
  //   UserSpec
  // },

  data() {
    return {
      // loggedUser: {
      //   id: 0,
      //   userName: '',
      //   userEmail: ''
      // },
      username: '',
      email: '',
      password: '',
      user_id: 0,

      // loading: false,
      submitting: false,
    };
  },
  // created () {
  //   const userToken = localStorage.getItem('user_token');
  //   console.log("THIS IS " + userToken);
  //   if (userToken != null) {
  //     this.$router.push({path: '/Account'});

  //   }
  // }
  // ,

  methods: {

    loginHandler: function () {
      this.$router.push({path: '/SignIn'});

    }
    ,

    async handleSubmit() {
      // let inApp = false;
      const url = `${process.env.VUE_APP_API_BASE_URL}api/register`;
      this.submitting = true;

      const data = {
        user: {
          username: this.username,
          email: this.email,
          password: this.password
        }
      };

      try {
        const response = await fetch(url, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(data),
        });

        if (!response.ok) {
          throw new Error('Network response was not ok');
        }

        const responseData = await response.json();
        
        console.log("Handle sub " + JSON.stringify(responseData.data.id));
      
        this.$router.push({path: '/Signin'});
        this.submitting = false;

      } catch (error) {
        console.error('Error:', error);
      }
    }
  }
}
</script>



