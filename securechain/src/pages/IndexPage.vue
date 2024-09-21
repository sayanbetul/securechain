<template>
  <q-page class="flex flex-center">
    <address-checker />
    <user-info />
  </q-page>
</template>

<script setup>
import AddressChecker from 'components/AddressChecker.vue';
import UserInfo from 'components/UserInfo.vue';

defineOptions({
  name: 'IndexPage',
});
</script>
