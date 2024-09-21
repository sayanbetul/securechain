<script setup>


import { reactive, ref } from 'vue';
import { useAuth0 } from '@auth0/auth0-vue';

const walletAddress = ref('');

const { loginWithRedirect } = useAuth0();

function login() {
  loginWithRedirect();
}

const buttons = reactive([
  {
    label: 'Sign in',
    func: 'login',

  },
  {
    label: 'Connect wallet',
    func: 'login',

  },
]);

</script>

<template>
  <q-card class="bg-white" style="width: calc(100vw/1.5)">
    <q-card-section class="text-h5">
      Address checker
    </q-card-section>
    <q-card-section>
      <q-input v-model="walletAddress" dense label="Wallet address" no-error-icon
               outlined
               rounded />
    </q-card-section>
    <q-card-actions align="center">
      <q-btn :ripple="false" class="full-width bg-secondary text-white" flat label="Check address" no-caps push
             stretch />
    </q-card-actions>
  </q-card>
</template>

<style scoped>

</style>
