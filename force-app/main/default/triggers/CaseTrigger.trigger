trigger CaseTrigger on Case (after insert) {

    for (Case c : Trigger.new) {

        System.enqueueJob(
            new CasePriorityQueueable(c.Id)
        );
    }
}