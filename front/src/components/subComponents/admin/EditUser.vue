<template>
  <div class="modal">
    <div class="modal-inner">      
      <button  class="close-butt" @click="close">&times;</button>
      <p class="p-first">Edit user</p>      
      <div class="form_ctr">
        <div class="user-ctr-pop">
          <h3>Personal Informations</h3>
          <form class="addEdit-user" @submit.prevent="handleSubmit">
            <input
                class="user-input"
                v-model="username"
                placeholder="New username | Enter the same if no changes"
                type="text" required
            />
            <input
                class="user-input"
                v-model="email"
                placeholder="New email | Enter the same if no changes"
                type="text" required
            />
            <input
                class="user-input"
                v-model="password"
                placeholder="New password | Enter the same if no changes"
                type="password" required
            />

            <button class="add-user-butt">Add</button>
          </form>

          <form class="work-time-user" @submit.prevent="handleSubmit">
            <h3>Add Working Times</h3>
            <input
                class="user-input"
                v-model="start"
                placeholder="Start date"
                type="text" required
            />
            <input
                class="user-input"
                v-model="end"
                placeholder="End date"
                type="text" required
            />

            <button class="add-user-butt">Add</button>
          </form>          
                 
        </div>
      </div>
        <p class="p-class" v-if="submitting">Submitting...</p>
        <p class="p-class" v-if="submitting">User Added!</p>
    </div>
  </div>
</template>
  
<script>
import "../../../styles/UserManager.scss";

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
              submitted: false,
              start: "",
              end: '',
        }
    },

    async created (){
      
    },

    methods: {
      close() {
        this.$emit("close");
      },

      async handleSubmit() {
        this.submitted = false;
        this.userToken = localStorage.getItem('user_token');

        const url = `${process.env.VUE_APP_API_BASE_URL}api/admin/users`;
        var myHeaders = new Headers();
        myHeaders.append("Authorization", "Bearer " + this.userToken);
        if ( this.userToken != "") {
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
            headers: myHeaders,
            body: JSON.stringify(data),
          });

          if (!response.ok) {
            throw new Error('Network response was not ok');
          }

          const responseData = await response.json();
          
          console.log("created user id: " + JSON.stringify(responseData.data.id));
          localStorage.setItem("adCreaUserId", JSON.stringify(responseData.data.id));
          localStorage.setItem("adCreaUserName", JSON.stringify(responseData.data.username));
          localStorage.setItem("adCreaUserEmail", JSON.stringify(responseData.data.email));
          
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

<style lang="scss">

.edit-user {
  border-bottom: transparent solid 0px;
}

.p-class {
  margin: 0;
  font-size: 1.1em;
}

.close-butt {
  display: flex;
  align-items: center;
  height: 40px;
  width: max-content;
  padding: 15px;
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
  .modal-inner {  
    display: flex;
    flex-direction: column;
    // align-items: center;
    // align-content: center;
    background-color: white;
    border-radius: 0.5em;
    padding: 2em;
    width: 85%;
    // margin: auto;
    // margin-left: 20px;
    // margin-right: 20px;

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
    flex-direction: column;
    border-radius: 8px;
    width: 80%;
    justify-content: center;
    align-items: center;
  }

  .form_ctr {
  width: 100%;
  display: flex;
  // flex-direction: row;
  // align-items: center;
  justify-content: center;
  }
</style>