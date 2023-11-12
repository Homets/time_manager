<template>
    <div class="user-box">
        <h1>Enter Your Informations</h1>
        <div class="user-ctr">
        <form class="input-feild" @submit.prevent="handleSubmit">
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
            
        <button class="btn-search">Sign in</button>
        <p v-if="submitting">Submitting...</p>
        </form>

        <p>Don't have an account?</p>
          <button v-on:click="registerHandler" class="btn-second">Register</button>
        
        </div>

    </div>
  </template>
  
  <script>
  import "../../styles/User.scss"

  export default {
    name: 'LoginUser',

    data() {
        return {

        email: '',
        password: '',

        submitting: false,
        };
    },

    created () {
    const userToken = localStorage.getItem('user_token');

    console.log("THIS IS " + userToken);
        if (userToken != "") {
            this.$router.push({path: "/Account", query : {userToken: userToken} });

        }
    }
    ,

    methods: {

        registerHandler: function () {
            this.$router.push({path: '/Register'});

        }
        ,

        async handleSubmit() {
        let inApp = false;
        const url = `${process.env.VUE_APP_API_BASE_URL}api/signin`;
        this.submitting = true;

        const data = {
            email: this.email,
            password: this.password
            
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
            
            this.submitting = false;
            console.log("Handle sub " + JSON.stringify(responseData.data.id));
            inApp = true;
            localStorage.setItem('in_app', JSON.stringify(inApp));
            localStorage.setItem('user_token', JSON.parse(JSON.stringify(responseData.data.token)));
            const userToken = localStorage.getItem('user_token');
            console.log("CHECK log user " + JSON.parse(JSON.stringify(responseData.data.token)));
            this.$router.push({path: '/Account', query : {userToken: userToken}});
            this.submitting = false;

        } catch (error) {
            console.error('Error:', error);
        }
        }
    },

  }
  </script>