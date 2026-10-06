# Deploying nerdworx.io

Same model as nerdworx.com: CI builds images to GHCR, and the cluster runs them
from a Helm release plus a Gateway and HTTPRoute applied with `kubectl`.

| Piece | Where |
|---|---|
| Images | `ghcr.io/nerdworxhq/nerdworx.io/nerdworx-io-{nginx,php}` (`:latest` from `main`, `:develop` from `develop`, plus a dated tag per build) |
| Helm chart | `.helm/nerdworx-io` with `.helm/values/nerdworx-io.yaml`, release `nerdworx-io` in namespace `nerdworx-io` |
| Web | Deployment `nerdworx-io` (nginx + php-fpm, 3 replicas). A `migrate` init container runs `php artisan migrate --force` before each pod starts |
| Queue | Deployment `nerdworx-io-queue` (1 replica, `php artisan queue:work`). Sends the onboarding notification emails |
| Ingress | `nerdworx-io-gateway.yaml` (Cilium Gateway, TLS from secret `nerdworx-io-cert`) and `nerdworx-io-httproute.yaml` |
| Database | Database `nerdworx_io` on the shared CNPG cluster `nerdworx-postgres-1` (`nerdworx-io-database.yaml`) |
| Config | ConfigMap `nerdworx-io-env-configmap`, key `nerdworx-io.env`, from `nerdworx-io.env.example` |

## First-time setup

1. **GitHub.** Create the `nerdworx.io` environment in the repo settings with a
   `GH_PAT_TOKEN` secret that can push tags and write packages. Then merge to
   `main`. The first run builds and pushes the PHP base image
   `ghcr.io/nerdworxhq/nerdworx.io/nerdworx-io-php-base-85:v1.0.0` (the
   nerdworx.com base plus `pdo_pgsql`) because it isn't in GHCR yet, then
   builds the app images from it. Later runs reuse it; to rebuild it after
   changing `.docker/php/k8sbase.dockerfile` or its scripts, run the workflow
   manually with **rebuild_base** checked.

2. **Database role.** In `nerdworx-talos-gitops`, add the role to the
   `nerdworx-postgres-1` Cluster spec and create its password secret in
   `cnpg-system`:

   ```yaml
   spec:
     managed:
       roles:
         - name: nerdworx_io
           ensure: present
           login: true
           passwordSecret:
             name: nerdworx-io-db
   ```

   ```sh
   kubectl -n cnpg-system create secret generic nerdworx-io-db \
     --type=kubernetes.io/basic-auth \
     --from-literal=username=nerdworx_io --from-literal=password='<password>'
   ```

   Once Flux reconciles the role, create the database:
   `kubectl apply -f nerdworx-io-database.yaml`.

3. **Namespace secrets.**

   ```sh
   kubectl -n nerdworx-io create secret tls nerdworx-io-cert --cert=nerdworx.io.crt --key=nerdworx.io.key
   kubectl -n nerdworx-com get secret ghcr-image-pull -o yaml \
     | sed 's/namespace: nerdworx-com/namespace: nerdworx-io/' \
     | grep -v -E '^\s+(uid|resourceVersion|creationTimestamp):' \
     | kubectl apply -f -
   ```

4. **Env.** `cp nerdworx-io.env.example nerdworx-io.env`, fill in `APP_KEY`
   (`php artisan key:generate --show`), `DB_PASSWORD`, the mail settings and
   `ONBOARDING_NOTIFY_EMAIL`, then:

   ```sh
   kubectl -n nerdworx-io create configmap nerdworx-io-env-configmap --from-file=nerdworx-io.env
   ```

5. **Install.**

   ```sh
   helm install nerdworx-io .helm/nerdworx-io -f .helm/values/nerdworx-io.yaml -n nerdworx-io
   kubectl apply -f nerdworx-io-gateway.yaml -f nerdworx-io-httproute.yaml
   ```

6. **DNS.** Point `nerdworx.io` at the Gateway's address:
   `kubectl -n nerdworx-io get gateway nerdworx-io-gateway`.

## Releasing

Merge to `main`, wait for CI, then pull the new `:latest`:

```sh
kubectl -n nerdworx-io rollout restart deploy/nerdworx-io deploy/nerdworx-io-queue
```

Pending migrations run in the first new web pod's init container.

To change env, recreate the ConfigMap
(`kubectl -n nerdworx-io create configmap nerdworx-io-env-configmap --from-file=nerdworx-io.env --dry-run=client -o yaml | kubectl apply -f -`)
and restart both deployments.
