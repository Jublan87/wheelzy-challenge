namespace wheelzy_challenge.punto_1
{
    public class Quote
    {
        public int Id { get; set; }
        public int CaseId { get; set; }
        public int BuyerZipCodeId { get; set; }
        public bool IsCurrent { get; set; }
        public Case Case { get; set; }
        public BuyerZipCode BuyerZipCode { get; set; }
    }
}