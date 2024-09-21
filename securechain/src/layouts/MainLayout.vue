<script setup>

import { getAddress } from 'viem';
import { useProviderStore } from 'stores/provider-store';
import { scrollSepolia } from 'viem/chains';
import { useQuasar } from 'quasar';

defineOptions({
  name: 'MainLayout',
});

const providerStore = useProviderStore();
const $q = useQuasar();

// Get provider then set client
async function connectWallet(provider) {
  providerStore.setProvider(provider);
  // Make request for selected provider's accounts
  await provider.request({ method: 'eth_requestAccounts' }).then((accounts) => {
    providerStore.setUserAddress(getAddress(accounts[0]));
  }).catch((e) => {
    console.log(e.message);
    providerStore.setUserAddress('');
  });

  // Create wallet client
  if (providerStore.getUserAddress !== '') {
    providerStore.setWalletClient(provider);

    try {
      await providerStore.getWalletClient.addChain({ chain: scrollSepolia });
      await providerStore.getWalletClient.switchChain({ id: scrollSepolia.id });
    } catch (e) {
      if (e.message.includes('The Provider is not connected to the requested chain.')) {
        providerStore.disconnectUser();
        $q.notify({
          color: 'warning',
          message: 'Selected wallet doesn\'t supports contract chain. Please use another wallet.',
          position: 'top-right',
          timeout: 2000,
          textColor: 'black',
        });
      }
    }

  }
}


</script>

<template>
  <q-layout view="lHh Lpr lFf">
    <q-header class="bg-transparent text-black">
      <q-toolbar>

        <q-toolbar-title>
          Quasar App
        </q-toolbar-title>

        <q-btn-dropdown
          :label="providerStore.getUserAddress === '' ? 'Connect wallet' : providerStore.getUserAddress"
          class="bg-amber-4 text-black"
          color="primary"
          no-caps
          unelevated>

          <q-list v-if="providerStore.getProviders.length === 0">
            <q-item class="items-center">
              There is no wallet in browser. You can install from your browser's extensions page.
            </q-item>
          </q-list>

          <q-list v-else-if="providerStore.getUserAddress === ''">
            <q-item v-for="(provider,key) in providerStore.getProviders" :key="key" v-close-popup clickable
                    @click="connectWallet(provider.provider)">
              <q-item-section>
                <q-item-label>{{ provider.info.name }}</q-item-label>
              </q-item-section>
            </q-item>
          </q-list>

          <q-list v-else>
            <q-item v-close-popup class="bg-red-4" clickable>
              <q-item-section>
                <q-item-label @click="providerStore.disconnectUser">Disconnect</q-item-label>
              </q-item-section>
            </q-item>
          </q-list>

        </q-btn-dropdown>

      </q-toolbar>
    </q-header>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

