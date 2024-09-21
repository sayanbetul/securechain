<script setup>
import { useAuth0 } from '@auth0/auth0-vue';

const { loginWithRedirect } = useAuth0();

function login() {
  loginWithRedirect();
}
</script>

<template>
  <div>
    <button @click="login">Log in</button>
  </div>
</template>

<style scoped>

</style>
