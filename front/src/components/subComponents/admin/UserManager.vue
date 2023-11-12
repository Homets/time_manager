<template>

    <div class="manage-user">
            <div class="admin-button">
            <h1>Create User</h1>
            <button @click="openModal">✛ Add</button>
            <UserPopUp v-show="isModalVisible" @close="closeModal" ></UserPopUp>
        
        
            </div>
        
            <div  v-if=" isInside === true" class="aduser-ctr">
                <h3>Created User(s)</h3>
                <div class="crea-users">
                    <li v-for="user in users" :key="user.id" class="added-user">
                        <div class="user-input">{{ user.username }}</div>
                        <div class="user-input" >{{ user.email }}</div>
                        <button @click="openUserModal"
                        class="add-user-butt">Edit info</button>
                        <EditUser v-show="isUserModalOpen"  @close="closeUserModal"></EditUser>
                    </li>
                </div>

           
            
        </div>
    </div>

</template>

<script>
import "../../../styles/UserManager.scss";
import UserPopUp from "./UserPopUp.vue";
import EditUser from "./EditUser.vue";


export default {
    name: "UserManager",
    components: { UserPopUp, EditUser },
    data() {
        return {
            isModalVisible: false,
            isUserModalOpen: false,
            show: false,
            adUserData: {
                id: 0,
                start: '',
                end: '',
                userId: 0,
            },
            username: '',
            email: '',
            isInside: false,
            users: [],

            loggedUser: {
                    id: 0,
                    // userName: '',
                    // userEmail: '',
                    
            },

        };
    },

    async created() {
        const url = `${process.env.VUE_APP_API_BASE_URL}api/admin/users`;
        this.userToken = localStorage.getItem('user_token');

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
                } else {
                    this.isInside = true;
                    const responseData = await response.json();
                
                    this.users = JSON.parse(JSON.stringify(responseData.data));
       

                }

               

            } catch (error) {
                console.error('Error:', error);
                
            }
        } 

    },

    methods: {
        openUserModal() {
            this.isUserModalOpen = true;
        },

        closeUserModal() {
            this.isUserModalOpen = false;
        },

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

    .manage-user{
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