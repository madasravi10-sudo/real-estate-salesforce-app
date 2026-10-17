trigger RestrictCaseDelete on Case (before delete) {

    // Get current user's profile Id
    Id adminProfileId = [
        SELECT Id 
        FROM Profile 
        WHERE Name = 'System Administrator'
        LIMIT 1
    ].Id;

    // Check current user's profile
    if (UserInfo.getProfileId() != adminProfileId) {
        for (Case c : Trigger.old) {
            c.addError('Only System Administrator can delete Case records.');
        }
    }
}