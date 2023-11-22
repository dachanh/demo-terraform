# allocate Elastic IP address ,
resource "aws_eip" "nat" {
  # vpc   = true             # if false 
  count = var.subnet_count # the number of eleastic IP that is created 
}

# NAT gateway
# NAT gateway and NAT instance
# See comparison http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-nat-comparison.html

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = element(aws_eip.nat.*.id, count.index) #  Allocation ID of the Elastic IP address (EIP) that the NAT gateway should use
  subnet_id     = element(var.subnet_ids, count.index)
  count         = var.subnet_count
  depends_on    = [var.internet_gateway]
}



