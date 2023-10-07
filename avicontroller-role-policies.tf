# read the json policy doc
data "aws_iam_policy_document" "avicontroller_policy_data" {
  for_each                = { for idx, policy_name in toset(var.avicontroller_policies) : idx => policy_name }
  source_policy_documents = [file("${path.module}/iam-policies/${each.value}.json")]
}

# create the policy with the json data from policy file
resource "aws_iam_policy" "avicontroller_policy" {
  for_each    = { for idx, policy_name in toset(var.avicontroller_policies) : idx => policy_name }
  name        = each.value
  description = each.value
  policy      = data.aws_iam_policy_document.avicontroller_policy_data[each.key].json
  tags = {
    project = "avi-tanzu"
  }
  depends_on = [data.aws_iam_policy_document.avicontroller_policy_data]
}

output "avicontroller_policy_arns" {
  value = { for name, policy in aws_iam_policy.avicontroller_policy : name => policy.arn }
}

resource "aws_iam_role" "avicontroller_role" {
  name = "AviController-Refined-Role"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
  tags = {
    project = "avi-tanzu"
  }
}

resource "aws_iam_policy_attachment" "avicontroller_policy_attachment" {
  for_each   = { for idx, policy_name in toset(var.avicontroller_policies) : idx => policy_name }
  name       = "avicontroller-policy-attachment"
  roles      = [aws_iam_role.avicontroller_role.name]
  policy_arn = aws_iam_policy.avicontroller_policy[each.key].arn
}

resource "aws_iam_instance_profile" "avicontroller_instance_profile" {
  name = "AviController-Refined-Role"

  role = aws_iam_role.avicontroller_role.name
}

output "avicontroller-role_name" {
  value = aws_iam_role.avicontroller_role.name
}
output "avicontroller-role_arn" {
  value = aws_iam_role.avicontroller_role.arn
}
output "avicontroller-instance-profile_arn" {
  value = aws_iam_instance_profile.avicontroller_instance_profile.arn
}
