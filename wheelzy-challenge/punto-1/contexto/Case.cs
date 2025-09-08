namespace wheelzy_challenge.punto_1
{
    public class Case
    {
        public int Id { get; set; }
        public int CarId { get; set; }
        public Car Car { get; set; }
        public ICollection<Quote> Quotes { get; set; } = new List<Quote>();
        public ICollection<CaseStatusHistory> CaseStatusHistories { get; set; } = new List<CaseStatusHistory>();
    }
}