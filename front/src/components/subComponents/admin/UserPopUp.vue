<template>
  <div class="modal">
    <div class="admin-modal-inner">      
      <button  class="close-butt" @click="close">&times;</button>
      <p class="p-first">Create user</p>      
      <div class="form_ctr">
        <div class="user-ctr-pop">
          <form class="added-user" @submit.prevent="handleSubmitAd">
            <input
                class="user-input"
                v-model="username"
                placeholder="Username"
                type="text" required
            />
            <input
                class="user-input"
                v-model="email"
                placeholder="Email"
                type="text" required
            />
            <input
                class="user-input"
                v-model="password"
                placeholder="Password"
                type="password" required
            />

            <button class="add-user-butt">Add</button>
          </form>
                 
        </div>
      </div>
        <p class="p-class" v-if="submitting">Submitting...</p>
        <p class="p-class" v-if="submitted">User Added!</p>
    </div>
  </div>
</template>
  
<script>

export default {
    
  name: 'UserPopUp',
    data() {
        return {
              username: '',
              email: '',
              password: '',
              userToken: '',
              // loggedUser: {
              //   id: 0,
              // },
              submitting: false,
              submitted: false
        }
    },

    async created (){
      
    },

    methods: {
      close() {
        this.$emit("close");
      },

      async handleSubmitAd() {
        this.submitted = false;
        this.userToken = localStorage.getItem('user_token');

        const url = `${process.env.VUE_APP_API_BASE_URL}api/admin/users`;
        console.log("admintoken: " + this.userToken);
        var myHeaders = new Headers();
        myHeaders.append("Authorization", "Bearer " + this.userToken);
        myHeaders.append("Content-Type", "application/json");

        if ( this.userToken != "") {
          var raw = JSON.stringify({
            user: {
              username: this.username,
              email: this.email,
              password: this.password
            }
          });

           
          try {
            const response = await fetch(url, {
            method: 'POST',
            headers: myHeaders,
            body: raw,
          });

          if (!response.ok) {
            throw new Error('Network response was not ok');
          }

          const responseData = await response.json();
          
          console.log("created user id: " + JSON.stringify(responseData.data.id));
          localStorage.setItem("adCreaUserId", JSON.stringify(responseData.data.id));
          localStorage.setItem("adCreaUserName", JSON.stringify(responseData.data.username));
          localStorage.setItem("adCreaUserEmail", JSON.stringify(responseData.data.email));
          this.submitted = true;
          this.submitting = false;

          } catch (error) {
              console.error('Error:', error);
              
          }
        } else {
            this.$router.push({path: '/Register'});
        }
      }

    },


}



</script>

<style lang="scss" scoped>

.p-class {
  margin: 0;
  font-size: 1.1em;
}

.close-butt {
  display: flex;
  align-items: center;
  height: 40px;
  // width: max-content;
  // padding: 1px;
  border: 0;
  border-radius: 15px;
  font-size: 1.3em;
  color: white;
  background-color: black;
  font-weight: bold;
}
  .modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: rgba(36, 42, 41, 0.426);
  }
  .admin-modal-inner {  
    display: flex;
    flex-direction: column;
    // align-items: center;
    // align-content: center;
    background-color: white;
    border-radius: 0.5em;
    width: 70%;
    padding: 3em;
    // width: ;
    margin: auto;

    @media screen and (min-width: 1005px) {  
      width: 850px

    }

    .p-first{
      padding-left: 20px;
      text-transform:uppercase;
      font-weight: bold;
    }
  }

  .user-ctr-pop{
    background-color: rgba(234, 234, 234, 0.586);
    height: max-content;
    padding: 20px;
    margin-top: 20px;
    margin-bottom: 20px;
    display: flex;
    border-radius: 8px;
    width: 80%;
    justify-content: center;
  }


</style>