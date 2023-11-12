import { createApp } from 'vue'
import App from './App.vue'
import { createRouter, createWebHistory } from 'vue-router'
import axios from 'axios'
import VueAxios from 'vue-axios'
import DashBoard from './components/DashBoard.vue'
import User from './components/User.vue'
import UserSpec from './components/subComponents/UserSpec.vue'
import LoginUser from './components/subComponents/LoginUser.vue'
import unoverlay from 'unoverlay-vue'

// import AddWorkingTime from './components/subComponents/AddWorkingTime.vue'
// import EditWorkingTime from './components/subComponents/EditWorkingTime.vue'

const router = createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/Dashboard', component: DashBoard, name: "homePage",
            meta: {
                requiresAuth: true 
            }
        },
        { path: '/Register', component: User, name:"userPage" },

        { path: '/Account',
            component: UserSpec, 
            // props: { default: true},
            name:"userInfo" ,
            meta: {
                requiresAuth: true 
            }
        },
        { path: '/SignIn',
            component: LoginUser, 
            // props: true,
            name:"loginUser" ,
           
        },



    ]
});

router.beforeEach((to, from, next) => {
    if (to.meta.requiresAuth) {
      const userId = localStorage.getItem('user_id');
      if (userId != 0) {
        // User is authenticated, proceed to the route
        next();
      } else {
        // User is not authenticated, redirect to login
        next('/SignUp');
      }
    } else {
      // Non-protected route, allow access
      next();
    }
  });


const app = createApp(App);
// app.component('homePage', DashBoard);
// app.component('userPage', User);
app.use(unoverlay);
app.use(router);
app.use(VueAxios, axios);
app.mount('#app')

