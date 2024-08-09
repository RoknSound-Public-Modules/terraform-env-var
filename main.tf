variable "env_var" {
}

resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

data "external" "var" {
  program = ["python", "${path.module}/env-var.py"]

  query = {
    # arbitrary map from strings to strings, passed
    # to the external program as the data query.
    var   = var.env_var
    nonce = random_string.random.result
  }
}

output "value" {
  value = try(
    bool(data.external.var.result.value),
    data.external.var.result.value
  )
}

output "set" {
  value = data.external.var.result.varset == "set" ? true : false
}