namespace wheelzy_challenge.punto_1
{
    public class Make
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public ICollection<Model> Models { get; set; } = new List<Model>();
    }
}