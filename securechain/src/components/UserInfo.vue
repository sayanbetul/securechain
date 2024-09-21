<script setup>
import { useAuth0 } from '@auth0/auth0-vue';

const { user, isAuthenticated } = useAuth0();

</script>

<template>

  <q-card>
    <q-card-section>Auth0 status</q-card-section>
    <q-card-section>{{ isAuthenticated }}</q-card-section>
    <q-card-section>{{ user }}</q-card-section>
  </q-card>

</template>

<style scoped>

</style>
