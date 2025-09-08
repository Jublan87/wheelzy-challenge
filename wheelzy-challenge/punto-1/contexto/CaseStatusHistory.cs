namespace wheelzy_challenge.punto_1
{
    public class CaseStatusHistory
    {
        public int Id { get; set; }
        public int CaseId { get; set; }
        public int StatusId { get; set; }
        public DateTime? StatusDate { get; set; }
        public DateTime CreatedDate { get; set; }
        public Case Case { get; set; }
        public Status Status { get; set; }
    }
}