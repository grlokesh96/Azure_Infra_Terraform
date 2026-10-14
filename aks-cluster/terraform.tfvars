subscription_id     = "a2b28c85-1948-4263-90ca-bade2bac4df4"
location            = "East US"
resource_group_name = "kml_rg_main-31a1bdd83e8e400b"
cluster_name        = "aks-dev"

# Replace with a globally unique name (lowercase letters and numbers).
acr_name = "lokeshacrdev12345"

# Restrict AKS API server access to trusted CIDR ranges only.
authorized_ip_ranges = ["203.0.113.10/32"]

system_node_count   = 2
user_min_node_count = 1
user_max_node_count = 2
