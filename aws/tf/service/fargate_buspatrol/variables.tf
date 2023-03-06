variable "resource_requirements" {
  description = "Object that describes cpu and memory requirements for ECS task and containers."
  type = object({
    bus_task = object({ cpu = number, memory = number })
  })
  default = {
    bus_task = { cpu = 4096, memory = 16384 }
  }
}
