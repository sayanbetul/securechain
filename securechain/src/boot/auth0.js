import { boot } from 'quasar/wrappers';
import { createAuth0 } from '@auth0/auth0-vue';
import { clientId, domain } from '../../secrets.json';


export default boot(async ({ app }) => {
  app.use(
    createAuth0({
      domain: domain,
      clientId: clientId,
      authorizationParams: {
        redirect_uri: window.location.origin,
      },
    }),
  );
});
