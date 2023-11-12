<template>
    <div class="work-time">
      <div v-if=" isAdmin === true" class="admin-box">
        <div class="work-button">
        <h1>Working Time</h1>
        <button @click="openModal">✛ Add</button>
        <PopUp v-show="isModalVisible" @close="closeModal" ></PopUp>
      
    
        </div>
    
        <div v-if=" inside !== false" class="work-ctr">
          <form  class="added-time" @submit.prevent="handleSubmit">
            <input
                class="work-input"
                v-model="start"
                placeholder="Start date"
                type="text" required
            />
            <input
                class="work-input"
                v-model="end"
                placeholder="End date"
                type="text" required
            />
            <button class="add-work-butt">Change</button>
          </form>
          
        </div>


      </div>
      
        

    </div>
  </template>
  
<script>
import "../styles/WorkingTime.scss"
import PopUp from "./subComponents/PopUp.vue";
// import "../styles/User.scss"
// import PopUp from "./subComponents/PopUp.vue";

// const msg = ref('Hello World!')
// const isOpened = ref(false)


  export default {
    name: 'WorkingTime',
    // components : { PopUp },
    data() {
        return {
          isModalVisible: false,
          show: false,
          workData: {
              id: 0,
              start: '',
              end: '',
              userId: 0,
          },
          start: '',
          end: '',
          inside: false,
          isAdmin: false,

          loggedUser: {
                id: 0,
                // userName: '',
                // userEmail: '',
                
          },

        };
    },

    async created() {
      const url = `${process.env.VUE_APP_API_BASE_URL}api/current/user`;
      const userToken = localStorage.getItem('user_token');

        console.log("USER INFO: " + userToken);
        var myHeaders = new Headers();
        myHeaders.append("Authorization", "Bearer " + userToken);
        if ( userToken != "") {
            try {
                const response = await fetch(url, {
                method: 'GET',
                headers: myHeaders,
                redirect: 'follow'
                });
                
                if (!response.ok) {
                throw new Error('Network response was not ok');
                }
                else {
                  const responseData = await response.json();
                  console.log("CHECK log workuser " + JSON.stringify(responseData.data));

                  if (JSON.parse(JSON.stringify(responseData.data.role)) == "admin") {
                    this.isAdmin = true;
                    console.log("CHECK log workuser " + JSON.stringify(responseData.data));
                    this.loggedUser.id = (JSON.stringify(responseData.data.id));

                    this.adminPost(myHeaders);
                  }
                  else { // user is not admin

                  }
                  
                  
                  
                } 
              }catch (error) {
                console.error('Error:', error);
                
            }
          } else {
                localStorage.setItem('user_token', "");
                this.$router.push({path: '/Register'});
          }
      
      
    },

    components: { PopUp },
    methods: {
      async adminPost(myHeaders) {
        const url = `${process.env.VUE_APP_API_BASE_URL}api/admin/workingtimes/5`;
                
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
          console.log("workingtimes " + JSON.stringify(responseData.data));
          // this.loggedUser.id = (JSON.stringify(responseData.data.id));
          this.inside = true;

        } catch (error) {
          console.error('Error:', error);
          // localStorage.setItem('user_token', "");
        }
      }
      ,
      openModal() {
        this.isModalVisible = true;
      },
      closeModal() {
        this.isModalVisible = false;
      }
    }
}
  </script>
  
  
  <style>

.admin-box{
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.work-time {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;
  /* margin-bottom: 50px; */
 
}

.page-render{
  width: 100%;
  display: flex;
  /* align-items: center; */
  justify-content: center;
}




</style>
