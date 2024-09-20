<template>
  <div class="secure-chain">
    <h1>SecureChain</h1>
    <div v-if="isAuthenticated">
      <p>Welcome, {{ user.name }}!</p>
      <p>Your security score: {{ securityScore }}</p>
      <button @click="logout">Logout</button>
    </div>
    <div v-else>
      <h2>Please log in</h2>
      <form @submit.prevent="login">
        <input type="text" v-model="username" placeholder="Username" required />
        <input type="password" v-model="password" placeholder="Password" required />
        <button type="submit">Login</button>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isAuthenticated: false,
      user: {
        name: '',
      },
      securityScore: 0,
      username: '',
      password: '',
    };
  },
  methods: {
    login() {
      // Mock authentication logic
      if (this.username === 'user' && this.password === 'password') {
        this.isAuthenticated = true;
        this.user.name = this.username;
        this.securityScore = Math.floor(Math.random() * 100); // Simulated score
      } else {
        alert('Invalid credentials');
      }
    },
    logout() {
      this.isAuthenticated = false;
      this.username = '';
      this.password = '';
      this.securityScore = 0;
    },
  },
};
</script>

<style scoped>
.secure-chain {
  text-align: center;
}
input {
  margin: 5px;
}
button {
  margin-top: 10px;
}
</style>
