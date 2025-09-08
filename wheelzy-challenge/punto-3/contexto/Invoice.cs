namespace wheelzy_challenge.punto_3
{
    public class Invoice
    {
        public int Id { get; set; }
        public int? CustomerId { get; set; }
        public decimal Total { get; set; }
        public DateTime Date { get; set; }
    }
}