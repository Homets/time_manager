<template>
  <!-- <User msg="DashBoard"/> -->
  <div class="container">
    <!-- <p>Choose what part of this page you want to see:</p> -->
    <div class="butt-ctr">

      <router-link
    :to="{
      name: 'homePage',

    }" class="button-box first-butt">
        <img alt="home logo" src="./assets/home-black.png">

      </router-link>

      <router-link
    :to="{
      name: 'loginUser',

    }" class="button-box">
        <img alt="profile logo" src="./assets/profile-black.png">

      </router-link>

    </div>

    <div class="hero-ctr">
      <div class="hero-box">
        <h1>Dashboard</h1>
        <div  class="hero-img-ctr">
          <div class="hero-image">
            <img alt="Dashboard logo" src="./assets/hero.png">
          </div>
        </div>
      </div>
    </div>
    
    <div class="page-render">
      <router-view></router-view>
    </div>
    

  </div>
  
</template>

<script>
export default {
  data() {
      return {
        // msg: "Hello"
      }
  }
}
</script>

<style>

.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  /* width: 100%; */
 
}

.page-render{
  width: 100%;
  display: flex;
  /* align-items: center; */
  justify-content: center;
}

.first-butt{
  margin-right: 20px;
}

.container  p{
    font-size: 1.2em;
}
@media screen and (min-width: 810px) {
  .container  p{
    font-size: 1.5em;
  }
}

.butt-ctr{
  margin-top: 20px;
  display: flex;
  justify-content:center;
  width: 100%;

  /* background-color: antiquewhite; */

  
}

.butt-ctr img{
    height: 50px;
}
.button-box{
  background-color: transparent;
  border: 0;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center;
  color: #2c3e50;
  margin-top: 60px; */
}

</style>
