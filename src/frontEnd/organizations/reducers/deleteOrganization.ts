import { navTo } from "../../nav/navTo";
import { Organizations } from "../data/Organizations";

export const deleteOrganization = (state, organizationToDelete, title) => {
    const orgs:Organizations = state.organizations;
    const orgsWithSpecifiedOrgDeleted = orgs.filter((org) => org.href != organizationToDelete);
    const stateWithoutDeletedOrg = {
        ...state,
        organizations: orgsWithSpecifiedOrgDeleted,
        shouldShowSnackbar: true,
        snackbarText:  `${title} Deleted`
    };

    return navTo(stateWithoutDeletedOrg, "/");
};