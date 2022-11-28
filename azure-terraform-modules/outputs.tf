#allows us to expose outputs from the child modules
#this will expose the name of the created resources (if an an output file was associated with them)
#it allows you to call data back and pass them as output

output "StgActName" {
  value = module.StorageAccount.stg_act_name_out
}

output "RgName" {
  value = module.ResourceGroup.rg_name_out
}

/*
output "VnetName" {
  value = module.VirtualNetwork.vnet_name_out
}

output "Snet1ID" {
  value = module.VirtualNetwork.snet1_out
}

output "Snet2ID" {
  value = module.VirtualNetwork.snet2_out
}

output "VmName" {
  value = module.VirtualMachine.vm_name_out
}
*/