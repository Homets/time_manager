<template>
    <div class="work-time">
      <div class="work-button">
        <h1>Working Time</h1>
        <!-- <h3>{{ msg }}</h3> -->
        <button @click="openModal">✛ Add</button>
        <PopUp v-show="isModalVisible" @close="closeModal" ></PopUp>
       
        <!-- <Teleport to="body">
          <Popup v-if="isOpened" @close="isOpened = !isOpened" />
        </Teleport> -->
      </div>
     
        <!-- <div class="work-ctr"> -->
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
                //getting workingtimes here
                else {
                  const responseData = await response.json();
                  
                  console.log("CHECK log workuser " + JSON.stringify(responseData.data));
                  this.loggedUser.id = (JSON.stringify(responseData.data.id));

                  const url = `${process.env.VUE_APP_API_BASE_URL}api/workingtimes/${this.loggedUser.id}`;
                
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
                    console.log("workingtimes " + JSON.parse(JSON.stringify(responseData.data)));
                    this.loggedUser.id = (JSON.stringify(responseData.data.id));
                    this.inside = true;

                  } catch (error) {
                    console.error('Error:', error);
                    // localStorage.setItem('user_token', "");
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

.work-time {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;
  margin-bottom: 50px;
 
}

.page-render{
  width: 100%;
  display: flex;
  /* align-items: center; */
  justify-content: center;
}




</style>
