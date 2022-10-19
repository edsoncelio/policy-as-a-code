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
    msg := sprintf("Tags invalidas! (faltando tags) nos seguintes recursos: %v", [resources])
}


deny[msg] {
    resources := tags_env_validation[_]
    resources != []
    msg := "A tag env precisa ser sandbox, development ou production."
}

deny[msg] {
    resources := tags_name_validation[_]
    resources != []
    msg := "A tag name não pode ser vazia."
}