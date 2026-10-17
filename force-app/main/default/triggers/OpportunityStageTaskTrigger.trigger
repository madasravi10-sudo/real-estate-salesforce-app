trigger OpportunityStageTaskTrigger on Opportunity (after update) {

    List<Task> tasksToInsert = new List<Task>();

    for (Opportunity newOpp : Trigger.new) {
        Opportunity oldOpp = Trigger.oldMap.get(newOpp.Id);

        // Check if StageName is changed
        if (newOpp.StageName != oldOpp.StageName) {

            Task t = new Task();
            t.WhatId = newOpp.Id;                  // Related Opportunity
            t.Subject = 'Follow up on Stage Change';
            t.Status = 'Not Started';
            t.Priority = 'Normal';
            t.OwnerId = newOpp.OwnerId;
            t.ActivityDate = System.today().addDays(1);

            tasksToInsert.add(t);
        }
    }

    // Insert tasks only if list is not empty
    if (!tasksToInsert.isEmpty()) {
        insert tasksToInsert;
    }
}