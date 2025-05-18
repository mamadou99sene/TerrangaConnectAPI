import { inject } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivateFn, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { AuthGuardData, createAuthGuard } from 'keycloak-angular';
import Keycloak from 'keycloak-js';


const isAccessAllowed = async (route: ActivatedRouteSnapshot, __: RouterStateSnapshot, authData: AuthGuardData): Promise<boolean | UrlTree> => {
  const { authenticated, grantedRoles } = authData;

  console.log(authData.keycloak.authenticated); //always false
  console.log(authenticated); //always false
  console.log(authData.grantedRoles.realmRoles)
   if (!authenticated) {
    const keycloak = inject(Keycloak);
    return await keycloak.login().then(() => true);
  }

  const requiredRole = route.data['role'];
  console.log(requiredRole)
  if (!requiredRole) {
    return false;
  }

  const hasRequiredRole = (role: string): boolean =>
    Object.values(grantedRoles.realmRoles).some((roles) => roles.includes(role));

  if (authenticated && hasRequiredRole(requiredRole)) {
    console.log((await authData.keycloak.loadUserProfile()).email)
    return true;
  }
  else
   {
    const router =inject(Router);
    router.navigateByUrl("/forbidden")
   }

  return Promise.resolve(false);
}

export const keycloakAppGuard = createAuthGuard<CanActivateFn>(isAccessAllowed);