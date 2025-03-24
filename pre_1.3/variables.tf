variable "url" {
  type = object({
    ssl  = bool
    host = optional(string)
    port = optional(number)
  })
}
