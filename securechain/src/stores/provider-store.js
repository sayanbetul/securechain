import { defineStore } from 'pinia';
import { computed, ref } from 'vue';
import { createWalletClient, custom, getAddress } from 'viem';
import { scrollSepolia } from 'viem/chains';

export const useProviderStore = defineStore('providerStore', () => {

  //State
  const providerList = ref([]);
  const provider = ref(null);
  const walletClient = ref(null);
  const userAddress = ref('');
  const walletConnected = ref(false);

  //Getters
  const getProviders = computed(() => providerList.value);
  const getProvider = computed(() => provider.value);
  const getWalletClient = computed(() => walletClient.value);
  const getUserAddress = computed(() => userAddress.value);
  const getWalletConnected = computed(() => walletConnected.value);

  //Setters
  function setProviderList(value) {
    providerList.value = value;
  }

  function addToProviderList(provider) {
    providerList.value.push(provider);
  }

  function setProvider(_provider) {
    provider.value = _provider;
  }

  function setUserAddress(address) {
    userAddress.value = address;
  }

  function setWalletClient(provider) {
    walletClient.value = createWalletClient({
      chain: scrollSepolia,
      transport: custom(provider),
      account: getAddress(userAddress.value),
    });
  }

  function setWalletConnected(isConnected) {
    walletConnected.value = isConnected;
  }

  async function disconnectUser() {

    await getProvider.value.request({
      method: 'wallet_revokePermissions',
      params: [{ eth_accounts: [getUserAddress.value] }],
    }).then((val) => {
      console.log(val);
    }).catch((e) => {
      console.log('got error: ', e.message);
    });

    provider.value = null;
    userAddress.value = '';
    walletClient.value = null;
    walletConnected.value = false;
  }


  return {
    userAddress,
    providerList,
    getProviders,
    getProvider,
    getWalletClient,
    getUserAddress,
    getWalletConnected,
    setProviderList,
    addToProviderList,
    setProvider,
    setWalletClient,
    setUserAddress,
    setWalletConnected,
    disconnectUser,
  };
});
