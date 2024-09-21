<script setup>
import { getAddress } from 'viem';
import { onMounted, watch } from 'vue';
import { useProviderStore } from 'stores/provider-store';

defineOptions({
  name: 'App',
});

const providerStore = useProviderStore();

// Listening providers in explorer
window.addEventListener('eip6963:announceProvider', (event) => {
  const providerDetail = event.detail;
  providerStore.addToProviderList(providerDetail);
  // console.log(event.detail);
});

// Requests to all providers in explorer
function requestProviders() {
  window.dispatchEvent(new Event('eip6963:requestProvider'));
}

function activateAddressChangeWatcher() {
  const provider = providerStore.getProvider;
  // Handle account changes in wallet extension
  provider.on('accountsChanged', (addresses) => {
    if (addresses.length !== 0) {
      providerStore.setUserAddress(getAddress(addresses[0]));
    } else {
      providerStore.setUserAddress('');
    }
  });
}

onMounted(() => {
  requestProviders();
});

watch(() => providerStore.getProvider, () => {
  const provider = providerStore.getProvider;

  if (provider !== typeof undefined && (provider !== null)) {
    activateAddressChangeWatcher();
  }

});


</script>


<template>
  <router-view />
</template>
