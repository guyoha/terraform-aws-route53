
module "dns_records" {
  source = "../"
  enable_alias_records = true
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

  zone_alias_records = {
    "testzone.com" = {
      "comment" = "test zone"
      "records" = [
        {name="",type="A",alias="dualstack.<ELB DNS>.", alias_elb_hosted_zone="<ELB Zone ID>", evaluate_target_health=false}
      ]
    }

  }

}

