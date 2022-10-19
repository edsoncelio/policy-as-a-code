package main

import data.tags_validation

module_address[i] = address {
    changeset := input.resource_changes[i]
    address := changeset.address
}

tags_contain_minimum_set[i] = resources {
    changeset := input.resource_changes[i]
    tags := changeset.change.after.tags
    resources := [resource | resource := module_address[i]; not tags_validation.tags_contain_proper_keys(changeset.change.after.tags)]
}

tags_env_validation[i] = resources {
    changeset := input.resource_changes[i]
    tags  := changeset.change.after.tags
    resources := [resource | resource := module_address[i]; val := tags["env"]; not tags_validation.tags_env_proper_value(val)]
}


tags_name_validation[i] = resources {
    changeset := input.resource_changes[i]
    tags  := changeset.change.after.tags
    resources := [resource | resource := module_address[i]; val := tags["name"]; count(val) == 0]

}

deny[msg] {
    resources := tags_contain_minimum_set[_]
    resources != []
    msg := sprintf("Invalid tags (missing minimum required tags) for the following resources: %v", [resources])
}


deny[msg] {
    resources := tags_env_validation[_]
    resources != []
    msg := "Tag env need to be production or beta or qa or qa2 or qa9 or sandbox or central."
}

deny[msg] {
    resources := tags_name_validation[_]
    resources != []
    msg := "Tag name cannot be empty."
}