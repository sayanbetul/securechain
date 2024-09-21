<script setup>
import { useAuth0 } from '@auth0/auth0-vue';

const { logout } = useAuth0();

function _logout() {
  logout({ logoutParams: { returnTo: window.location.origin } });
}
</script>

<template>
  <div>
    <button @click="_logout">Log out</button>
  </div>
</template>

<style scoped>

</style>
