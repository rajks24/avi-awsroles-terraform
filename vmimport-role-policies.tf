# read the json policy doc
data "aws_iam_policy_document" "vmimport_policy_data" {
  for_each                = var.vmimport_policies
  source_policy_documents = [file("${path.module}/iam-policies/${each.value.policy}.json")]
}

# create the policy with the json data from policy file
resource "aws_iam_policy" "vmimport_policy" {
  for_each    = var.vmimport_policies
  name        = each.value.name
  description = each.value.description
  policy      = data.aws_iam_policy_document.vmimport_policy_data[each.key].json
  tags = {
    project = "avi-tanzu"
  }
  depends_on = [data.aws_iam_policy_document.vmimport_policy_data]
}

output "vmimport_policy_arns" {
  value = { for name, policy in aws_iam_policy.vmimport_policy : name => policy.arn }
}

resource "aws_iam_role" "vmimport" {
  name = "vmimport"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "vmie.amazonaws.com"
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : "vmimport"
            }
          }
        }
      ]
    }
  )
  tags = {
    project = "avi-tanzu"
  }
}

resource "aws_iam_policy_attachment" "vmimport_policy_attachment" {
  for_each   = var.vmimport_policies
  name       = "${each.value.name}-attachment"
  roles      = [aws_iam_role.vmimport.name]
  policy_arn = aws_iam_policy.vmimport_policy[each.key].arn
}

output "vmimport-role_name" {
  value = aws_iam_role.vmimport.name
}
output "vmimport-role_arn" {
  value = aws_iam_role.vmimport.arn
}
