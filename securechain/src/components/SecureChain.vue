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
      <button @click="loginWithMetaMask">Login with MetaMask</button>
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
    };
  },
  methods: {
    async loginWithMetaMask() {
      if (window.ethereum) {
        try {
          // Kullanıcının cüzdanını bağlayın
          const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
          this.isAuthenticated = true;
          this.user.name = accounts[0]; // Cüzdan adresini kullanıcı adı olarak alabilirsiniz
          this.securityScore = Math.floor(Math.random() * 100); // Simüle edilmiş puan
        } catch (error) {
          console.error('User denied account access', error);
        }
      } else {
        alert('Please install MetaMask!');
      }
    },
    logout() {
      this.isAuthenticated = false;
      this.user.name = '';
      this.securityScore = 0;
    },
  },
};
</script>

<style scoped>
.secure-chain {
  text-align: center;
}
button {
  margin-top: 10px;
}
</style>
