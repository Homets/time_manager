<template>
    <div class="edit-user">

      <div class="user-box">
        <h1>My account</h1>
        <h2>Edit Your User Informations </h2>
        <div class="user-ctr">
        <form class="input-feild" @submit.prevent="handleSubmit">
  
          <input
            class="search-input"
            v-model="username"
            :placeholder="loggedUser.userName"
            type="text" required
          />
          <input
            class="search-input"
            v-model="email"
            :placeholder="loggedUser.userEmail"
            type="text" required
          /> 
          <input
            class="search-input"
            v-model="password"
            placeholder="New Password"
            type="password" required
        />
          
          <button class="btn-search">Save Changes</button>
        </form>
        <button @click="deleteAccount" class="btn-delete">Delete Account</button>
        <button @click="logoutUser" class="btn-logout">Logout</button>

        <p v-if="submitting">Submitting...</p>
        <!-- <p v-if="loading-->
  
        </div>
      </div>
      <!-- <WorkingTime></WorkingTime> -->

    </div>
   
</template>
  
<script>
//   import "../../styles/User.scss"


  export default {
    name: 'UserSpec',

    data() {
        return {
            loggedUser: {
                id: 0,
                userName: '',
                userEmail: '',
                
            },
            username: '',
            email: '',
            password: '',
            loading: false,
            submitting: false,
        };
    },

    async created() {

        const url = `${process.env.VUE_APP_API_BASE_URL}api/current/user`;
        console.log("USER INFO: " + this.$route.query.userToken);
        var myHeaders = new Headers();
        myHeaders.append("Authorization", "Bearer " + this.$route.query.userToken);
        if ( this.$route.query.userToken != "") {
            try {
                const response = await fetch(url, {
                method: 'GET',
                headers: myHeaders,
                redirect: 'follow'
                });
                
                if (!response.ok) {
                throw new Error('Network response was not ok');
                }

                const responseData = await response.json();
                
                
                console.log("CHECK log user " + JSON.stringify(responseData.data));
                this.loggedUser.userName = JSON.parse(JSON.stringify(responseData.data.username));
                this.loggedUser.userEmail = JSON.parse(JSON.stringify(responseData.data.email));
                this.loggedUser.id = (JSON.stringify(responseData.data.id));
                // this.$router.push({path: '/Dashboard'});

            } catch (error) {
                console.error('Error:', error);
                localStorage.setItem('user_token', "");
                this.$router.push({path: '/Register'});
            }
        } 

       
    },

    methods: {
        async handleSubmit() {
            const url = `${process.env.VUE_APP_API_BASE_URL}api/users/${this.loggedUser.id}`;
            this.submitting = true;
            const data = {
                // user: {
                    username: this.username,
                    email: this.email,
                    password: this.password
                // }
            };

            try {
                const response = await fetch(url, {
                    method: 'PUT',
                    headers: {
                        "Authorization": "Bearer " + this.$route.query.userToken,
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(data),
                });

                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const responseData = await response.json();
                // Handle the response data here
                console.log(responseData);
                this.submitting = false;
            }
            catch (error) {
                // Handle any errors here
                console.error('Error:', error);
            }
        },
        async deleteAccount() {
            const url = `${process.env.VUE_APP_API_BASE_URL}api/users/${this.loggedUser.id}`;
            this.submitting = true;
            try {
                const response = await fetch(url, {
                    method: 'DELETE'
                });
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const responseData = await response.json();
                alert(this.user.userName + " has been successfully deleted");
                console.log(responseData);
                this.submitting = false;
            }
            catch (error) {
                // Handle any errors here
                console.error('Error:', error);
            }
        },

        logoutUser() {
            localStorage.setItem('user_token', "");
            this.$router.push({path: '/SignIn'});

        }
    },
}  

</script>

