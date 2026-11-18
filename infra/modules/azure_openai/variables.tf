variable "NAME" {
  type        = string
  description = "Azure OpenAI account name - must be globally unique"
}

variable "RESOURCE_GROUP_NAME" {
  type = string
}

variable "LOCATION" {
  type = string
}

variable "SKU_NAME" {
  type    = string
  default = "S0"
}

variable "DEPLOYMENT_NAME" {
  type        = string
  description = "Name you choose for the model deployment - this is the exact value that ends up as AZURE_OAI_DEPLOYMENT, not something Azure assigns"
}

variable "MODEL_NAME" {
  type    = string
  default = "gpt-4o-mini"
}

variable "MODEL_VERSION" {
  type    = string
  default = "2024-07-18"
}

variable "MODEL_CAPACITY" {
  type    = number
  default = 1
}

variable "TAGS" {
  type    = map(string)
  default = {}
}
