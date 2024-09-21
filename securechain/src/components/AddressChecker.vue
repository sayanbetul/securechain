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
  <q-card class="bg-white">
    <q-card-section class="text-h4">
      Address checker
    </q-card-section>
    <q-card-section>
      <q-input v-model="walletAddress" dense label="Wallet address" no-error-icon
               outlined
               rounded />
    </q-card-section>
    <q-card-actions align="center">
      <q-btn-group class="bg-amber-3 full-width" flat push unelevated>
        <q-btn v-for="(button,key) in buttons" :key="key" :label="button.label" :ripple="false" class="full-width"
               no-caps
               push rounded unelevated
               @click="button.func" />
      </q-btn-group>
    </q-card-actions>
  </q-card>
</template>

<style scoped>

</style>
