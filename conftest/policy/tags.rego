package tags_validation

minimum_tags = {"env", "name"}

available_envs = {"production", "sandbox", "development"} 

tags_contain_proper_keys(tags) {
    keys := {key | tags[key]}
    leftover := minimum_tags - keys
    leftover == set()
}

tags_env_proper_value(string) {
    available_envs[_] = string
}
