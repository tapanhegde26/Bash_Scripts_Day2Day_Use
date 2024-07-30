from kubernetes import client, config

def get_resources_count():
    # Load kubeconfig
    config.load_kube_config()

    v1 = client.CoreV1Api()
    apps_v1 = client.AppsV1Api()
    batch_v1 = client.BatchV1Api()

    namespaces = [ns.metadata.name for ns in v1.list_namespace().items]

    resource_counts = {}

    resource_types = [
        ('pods', v1.list_namespaced_pod),
        ('services', v1.list_namespaced_service),
        ('configmaps', v1.list_namespaced_config_map),
        ('secrets', v1.list_namespaced_secret),
        ('deployments', apps_v1.list_namespaced_deployment),
        ('statefulsets', apps_v1.list_namespaced_stateful_set),
        ('daemonsets', apps_v1.list_namespaced_daemon_set),
        ('jobs', batch_v1.list_namespaced_job),
        ('cronjobs', batch_v1.list_namespaced_cron_job),
    ]

    for namespace in namespaces:
        resource_counts[namespace] = []
        for resource, list_fn in resource_types:
            count = len(list_fn(namespace).items)
            resource_counts[namespace].append([resource, count])

    return resource_counts

def main():
    resource_counts = get_resources_count()
    
    # Print the header
    header = f"{'Namespace':<25} | {'Resource':<20} | {'Count':<5}"
    separator = "-" * len(header)
    print(header)
    print(separator)
    
    # Print the rows
    for namespace, resources in resource_counts.items():
        for resource, count in resources:
            print(f"{namespace:<20} | {resource:<15} | {count:<5}")
        print("=" * len(header))  # Separator between namespaces

if __name__ == "__main__":
    main()
