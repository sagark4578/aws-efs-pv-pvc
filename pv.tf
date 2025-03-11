resource "kubectl_manifest" "persistent_volume" {
  yaml_body = <<YAML
apiVersion: v1
kind: PersistentVolume
metadata:
  name: var.name
spec:
  accessModes:
  - ReadWriteMany
  capacity:
    storage: 10Gi
  csi:
    driver: efs.csi.aws.com
    volumeHandle: ${data.terraform_remote_state.efs.outputs.efs_id}::${data.terraform_remote_state.efs.outputs.efs_access_point_id}
  persistentVolumeReclaimPolicy: Retain
  storageClassName: efs-sc
  volumeMode: Filesystem
 YAML
}

resource "kubectl_manifest" "persistent_volume_claims" {
  depends_on = [kubectl_manifest.persistent_volume]
  yaml_body  = <<YAML
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: var.name-claim
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: efs-sc
  resources:
    requests:
      storage: 10Gi
 YAML
}
