namespace wheelzy_challenge.punto_1
{
    public class BuyerZipCode
    {
        public int Id { get; set; }
        public int BuyerId { get; set; }
        public int ZipCodeId { get; set; }
        public decimal QuoteAmount { get; set; }
        public Buyer Buyer { get; set; }
        public ZipCode ZipCode { get; set; }
        public ICollection<Quote> Quotes { get; set; } = new List<Quote>();
    }
}