public class CasePriorityQueueable implements Queueable {

    private Id caseId;

    public CasePriorityQueueable(Id caseId) {
        this.caseId = caseId;
    }

    public void execute(QueueableContext context) {

        Case c = [
            SELECT Id, CaseNumber, Description
            FROM Case
            WHERE Id = :caseId
        ];

        c.Description =
            'Processed by Queueable Apex - '
            + c.CaseNumber;

        update c;
    }
}