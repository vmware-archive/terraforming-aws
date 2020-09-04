Feature: RDS is secure by default 
  Scenario: We should always encrypt storage
    Given Terraform
    And a "aws_db_instance" of type "resource"
    And pending "we do not yet encrypt rds by default"
    When attribute "storage_encrypted" exists
    Then attribute "storage_encrypted" equals "true"

  Scenario: We should always restrict public access
    Given Terraform
    And a "aws_db_instance" of type "resource"
    When attribute "publicly_accessible" exists
    Then attribute "publicly_accessible" matches regex "false"
