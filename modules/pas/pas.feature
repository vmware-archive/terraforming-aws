Feature: PAS is securely configured by default
  Scenario: When using S3 we should always encrypt storage
    Given Terraform
    And a "aws_s3_bucket" of type "resource"
    And pending "we dont yet encrypt our s3 buckets by default"
    Then attribute "server_side_encryption_configuration" exists

  Scenario: we are using a single LB for each type of traffic: isoseg, web, tcp, ssh
    Given Terraform
    And a "aws_lb" of type "resource"
    When attribute "load_balancer_type" equals "network"
    Then it occurs exactly 4 times

  Scenario Outline: Every component of the PAS which needs a LB
    should have its IaaS configured as such

    Given Terraform
    And a "aws_security_group" of type "resource"
    And "our component is <component>"
    When attribute "ingress" exists
    Then attribute "ingress" matches regex "from_port.*<port>"
    And attribute "ingress" matches regex "to_port.*<port>"

    Given Terraform
    And a "aws_lb_listener" of type "resource"
    And "our component is <component>"
    When attribute "port" exists
    Then attribute "port" matches regex "<port>"

    Given Terraform
    And  a "aws_lb_target_group" of type "resource"
    And "our component is <component>"
    When attribute "port" exists
    Then attribute "port" matches regex "<port>"

    Examples:
    | port | component |
    | 443  | HttpS     |
    | 80   | Http      |
    | 1024 | TCP       |
    | 2222 | SSH       |
