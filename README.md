# Assumptions
For each developer focused lab:
- kubernetes cluster is deployed
- kubectl is configured and user is admin
- student has cloned the repo
- repo folder is locally named `kubernetes-training`
- student starts in directory `~/kubernetes-training/workspace/`
- Previous lab has deleted its kubernetes objects

# Lab Scripts
`start.sh <lab name>` - This script sets up a lab with required files and kubernetes objects. It requires a lab name as a parameter. The lab name must correspond with a folder name under `starting-points/`. The script does the following:
- copy contents of `starting-points/<lab name>/workspace` to the student `workspace` folder.
- creates starting point kubernetes objects with `kubectl apply -f starting-points/<lab name>/objects.yaml`


`cleanup.sh <lab name>` - this script backs up the students work and cleans up after a lab. It will destroy most kubernetes objects in the the students workspace. It will leave LoadBalancer services and ingress objects, as these objects take may take time to setup (usually because of IaaS activities). Backups of the working directory and kubernetes objects are stored in `~/workspace_backup/<lab name>`
