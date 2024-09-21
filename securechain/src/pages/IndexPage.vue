<template>
  <q-page class="flex flex-center">
    <Auth0Login />
    <Auth0LogOut />
  </q-page>
</template>

<script setup>
import Auth0Login from 'components/Auth0Login.vue';
import Auth0LogOut from 'components/Auth0LogOut.vue';

defineOptions({
  name: 'IndexPage',
});
</script>
