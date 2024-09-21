<template>
  <q-page class="flex flex-center">
    <address-checker />
  </q-page>
</template>

<script setup>
import Auth0Login from 'components/Auth0Login.vue';
import Auth0LogOut from 'components/Auth0LogOut.vue';
import AddressChecker from 'components/AddressChecker.vue';

defineOptions({
  name: 'IndexPage',
});
</script>
