
module "dns_records" {
  source = "../"
  zone_records = {
    "testzone.com" = {
      "comment" = "test zone"
      "records" = [
        {name="test_record1", type="A", ttl="300", values= ["127.0.0.1"]},
        {name="test_record2", type="CNAME", ttl="300", values= ["aws.alb.abc"]},
        {name="", type="MX", ttl="300", values=["10 aspmx.l.google.com.","20 alt2.aspmx.l.google.com."]}
      ]
    }
  }
}