namespace wheelzy_challenge.punto_4
{
    public class Order
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public int StatusId { get; set; }
        public DateTime Date { get; set; }
        public bool IsActive { get; set; }
        
        // Navigation properties
        public Customer Customer { get; set; }
        public Status Status { get; set; }
    }
}