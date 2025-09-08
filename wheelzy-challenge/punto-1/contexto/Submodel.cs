namespace wheelzy_challenge.punto_1
{
    public class Submodel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int ModelId { get; set; }
        public Model Model { get; set; }
        public ICollection<Car> Cars { get; set; } = new List<Car>();
    }
}