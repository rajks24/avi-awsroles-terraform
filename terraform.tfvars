# policy values for AviController
avicontroller_policies = {
  policy1 = {
    name        = "AviController-EC2-Policy"
    description = "EC2 policy for avicontroller"
    policy      = "avicontroller-ec2-policy"
  },
  policy2 = {
    name        = "AviController-S3-Policy"
    description = "S3 policy for avicontroller"
    policy      = "avicontroller-s3-policy"
  },
  policy3 = {
    name        = "AviController-IAM-Policy"
    description = "IAM policy for avicontroller"
    policy      = "avicontroller-iam-policy"
  },
  policy4 = {
    name        = "AviController-R53-Policy"
    description = "R53 policy for avicontroller"
    policy      = "avicontroller-r53-policy"
  },
  policy5 = {
    name        = "AviController-ASG-Policy"
    description = "ASG policy for avicontroller"
    policy      = "avicontroller-asg-policy"
  },
  policy6 = {
    name        = "AviController-SQS-SNS-Policy"
    description = "SQS-SNS policy for avicontroller"
    policy      = "avicontroller-sqs-sns-policy"
  },
  policy7 = {
    name        = "AviController-KMS-Policy"
    description = "KMS policy for avicontroller"
    policy      = "avicontroller-kms-policy"
  }
}

vmimport_policies = {
  policy1 = {
    name        = "vmimport"
    description = "vmimport role policy for avicontroller"
    policy      = "vmimport-role-policy"
  },
  policy2 = {
    name        = "AviController-vmimport-KMS-Policy"
    description = "vmimport kms policy for avicontroller"
    policy      = "avicontroller-kms-vmimport"
  },
}
