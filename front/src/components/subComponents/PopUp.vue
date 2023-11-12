<template>
  <div class="modal">
    <div class="modal-inner">      
      <button  class="close-butt" @click="close">&times;</button>
      <p class="p-first">Add Working Time</p>      
      <div class="form_ctr">
        <div class="work-ctr-pop">
          <form class="added-time" @submit.prevent="handleSubmit">
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

            <button class="add-work-butt">Add</button>
          </form>
                 
        </div>
      </div>
        <p class="p-class" v-if="submitting">Submitting...</p>
        <p class="p-class" v-if="submitting">Working Time Added!</p>
    </div>
  </div>
</template>
  
<script>


export default {
    
  name: 'PopUp',
    data() {
        return {
              start: '',
              end: '',
              userToken: '',
              loggedUser: {
                id: 0,
              },
              submitting: false,
              submitted: false
        }
    },

    async created (){
      this.submitted = false;
      this.userToken = localStorage.getItem('user_token');

      const url = `${process.env.VUE_APP_API_BASE_URL}api/current/user`;
        var myHeaders = new Headers();
        myHeaders.append("Authorization", "Bearer " + this.userToken);
        if ( this.userToken != "") {
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
                
                this.loggedUser.id = (JSON.stringify(responseData.data.id));
                // console.log (this.loggedUser.id);
                // this.$router.push({path: '/Dashboard'});

            } catch (error) {
                console.error('Error:', error);
                
            }
        } else {
            localStorage.setItem('user_token', "");
            this.$router.push({path: '/Register'});
        }
    },

    methods: {
      close() {
        this.$emit("close");
      },

      async handleSubmit() {
        const url = `${process.env.VUE_APP_API_BASE_URL}api/workingtimes/${this.loggedUser.id}`;
        this.submitting = true;
        var myHeaders = new Headers();

        myHeaders.append("Authorization", "Bearer " + this.userToken);
        console.log("token: " + this.userToken);
        const data = {
          // workingtime: {
            start: this.start,
            end: this.end,
            // user: this.loggedUser.id,
          // }
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
          
          console.log("Handle sub " + JSON.stringify(responseData.data.id));
          localStorage.setItem("workTimeId", JSON.stringify(responseData.data.id))
    
          console.log("workingTime: " + JSON.stringify(responseData.data.id));
          // this.$router.push({path: '/Dashboard', query: { workTimeId: JSON.stringify(responseData.data.id)}});
          this.submitting = false;
          this.submitted = true;

        } catch (error) {
          console.error('Error:', error);
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
  .modal-inner {  
    display: flex;
    flex-direction: column;
    // align-items: center;
    // align-content: center;
    background-color: white;
    border-radius: 0.5em;
    padding: 2em;
    margin: auto;

    .p-first{
      padding-left: 20px;
      text-transform:uppercase;
      font-weight: bold;
    }
  }

  .work-ctr-pop{
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

  .form_ctr {
  width: 100%;
  display: flex;
  // flex-direction: row;
  // align-items: center;
  justify-content: center;
  }
</style>