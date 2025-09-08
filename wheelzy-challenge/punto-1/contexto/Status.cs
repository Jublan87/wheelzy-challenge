namespace wheelzy_challenge.punto_1
{
    public class Status
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public ICollection<CaseStatusHistory> CaseStatusHistories { get; set; } = new List<CaseStatusHistory>();
    }
}